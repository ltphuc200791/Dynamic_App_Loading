#! bash

export PATH=$PATH:/Applications/MCUXpressoIDE_11.3.1_5262/ide/plugins/com.nxp.mcuxpresso.tools.macosx_11.3.0.202011031536/tools/bin/
PRJ_DIR=$PWD

rm -rf ./apps/build ./build 

echo 1. Build libsys_module
mkdir -p $PRJ_DIR/build/userlib
cd $PRJ_DIR/build/userlib
cmake $PRJ_DIR -DTARGET_GROUP=userlib -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=$PRJ_DIR/cross.cmake
make -j
cp -R lib $PRJ_DIR/apps/


echo 2. Build app
mkdir -p $PRJ_DIR/build/app && cd $PRJ_DIR/build/app
cmake $PRJ_DIR/apps -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=$PRJ_DIR/cross.cmake
make -j
python3 $PRJ_DIR/elf2tinf/elf2tinf.py --major 1 --minor 0 blinky.elf blinky

echo 3. Build kernel
mkdir -p $PRJ_DIR/build/debug && cd $PRJ_DIR/build/debug
cmake $PRJ_DIR -DTARGET_GROUP=kernel -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=$PRJ_DIR/cross.cmake
make -j 

