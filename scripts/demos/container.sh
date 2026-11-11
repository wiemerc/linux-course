#!/bin/bash

. ~/.local/lib/demo-magic.sh
TYPE_SPEED=8

# run the busybox container
clear
pei "podman run -d --name sleep-test --rm busybox:musl sleep infinity"
pei "podman ps"
pei "podman exec sleep-test ps -ef"
wait
pei "podman kill sleep-test"

# build, run and inspect the distroless container
wait
clear
cd
podman system prune --all --force > /dev/null
cat > Dockerfile-distroless <<EOF
FROM scratch
COPY /usr/bin/sleep /usr/bin/
COPY $(ldd /usr/bin/sleep | grep ld-linux | perl -nale 'print $F[0]') $(dirname $(ldd /usr/bin/sleep | grep ld-linux | perl -nale 'print $F[0]'))/
COPY /lib64/libc.so.6 /lib64/
ENTRYPOINT ["/usr/bin/sleep", "infinity"]
EOF
pei "cat Dockerfile-distroless"
wait
pei "podman build -t distroless-test -f /home/$(id -un)/Dockerfile-distroless /"
pei "podman run -d --name distroless-test --rm distroless-test"
pei "podman top distroless-test"
wait
pei "podman inspect -f '{{.State.Pid}}' distroless-test"
pid=$(podman inspect -f '{{.State.Pid}}' distroless-test)
pei "ls -l /proc/$pid/root/usr/bin"
pei "sudo nsenter -t $pid --net ip addr"
wait
pei "podman kill distroless-test"
