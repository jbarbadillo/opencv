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
run_command cmake -DWITH_LIBV4L=OFF -DCMAKE_BUILD_TYPE=Release -WITH_CUDA=ON -WITH_CUFFT=ON -WITH_CUBLAS=ON -WITH_QT=ON -WITH_TBB=ON ../
run_command make -j4
