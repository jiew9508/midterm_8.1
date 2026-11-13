#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if [[ ! -f blog/bin/rails ]]; then
  echo 'First run: bash setup-cloud9.sh' >&2
  exit 1
fi
if [[ ! -f .local-admin.env ]]; then
  echo 'Admin credentials missing. Run bash setup-cloud9.sh or create .local-admin.env.' >&2
  exit 1
fi
set -a
source .local-admin.env
set +a
cd blog
exec bin/rails server -b 0.0.0.0 -p 8080
