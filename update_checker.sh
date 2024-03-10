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
  curl --silent -L "https://registry.hub.docker.com/v2/repositories/$repository/$image/tags?page_size=100$expander" | jq --raw-output '.results[].name' | (grep -Ev '(beta|latest|nightly|rc|snapshot)' || true) | grep -P '^v?\d+\.\d+\.\d+' | sort -rV > templist
  if [[ -n $suffix ]]; then
    if [[ $suffix == nosuffix ]]; then
      latest=$(grep -P '^v?\d+\.\d+\.\d+$' templist | head -1)
    else
      latest=$(grep "$suffix$" templist | head -1)
    fi
  else
    latest=$(head -1 templist)
  fi
}

# Display version number from an environment file
check_env() {
  in_use=$(awk -F '=' "/$1_VERSION/{print \$2}" .env)
  if [ -n "$latest" ] && [ -n "$in_use" ]; then
    if [ "$latest" = "$in_use" ]; then
      echo -e "$COL_GREEN$in_use$COL_RESET is the latest version"
    else
      echo -e "$COL_RED$in_use$COL_RESET can be updated to $COL_BOLD$latest$COL_RESET"
    fi
  fi
}

# Display version number from a YAML file
check_tool() {
  in_use=$(awk -F ': ' "/$1_VERSION/{print \$2}" .gitlab-ci.yml)
  if [ -n "$in_use" ]; then
    if [ "$latest" = "$in_use" ]; then
      echo -e "$COL_GREEN$in_use$COL_RESET is the latest version"
    else
      echo -e "$COL_RED$in_use$COL_RESET can be updated to $COL_BOLD$latest$COL_RESET"
    fi
  else
    echo "Not defined in .gitlab-ci.yml"
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
check_pipeline() {
  if [ -f ".gitlab-ci.yml" ]; then
    show_latest_tags gofwd tools-image
    check_tool TOOLS
    show_latest_tags owasp dependency-check
    check_tool DEPENDENCY
    show_latest_tags wagoodman dive nosuffix
    check_tool DIVE
    show_latest_tags goodwithtech dockle nosuffix
    check_tool DOCKLE
    show_latest_tags hadolint hadolint debian
    check_tool HADOLINT
    show_latest_tags aquasec trivy nosuffix
    check_tool TRIVY
    show_latest_tags opensecurity njsscan
    check_tool NJSSCAN
    show_latest_tags owasp zap2docker-bare
    check_tool ZAP
  fi
}

check_lab
check_pipeline
