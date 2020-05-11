#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

while getopts ":r:p:" opt; do
  case $opt in
    r) path_to_req="$OPTARG"
    ;;
    p) path_to_venv="$OPTARG"
    ;;
    \?) die "Invalid option -$OPTARG"
    ;;
  esac
done

# default values
: ${path_to_req="./requirements.txt"}
: ${path_to_venv="./venv/"}

# check if exists
exit_check=1

if [[ ! -d $path_to_venv ]]; then
  echo "$path_to_venv does not exist."
  exit_check=0
fi
if [[ ! -f $path_to_req ]]; then
  echo "creating requirements file at $path_to_req"
  touch $path_to_req
fi

if [[ $exit_check -eq 0 ]]; then
  die "Exiting"
fi

cp /Volumes/dev/dev/bash/upgradevenv/pip /Volumes/dev/dev/bash/upgradevenv/pip.sub

#replace appropriate paths
sed -i '' 's, REPLACE, '"\'$path_to_req\'"',' /Volumes/dev/dev/bash/upgradevenv/pip.sub
sed -i '' 's, REPLACE_PYTHON, '"\'$path_to_venv/bin/python\'"',' /Volumes/dev/dev/bash/upgradevenv/pip.sub

#move to inside venv
mv /Volumes/dev/dev/bash/upgradevenv/pip.sub "$path_to_venv/bin/pip"
