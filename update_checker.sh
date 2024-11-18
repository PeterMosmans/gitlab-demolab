#!/usr/bin/env bash
# Copyright (C) 2022-2024 Peter Mosmans [Go Forward]
# SPDX-License-Identifier: GPL-3.0-or-later

# Helper script to check whether new versions of Docker images are available.
# Part of https://github.com/PeterMosmans/gitlab-demolab

# shellcheck disable=SC2034

set +e

COL_BOLD="\033[1m"
COL_GREEN="\033[32m"
COL_RED="\033[0;31m"
COL_RESET="\033[0m"
COL_YELLOW="\033[0;33m"

temp_file=$(mktemp)

# Clean up temporary file when exiting
trap 'rm -f $temp_file' EXIT

# Determine latest tag and set the GLOBAL variable latest
show_latest_tags() {
  repository=$1
  image=$2
  suffix=$3
  latest=""
  echo -e "Showing results for: ${COL_BOLD}$repository/$image${COL_RESET}"
  if [[ $suffix != nosuffix ]]; then
    local expander="&name=$suffix"
  else
    local expander=""
  fi
  curl --silent -L "https://registry.hub.docker.com/v2/repositories/$repository/$image/tags?page_size=100$expander" | jq --raw-output '.results[].name' | (grep -Ev '(beta|latest|nightly|rc|snapshot)' || true) | grep -P '^v?\d+\.\d+\.\d+' | sort -rV > "$temp_file"
  if [[ -n $suffix ]]; then
    if [[ $suffix == nosuffix ]]; then
      latest=$(grep -P '^v?\d+\.\d+\.\d+$' "$temp_file" | head -1)
    else
      latest=$(grep "$suffix$" "$temp_file" | head -1)
    fi
  else
    latest=$(head -1 "$temp_file")
  fi
}

# Display version number from an environment file
check_env() {
  in_use=$(awk -F '=' "/$1_VERSION/{print \$2}" .env)
  if [ -n "$latest" ] && [ -n "$in_use" ]; then
    if [ "$latest" = "$in_use" ]; then
      echo -e "${COL_BOLD}.env${COL_RESET}: $COL_GREEN$in_use$COL_RESET is the latest version"
    else
      echo -e "${COL_BOLD}.env${COL_RESET}: $COL_RED$in_use$COL_RESET can be updated to $COL_BOLD$latest$COL_RESET"
    fi
  fi
}

# Display version number from a YAML file
check_tool() {
  config=$2
  if [ -z "$config" ]; then
    config=".gitlab.ci.yml"
  fi
  in_use=$(awk -F ': ' "/$1_VERSION/{print \$2}" "$config")
  if [ -n "$in_use" ]; then
    if [ "$latest" = "$in_use" ]; then
      echo -e "${COL_BOLD}$config${COL_RESET}: $COL_GREEN$in_use$COL_RESET is the latest version"
    else
      echo -e "${COL_BOLD}$config${COL_RESET}: $COL_RED$in_use$COL_RESET will be updated to $COL_BOLD$latest$COL_RESET"
      echo "Don't forget to test whether this version still works..."
      sed --in-place --expression "s/${in_use}/${latest}/" "${config}"
    fi
  fi
}

# Check for all defined images in the .env file
check_lab() {
  if [ -f ".env" ]; then
    show_latest_tags library docker dind
    check_env DIND
    show_latest_tags dependencytrack apiserver
    check_env DTRACK_API
    show_latest_tags dependencytrack frontend
    check_env DTRACK_FRONTEND
    show_latest_tags gitlab gitlab-ce
    check_env GITLAB
    show_latest_tags library sonarqube community
    check_env SONARQUBE
  fi
}

# Check for all defined images in the .gitlab-ci.yml file
check_pipelines() {
  show_latest_tags gofwd tools-image
  check_configs TOOL
  show_latest_tags owasp dependency-check
  check_configs DEPENDENCY
  show_latest_tags wagoodman dive nosuffix
  check_configs DIVE
  show_latest_tags goodwithtech dockle nosuffix
  check_configs DOCKLE
  show_latest_tags hadolint hadolint debian
  check_configs HADOLINT
  show_latest_tags aquasec trivy nosuffix
  check_configs TRIVY
  show_latest_tags opensecurity njsscan
  check_configs NJSSCAN
  show_latest_tags zaproxy zap-bare
  check_configs ZAP
}

check_configs() {
  # shellcheck disable=SC2044
  for conf in $(find . -type f -name '.gitlab-ci.yml'); do
    check_tool "$1" "$conf"
  done
}

# If command line parameters are used, try to find latest version
if [ $# -eq 1 ]; then
  echo -e "Usage: ${COL_BOLD}update_checker.sh${COL_RESET}"
  echo -e "       Determines whether latest image versions are in use\n"
  echo -e "       ${COL_BOLD}update_checker.sh${COL_RESET} REPOSITORY IMAGE"
  echo -e "       Displays latest image version of REPOSITORY/IMAGE on Docker Hub\n"
  exit 0
fi
if [ $# -eq 2 ]; then
  show_latest_tags "$1" "$2"
  echo "$latest"
  echo -e "\nLast 10 tags:"
  head -10 "$temp_file"
else
  check_lab
  check_pipelines
fi
