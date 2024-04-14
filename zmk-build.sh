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

cd $west_build_execution_path

source ../.venv/bin/activate


task () {
    i=$1
    board=`yq e ".include[$i].board" $config_file_path`
    shield=`yq e ".include[$i].shield" $config_file_path`
    path="build/$i-$shield"

    echo "--------------------------------------------"
    echo "BOARD:  $board"
    echo "SHIELD: $shield"
    echo "PATH:   $path"
    echo "CONFIG: $config_folder"
    echo "--------------------------------------------"

    west build -d $path -b $board -- -DSHIELD="$shield" -DZMK_CONFIG=$config_folder
    

    cp "$path/zephyr/zmk.uf2 $zmk_builds_path/$out_folder/$board-$shield.uf2"
}

build_yaml_include_items=`yq '.include | length' $config_file_path`

if [ $build_yaml_include_items -le 0 ] ; then
  exit
fi

if [ $1 = "--clean" ]; then
    echo "Cleaning builds..."
    rm -rf $west_build_execution_path/build/*
fi

mkdir -p "$zmk_builds_path/$out_folder"

for element_index in `seq 1 $build_yaml_include_items`; do
    i=$((element_index - 1))
    task "$i" &
done

wait # wait for all pararell shield builds to finish
