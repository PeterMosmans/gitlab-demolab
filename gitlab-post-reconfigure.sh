#!/bin/bash
set -e
gitlab-rails runner 'ApplicationSetting.last.update(signup_enabled: false)'
echo "Post Reconfigure Script successfully executed"
