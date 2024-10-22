#!/bin/bash

## Flags
IS_DRY_RUN=false

if [ "$1" == "--dry-run" ]; then
  IS_DRY_RUN=true
fi

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
  shield_without_adapters=$(echo "$shield" | cut -d " " -f 1)

  # source_output_path="$west_execution_path/build/$i-$shield" #_without_adapters"
  source_output_path="$west_execution_path/build/$i-$shield_without_adapters"

  echo ""
  echo "CONFIG: '$build_config_path'"
  echo "OUTPUT: '$build_output_path'"
  echo "BOARD:  '$board'"
  echo "SHIELD: '$shield' ($shield_without_adapters)"
  echo "PATH:   '$source_output_path'"
  echo ""

  west build -p \
    -d "$source_output_path" \
    -b "$board" -- \
    -DSHIELD="\"$shield"\" \
    -DZMK_CONFIG="$board_config_path"
  # echo "$build_command" | pbcopy
  # exit

  copy_command="cp $source_output_path/zephyr/zmk.uf2 $build_output_path/$board-$shield.uf2"

  if [ "$IS_DRY_RUN" == true ]; then
    # printf 'west build -d %s -b %s -- -DSHIELD=%s -DZMK_CONFIG=%s' "$source_output_path" "$board" "$shield" "$board_config_path"
    # echo "cp $source_output_path/zephyr/zmk.uf2 $build_output_path/$board-$shield.uf2"
    echo "$build_command"
    echo "$copy_command"
  else
    # west build -d "$source_output_path" -b "$board" -- -DSHIELD="$shield" -DZMK_CONFIG="$board_config_path"
    # cp "$path/zephyr/zmk.uf2" "$build_output_path/$board-$shield.uf2"

    eval "$build_command"
    # eval "$copy_command"
  fi
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

if [ "$IS_DRY_RUN" == true ]; then
  echo "mkdir -p $build_output_path/$build_subdir_name"
else
  mkdir -p "$build_output_path/$build_subdir_name"
fi

### Build each firmware item
for element_index in $(seq 1 "$build_yaml_include_items"); do
  i=$((element_index - 1))
  build_firmware "$i" &
done

### Wait for all parallel builds to finish
wait
