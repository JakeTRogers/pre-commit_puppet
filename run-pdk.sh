#!/usr/bin/env bash

# This script is used to run the Puppet Development Kit (PDK).
# It is used as a pre-commit hook to ensure that the code is properly linted and tested before being committed.

set -o errexit
set -o pipefail
set -o nounset

die() {
  printf '%s\n' "$1" >&2
  exit 1
}

# exit if pdk command is not found
command which pdk &>/dev/null || die 'pdk command not found. see https://www.puppet.com/downloads/puppet-development-kit'


# Initialize all the option variables.
# This ensures we are not contaminated by variables from the environment.
puppet_strings=0
[ "$1" == "bundle" ] && puppet_strings=1

# run pdk with the provided arguments from pre-commit hook
pdk "$@"

if [ $puppet_strings -eq 1 ]; then
  # check if the working directory is dirty after running puppet strings
  if [ $(git status --porcelain | wc -l) -gt 0 ]; then
    die "puppet strings has modified the documentation. Please commit the updates before pushing."
  fi
fi
