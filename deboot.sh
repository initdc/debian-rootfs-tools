#! /bin/sh

DEBIAN_REL=("bullseye" "buster" "stretch" "sid" "bookworm")
ARCH=("i386" "amd64" "armhf" "arm64" "mips64el" "ppc64el" "riscv64" "s390x")

deboot() {
    local release=$1
    local arch=$2
    mkdir -p ${release}
    cd ${release}
    mkdir -p ${arch}
    rootfs_dir=${arch}
    set -x
    debootstrap --cache-dir=$PWD/../cache --foreign --arch ${arch} ${release} ${rootfs_dir}
}

main() {
    for rel in ${DEBIAN_REL}; do
        for arch in ${ARCH}; do
            deboot ${rel} ${arch}
        done
    done
}

main "$@"
