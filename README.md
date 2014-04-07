# Setup

Build and install premake5 from the premake-dev hg branch.  An Arch Linux
PKGBUILD is [here](https://aur.archlinux.org/packages/premake5-hg/).

Clone this repository and its submodules and stop tracking:

    git clone --recursive https://github.com/mikezackles/premake-cpp-template.git your-project-dir
    git remote remove origin

# Build and Test Your Project

    premake5 && cd build && make
    bin/release/test
