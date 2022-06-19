# debian-rootfs-tools

> The Matrix that generate debian rootfs

## Run

`sudo ruby deboot.rb`

## Run manual for single arch

`debootstrap --cache-dir=$PWD/../cache --foreign --arch amd64 bullseye amd64`

## Related project

[distro-arch-rootfs](https://github.com/initdc/distro-arch-rootfs)
