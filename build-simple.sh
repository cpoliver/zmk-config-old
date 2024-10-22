#!/bin/bash

### Paths
config_base_path=~/code/keyboards

zmk_config_repo_path="$config_base_path/zmk-config"
zmk_firmware_repo_path="$config_base_path/zmk"

west_execution_path="$zmk_firmware_repo_path/app"
board_config_path="$zmk_config_repo_path/config"
build_config_path="$zmk_config_repo_path/build.yaml"

build_subdir_name=$(date '+%Y-%m-%d--%H-%M-%S')
build_output_path="$zmk_config_repo_path/build/$build_subdir_name"

### Init
cd "$west_execution_path" || exit
source "$zmk_firmware_repo_path/.venv/bin/activate"

### Build
west build -p \
  -d "$build_output_path" \
  -b nice_nano_v2 -- \
  -DSHIELD="splitkb_aurora_corne_left nice_view_adapter nice_view" \
  -DZMK_CONFIG="$board_config_path"

# west build -d build/cl_studio -b nice_nano_v2 \
#   -S studio-rpc-usb-uart -- -DSHIELD=corne_left -DCONFIG_ZMK_STUDIO=y
