#!/usr/bin/env bash
# Prepares a fresh copy of the project: dependencies, the test browser, then the check command.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

npm ci
npm run browsers:install
npm run check
