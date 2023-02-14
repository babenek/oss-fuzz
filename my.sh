#!/bin/bash -eu
# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

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
