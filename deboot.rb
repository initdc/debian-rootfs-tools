DEBIAN_REL = ["bullseye", "buster", "stretch", "sid", "bookworm"]
# riscv64 is NOT supported by official, ref: https://www.debian.org/ports/
ARCH = ["i386", "amd64", "armhf", "arm64", "mips64el", "ppc64el", "s390x"]

def deboot (release, arch)
    `mkdir -p #{release}`
    Dir.chdir(release) do
        `mkdir -p #{arch}`
        rootfs_dir = arch
        
        cmd = "set -x; debootstrap --cache-dir=$PWD/../cache --foreign --arch #{arch} #{release} #{rootfs_dir}"
        IO.popen(cmd) do |r|
            puts r.readlines
        end

        `chroot #{rootfs_dir} /bin/sh -c "rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/*"`

        Dir.chdir(rootfs_dir) do 
            `tar -zcvf $PWD/../../output/debian_#{release}_#{arch}_$(date +%Y-%m-%d).tgz .`
        end
    end
end

for rel in DEBIAN_REL do
    for arch in ARCH do
        deboot(rel, arch)
    end
end