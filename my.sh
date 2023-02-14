#!/bin/bash

set -x
set -e

PATH_TO_PROJECT=`pwd`/projects/credsweeper

# Build your docker image and fuzz targets:
python infra/helper.py build_image --no-pull --external $PATH_TO_PROJECT

python infra/helper.py build_fuzzers  --sanitizer memory --external $PATH_TO_PROJECT

#python infra/helper.py check_build --external $PATH_TO_PROJECT

python infra/helper.py run_fuzzer  --sanitizer memory --external $PATH_TO_PROJECT fuzz_credsweeper

#python infra/helper.py build_fuzzers --external --sanitizer coverage $PATH_TO_PROJECT

python infra/helper.py coverage --external $PATH_TO_PROJECT --fuzz-target=fuzz_credsweeper
#upd4cov
