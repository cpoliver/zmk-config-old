#!/bin/bash

# requires yq, see: https://github.com/mikefarah/yq/#install
# the only argument is --clean, which will remove the build folder before building

# This script builds the ZMK firmware for all the boards in the ZMK config file, just like github actions.
# Path variables, change if you have a different paths
zmk_config_path=~/code/zmk-config
zmk_repo_path=~/code/zmk
zmk_builds_path="$zmk_config_path/builds"

west_build_execution_path="$zmk_repo_path/app"
config_file_path="$zmk_config_path/build.yaml"
config_folder="$zmk_config_path/config"

out_folder=$(date '+%Y-%m-%d--%H-%M-%S')

echo "--------------------------------------------"
echo "BOARD:  $board"
echo "SHIELD: $shield"
echo "PATH:   $path"
echo "CONFIG: $config_folder"
echo "--------------------------------------------"


cd $west_build_execution_path

source "$zmk_repo_path/.venv/bin/activate"

west build -d build/left  -b nice_nano_v2 -- -DSHIELD="splitkb_aurora_corne_left nice_view_adapter nice_view" -DZMK_CONFIG="$zmk_config_path"

west build -d build/right -b nice_nano_v2 -- -DSHIELD="splitkb_aurora_corne_right nice_view_adapter nice_view" -DZMK_CONFIG="$zmk_config_path"