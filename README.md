# Python Package Downloader Script

This bash script allows you to download Python packages and their dependencies into a directory for offline installation on different platforms and Python versions. It is especially useful for environments with limited internet access, such as Raspberry Pi devices or specific Linux distributions.

## Features

- **Checks if the virtual environment is empty** before proceeding with the installation.
- **Installs the specified Python package** and its dependencies into the virtual environment.
- **Generates a `requirements.txt` file** with all installed packages.
- **Downloads all required packages** as `.whl` files for the specified platform and Python version.
- **Supports multiple platforms and Python versions** through command-line arguments.

## Usage

```bash
./download_packages.sh -p <python_version> -i <package_index> -l <platform> -m <package_name>
```

### Command-Line Arguments

- `-p <python_version>`: Specifies the Python version (e.g., 3.9).
- `-i <package_index>`: Specifies the package index URL (e.g., `https://www.piwheels.org/simple` or `https://pypi.org/simple`).
- `-l <platform>`: Specifies the platform for which to download packages (e.g., `linux_armv7l` for Raspberry Pi or `manylinux2014_x86_64` for x86_64).
- `-m <package_name>`: The name of the Python package to install and download (e.g., `fastapi`).

## Cleaning a Virtual Environment

Before running the script, it's important to ensure that your virtual environment is clean (i.e., no packages installed). You can clean your virtual environment using the following command:

```bash
pip uninstall -y -r <(pip freeze)
```

## Use Cases

### 1. Downloading Packages for Raspberry Pi 4 using piwheels

This use case is for downloading packages for a Raspberry Pi 4 (ARM architecture) running Python 3.9, using the piwheels package index.

```bash
./download_packages.sh -p 3.9 -i https://www.piwheels.org/simple -l linux_armv7l -m fastapi
```

**Explanation:**

- `-p 3.9`: Target Python 3.9.
- `-i https://www.piwheels.org/simple`: Use the piwheels package index optimized for Raspberry Pi.
- `-l linux_armv7l`: Target the ARMv7 platform, which is the architecture of the Raspberry Pi 4.
- `-m fastapi`: The package to download (including all dependencies).

### 2. Downloading Packages for Debian 11 (x86_64) from PyPI

This use case is for downloading packages for a Debian 11 system with x86_64 architecture, using the default PyPI package index.

```bash
./download_packages.sh -p 3.9 -i https://pypi.org/simple -l manylinux2014_x86_64 -m fastapi
```

**Explanation:**

- `-p 3.9`: Target Python 3.9.
- `-i https://pypi.org/simple`: Use the default PyPI package index.
- `-l manylinux2014_x86_64`: Target the x86_64 platform, which is the common architecture for most desktop and server systems.
- `-m fastapi`: The package to download (including all dependencies).

### 3. Downloading Packages for Debian 8 (x86_64) from PyPI

This use case is similar to Debian 11 but targets an older Debian 8 system.

```bash
./download_packages.sh -p 3.4 -i https://pypi.org/simple -l manylinux1_x86_64 -m fastapi
```

**Explanation:**

- `-p 3.4`: Target Python 3.4 (default for Debian 8).
- `-i https://pypi.org/simple`: Use the default PyPI package index.
- `-l manylinux1_x86_64`: Target the x86_64 platform, with compatibility for older manylinux1 binaries.
- `-m fastapi`: The package to download (including all dependencies).

### 4. Downloading Packages for a Custom Platform and Python Version

In this use case, you can specify a custom platform and Python version, for example, if you're working with a specific Linux distribution or a Python version installed manually.

```bash
./download_packages.sh -p 3.8 -i https://pypi.org/simple -l manylinux2010_x86_64 -m flask
```

**Explanation:**

- `-p 3.8`: Target Python 3.8.
- `-i https://pypi.org/simple`: Use the default PyPI package index.
- `-l manylinux2010_x86_64`: Target the x86_64 platform compatible with manylinux2010 binaries.
- `-m flask`: The package to download (including all dependencies).

#### Popular Package Indices and Their Preferred Use Cases

- **PyPI (https://pypi.org/simple):**
  - **Use Case:** General-purpose package index for most Python environments.
  - **Platform Arguments:** `manylinux2014_x86_64`, `manylinux2010_x86_64`, `win_amd64`, `macosx_10_9_x86_64`, etc.

- **piwheels (https://www.piwheels.org/simple):**
  - **Use Case:** Optimized for Raspberry Pi and other ARM-based devices.
  - **Platform Arguments:** `linux_armv7l`, `linux_aarch64`.

- **Anaconda (https://repo.anaconda.com/pkgs/main):**
  - **Use Case:** Package index for data science and machine learning libraries, often used in Anaconda environments.
  - **Platform Arguments:** `linux-64`, `win-64`, `osx-64`.

#### Typical Platform Arguments

- `manylinux2014_x86_64`: Suitable for modern 64-bit Linux systems.
- `manylinux2010_x86_64`: Suitable for older 64-bit Linux systems.
- `linux_armv7l`: Suitable for ARMv7 architectures, such as Raspberry Pi 3 and 4.
- `linux_aarch64`: Suitable for 64-bit ARM architectures.
- `win_amd64`: Suitable for 64-bit Windows systems.
- `macosx_10_9_x86_64`: Suitable for macOS systems.

## Notes

- The script must be run in an **empty virtual environment** to ensure that no existing packages interfere with the installation process.
- If the download directory already exists, it will be deleted before starting the download process.
- All downloaded packages will be stored in the `download` subdirectory, which can be used for offline installation on other systems.
