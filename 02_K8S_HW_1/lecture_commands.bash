# 01 groups demo
mkdir demo
cd demo
ls -l /sys/fs/cgroup/
sudo mkdir /sys/fs/cgroup/memory/demo
ls -l /sys/fs/cgroup/memory/demo/
cat /sys/fs/cgroup/memory/demo/memory.limit_in_bytes
#'sudo bash' on lecture, to automate i will run as separate script
sudo bash
echo 1k > /sys/fs/cgroup/memory/demo/memory.limit_in_bytes
echo $$
ps xa
echo $$ > /sys/fs/cgroup/memory/demo/tasks
ls
#should be killed right now

# namespace demo
ps xa
ip a
ll
sudo unshare --fork --pid --mount-proc --net bash
ps xa
ip a
ls
free -h
exit

# docker container
alias d=docker
d images
d pull busybox
d run busybox
d ps 
d ps -a
mkdir rootfs
d export ${CONTEINER_ID}|tar xf - -C rootfs
ls -l rootfs/

# rootfs runc
runc
runc spec
less config.json
sudo runc run demo
ip a
ps xa
ls -l /
ls -l /bin/sh
exit

# 
nano config.json 
# "terminal":false .... "args":["sh","-c","while true; do { echo -e 'HTTP/1.1 200 OK\n\nVersion: v1.0.0';}|nc -vlp 8000;done"]

# FOR NETWORK (homework)
sudo ip netns ls
sudo ip netns add busybox_network
sudo ip netns ls

sudo ip link add name veth-host type veth peer name veth-busybox

sudo ip link set veth-busybox netns busybox_network

sudo ip netns exec busybox_network ip addr add 192.168.2.1/24 dev veth-busybox

sudo ip netns exec busybox_network ip link set veth-busybox up

sudo ip netns exec busybox_network ip link set lo up

sudo ip link set veth-host up

sudo ip route add 192.168.2.1/32 dev veth-host

sudo ip netns exec busybox_network ip route add default via 192.168.2.1 dev veth-busybox

nano config.json 
# "type": "network", "path": "/var/run/netns/busybox_network"

sudo runc run demo &
