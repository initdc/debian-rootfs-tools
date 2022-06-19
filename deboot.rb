DEBIAN_REL = ["bullseye", "buster", "stretch", "sid", "bookworm"]
ARCH = ["i386", "amd64", "armhf", "arm64", "mips64el", "ppc64el", "riscv64", "s390x"]

def deboot (release, arch)
    `mkdir -p #{release}`
    Dir.chdir(release) do
        `mkdir -p #{arch}`
        rootfs_dir = arch
        
        cmd = "set -x; debootstrap --cache-dir=$PWD/../cache --foreign --arch #{arch} #{release} #{rootfs_dir}"
        IO.popen(cmd) do |r|
            puts r.readlines
        end

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