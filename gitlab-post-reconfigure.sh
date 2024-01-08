#!/bin/bash

# Configure some basic GitLab parts
# Part of https://github.com/PeterMosmans/gitlab-demolab
#
# Copyright (C) 2022-2024 Peter Mosmans [Go Forward]
# SPDX-License-Identifier: GPL-3.0-or-later

set -e
gitlab-rails runner 'ApplicationSetting.last.update(signup_enabled: false)'
echo "Post Reconfigure Script successfully executed"
