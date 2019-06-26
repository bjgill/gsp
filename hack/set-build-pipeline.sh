#!/bin/bash

set -eu -o pipefail

: "${USER_CONFIGS:?}"

PIPELINE_NAME="build"
CLUSTER_NAME="verify" # There is no better way at the moment :(

echo "generating approvers for build pipeline..."

approvers="/tmp/gsp-build-approvers.yaml"
echo -n "github-approvers: " > "${approvers}"
yq . ${USER_CONFIGS}/*.yaml \
	| jq -c -s "[.[] | select(.roles[] | select((. == \"${CLUSTER_NAME}-sre\" ) or (. == \"${CLUSTER_NAME}-admin\"))) | .github] | unique | sort" \
	>> "${approvers}"

trusted="/tmp/gsp-build-keys.yaml"
echo -n "trusted-developer-keys: " > "${trusted}"
yq . ${USER_CONFIGS}/*.yaml \
	| jq -c -s '[ .[].pub ] | sort' \
	>> "${trusted}"

fly -t cd-gsp sync

fly -t cd-gsp set-pipeline -p "${PIPELINE_NAME}" \
	--config "pipelines/build/build.yaml" \
	--load-vars-from "${approvers}" \
	--load-vars-from "${trusted}" \
	--check-creds "$@"

fly -t cd-gsp expose-pipeline -p "${PIPELINE_NAME}"

