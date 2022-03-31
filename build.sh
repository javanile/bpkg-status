#!/usr/bin/env bash

tags="$(git ls-remote --tags --sort="v:refname" https://github.com/bpkg/bpkg.git | cut -d/ -f3 | tail -n3)"


