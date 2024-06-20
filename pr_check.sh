#!/bin/bash

# --------------------------------------------
# Export vars for helper scripts to use
# --------------------------------------------
# name of app-sre "application" folder this component lives in; needs to match for the push to quay.
export COMPONENT="frontend-common-test"
# Needs to match the quay repo name set by app.yaml in app-interface
export IMAGE="quay.io/cloudservices/frontend-common-test"
export WORKSPACE=${WORKSPACE:-$APP_ROOT}  # if running in jenkins, use the build's workspace
export APP_ROOT=$(pwd)
export NODE_BUILD_VERSION=18
COMMON_BUILDER=https://raw.githubusercontent.com/RedHatInsights/insights-frontend-builder-common/master

set -exv
# source is preferred to | bash -s in this case to avoid a subshell
source <(curl -sSL $COMMON_BUILDER/src/frontend-build.sh)
BUILD_RESULTS=$?

# Stubbed out for now, will be added as tests are enabled
mkdir -p $WORKSPACE/artifacts
cat << EOF > $WORKSPACE/artifacts/junit-dummy.xml
<testsuite tests="1">
    <testcase classname="dummy" name="dummytest"/>
</testsuite>
EOF

exit $BUILD_RESULTS
