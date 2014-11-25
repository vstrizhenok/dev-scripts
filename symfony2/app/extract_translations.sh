#!/bin/bash
DIR=`dirname $0`
PROJECT_DIR="${DIR}/.."

function display_help {
	echo "Usage:  <target_path> [<search_path>]"
	exit 1;
}

function get_absolute_path {
	path=$1
	if [ ! -z "${path}" ] && [ ! "${path:0:1}" = "/" ]; then
        	path="${PWD}/${path}"
	fi
	echo "${path}"
}

TARGET_DIR=$(get_absolute_path $1)
SEARCH_DIR=$(get_absolute_path $2)

if [ -z "${SEARCH_DIR}" ]; then
	SEARCH_DIR="${PROJECT_DIR}/vendor/oro"
fi

if [ ! -d "${SEARCH_DIR}" ]; then
	echo "Search directory is not found. Check you command line parameters for the right search path"
	display_help
fi

if [ ! -d "${TARGET_DIR}" ]; then 
	echo "You must specify target directory to extract files"
	display_help
fi

cd "${SEARCH_DIR}"

files=`find . | grep translations | grep en.yml`
for file in $files; do
	target_file="${TARGET_DIR}/${file}"
	target_dir=`dirname "${target_file}"`
	echo "Copy file ${file}"
	if [ ! -d "${target_dir}" ]; then
		mkdir -p "${target_dir}"
	fi
	cp "${file}" "${target_file}"
done
