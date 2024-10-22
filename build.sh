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

### Build function
build_firmware() {
  i=$1
  board=$(yq e ".include[$i].board" "$build_config_path")
  shield=$(yq e ".include[$i].shield" "$build_config_path")
  path="build/$i-$shield"

  echo "--------------------------------------------"
  echo "CONFIG: '$build_config_path'"
  echo "OUTPUT: '$build_output_path'"
  echo "BOARD:  '$board'"
  echo "SHIELD: '$shield'"
  echo "PATH:   '$path'"
  echo "--------------------------------------------"

  west build -d "$path" -b "$board" -- -DSHIELD="$shield" -DZMK_CONFIG="$board_config_path"

  cp "$path/zephyr/zmk.uf2" "$build_output_path/$board-$shield.uf2"
}

### Init
cd "$west_execution_path" || exit
source "$zmk_firmware_repo_path/.venv/bin/activate"

### Get items to build
build_yaml_include_items=$(yq '.include | length' "$build_config_path")
echo "Items to build: $build_yaml_include_items"

if [ "$build_yaml_include_items" -le 0 ]; then
  echo "No items to build found in '$build_config_path'"
  exit
fi

mkdir -p "$build_output_path/$build_subdir_name"

### Build each firmware item
for element_index in $(seq 1 "$build_yaml_include_items"); do
  i=$((element_index - 1))
  build_firmware "$i" &
done

### Wait for all parallel builds to finish
wait
