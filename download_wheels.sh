#!/bin/bash

# Ensure the script exits if any command fails
set -e

# Usage message
function usage() {
    echo "Usage: $0 -p <python_version> -i <package_index> -l <platform> -m <package_name>"
    echo "Example: $0 -p 3.9 -i https://www.piwheels.org/simple -l linux_armv7l -m fastapi"
    exit 1
}

# Parse command line arguments
while getopts "p:i:l:m:" opt; do
    case $opt in
        p) PYTHON_VERSION="$OPTARG" ;;
        i) PACKAGE_INDEX="$OPTARG" ;;
        l) PLATFORM="$OPTARG" ;;
        m) PACKAGE_NAME="$OPTARG" ;;
        *) usage ;;
    esac
done

# Ensure all arguments are provided
if [ -z "$PYTHON_VERSION" ] || [ -z "$PACKAGE_INDEX" ] || [ -z "$PLATFORM" ] || [ -z "$PACKAGE_NAME" ]; then
    usage
fi

# Check if the virtual environment is empty (no installed packages)
if [ -z "$(pip freeze)" ]; then
    echo "Virtual environment is empty, proceeding..."
else
    echo "Virtual environment is not empty. Please run the script in an empty virtual environment."
    exit 1
fi

# Install the given package and its dependencies
pip install "$PACKAGE_NAME"

# Output all installed packages to requirements.txt
pip freeze > requirements.txt

# Prepare the download directory
DOWNLOAD_DIR="download"
if [ -d "$DOWNLOAD_DIR" ]; then
    rm -rf "$DOWNLOAD_DIR"
fi
mkdir "$DOWNLOAD_DIR"

# Download all wheels for the packages listed in requirements.txt
pip download \
    --index-url="$PACKAGE_INDEX" \
    --platform="$PLATFORM" \
    --python-version="$PYTHON_VERSION" \
    --abi="cp${PYTHON_VERSION//.}" \
    --no-deps \
    -r requirements.txt \
    -d "$DOWNLOAD_DIR"

# Explain the flags
# --index-url="$PACKAGE_INDEX"      : Specifies the package index URL (e.g., piwheels)
# --platform="$PLATFORM"            : Specifies the platform (e.g., linux_armv7l)
# --python-version="$PYTHON_VERSION": Specifies the Python version (e.g., 3.9)
# --abi="cp${PYTHON_VERSION//.}"    : Specifies the ABI for CPython (e.g., cp39)
# --no-deps                         : Downloads only the package, without dependencies
# -r requirements.txt               : Specifies the requirements file to download packages from
# -d "$DOWNLOAD_DIR"                : Specifies the directory to download the packages into

echo "Packages downloaded successfully into the '$DOWNLOAD_DIR' directory."

