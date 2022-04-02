#!/usr/bin/env bash
set -e

rm -fr .github/workflows/*.yml

tags="$(git ls-remote --tags --sort="v:refname" https://github.com/bpkg/bpkg.git | cut -d/ -f3 | tail -n2)"

while IFS= read -r line || [[ -n "${line}" ]]; do
  [[ -z "${line}" ]] && continue
  [[ "${line::1}" == "#" ]] && continue

  name=$(echo $line | cut -d'#' -f1 | xargs)
  title=$(echo $line | cut -d'#' -f2 | xargs)
  platform=$(echo $line | cut -d'#' -f3 | xargs)
  image=$(echo $line | cut -d'#' -f4 | xargs)
  bootstrap=$(echo "$line" | cut -d'#' -f5 | xargs)


  echo "$bootstrap"

  sed -e 's!%name%!'"${name}"'!' \
      -e 's!%title%!'"${title}"'!' \
      -e 's!%platform%!'"${platform}"'!' \
      -e 's!%image%!'"${image}"'!' \
      -e 's!%bootstrap%!'"${bootstrap}"'!' \
      -r Environment.template.yml > ".github/workflows/${name}.yml"

done < "Environment"
