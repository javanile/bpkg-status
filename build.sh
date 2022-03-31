#!/usr/bin/env bash
set -e

rm -fr .github/workflows/*.yml

tags="$(git ls-remote --tags --sort="v:refname" https://github.com/bpkg/bpkg.git | cut -d/ -f3 | tail -n2)"

while IFS= read line || [[ -n "${line}" ]]; do
  [[ -z "${line}" ]] && continue
  [[ "${line::1}" == "#" ]] && continue

  name=$(echo $line | cut -d'#' -f1 | xargs)

  sed -e 's!%%VT_VERSION%%!'"${version}"'!' \
          -e 's!%%VT_DOWNLOAD%%!'"${download}"'!' \
          -e 's!%%VT_DIRECTORY%%!'"${directory}"'!' \
          -e 's!%%DATABASE_PACKAGE%%!'"${database_package}"'!' \
          -e 's!%%PHP_VERSION%%!'"${php_version}"'!' \
          -r Environment.template.yml > ".github/workflows/${name}.yml"

done < "Environment"
