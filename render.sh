#!/bin/bash

set -e
echo "Using env vars from .env"

export $(grep -v '^#' .env | xargs)

for file in *.yaml.template; do
  output="${file%.template}"
  envsubst < "$file" > "$output"
  echo "Rendered $output"
done
