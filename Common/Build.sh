#!/usr/bin/env bash

# Clone Kernel
git clone --recursive --depth=1 -j $(nproc) $REPO -b $BRANCH $KERNELNAME
cd $KERNELNAME

# Clone Clang
git clone --recursive --depth=1 -j $(nproc) $CLANGREPO -b $CLANGBRANCH clang
PATH="${PWD}/clang/bin:${PATH}"

IMAGE=$(pwd)/out/arch/arm64/boot/Image.gz-dtb
DATE=$(date +"%Y%m%d-%H%M")
START=$(date +"%s")
KERNEL_DIR=$(pwd)
ARCH=arm64
export ARCH
KBUILD_BUILD_HOST="RenzAlt"
export KBUILD_BUILD_HOST
KBUILD_BUILD_USER="KernelCI"
export KBUILD_BUILD_USER

# Compile
compile() {

    if [ -d "out" ]; then
        rm -rf out && mkdir -p out
    fi

    make O=out ARCH="${ARCH}"
    make $DEFCONFIG O=out
    make -j $(nproc --all) O=out \
        ARCH=$ARCH \
        CC="clang" \
        AR="llvm-ar" \
        NM="llvm-nm" \
        OBJCOPY="llvm-objcopy" \
        OBJDUMP="llvm-objdump" \
        READELF="llvm-readelf" \
        OBJSIZE="llvm-size" \
        STRIP="llvm-strip" \
        LLVM_AR="llvm-ar" \
        LLVM_DIS="llvm-dis" \
        CROSS_COMPILE=aarch64-linux-gnu- \
        CROSS_COMPILE_ARM32=arm-linux-gnueabi-

    if ! [ -a "$IMAGE" ]; then
        finderr
        exit 1
    fi

    git clone --depth=1 https://github.com/ALprjkt/Anykernel3 AnyKernel -b ysl 
    cp out/arch/arm64/boot/Image.gz-dtb AnyKernel
}

# Zipping
zipping() {
    cd AnyKernel || exit 1
    zip -Alts kernel-testing-$DEVICENAME-"${DATE}".zip ./*
    cd ..
}

compile
zipping
END=$(date +"%s")
DIFF=$((END - START))
