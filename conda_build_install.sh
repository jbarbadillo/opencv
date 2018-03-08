#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function run_command
{
    "$@" || {
        echo -e "${RED}Command execution failure${NC}"
        exit 1
    }
}

run_command mkdir build
run_command cd build
echo -e "${GREEN}Change dir...${NC}"
echo -e "${GREEN}MAKE OPENCV...${NC}"
run_command cmake -D CMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=/usr/local \
-D CMAKE_INSTALL_PREFIX=$(python -c "import sys; print(sys.prefix)") \
-DPYTHON_EXECUTABLE=$(which python) \
-DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-DPYTHON2_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
-DPYTHON_LIBRARY=$(python -c 'from distutils import sysconfig; print sysconfig.get_config_var("LIBDIR")')/libpython2.7.so \
-DWITH_LIBV4L=OFF \
-WITH_CUDA=OFF \
-WITH_CUFFT=ON \
-WITH_CUBLAS=ON \
-WITH_QT=ON \
-WITH_TBB=ON \
..
run_command make -j4
run_command make install