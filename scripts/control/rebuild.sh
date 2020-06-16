#!/bin/bash
set -eo pipefail

scripts/install/checks.sh
if [[ $? -ne 0 ]]; then
  exit 1
fi

scripts/control/clean.sh

target=${1-prod}

scripts/install/backend.sh $target
scripts/install/workers.sh $target
scripts/install/frontend.sh

echo
echo "Checking database version..."
augur db check-for-upgrade