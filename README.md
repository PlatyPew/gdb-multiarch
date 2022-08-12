# Docker image for gdb-multiarch for Arch Linux

Both aarch64 and x86_64 is supported

```sh
# How to build the image
docker build -t platypew/gdb-multiarch:latest .

# Alternatively, you can pull from docker hub
docker pull platypew/gdb-multiarch:latest
```

You can remove the file and extract it from the docker image

```sh
docker create --name gdb-multiarch platypew/gdb-multiarch:latest foo

docker cp gdb-multiarch:/gdb-multiarch.tgz .
```

You can install it into your Arch system by doing 

```sh
sudo tar -xzf gdb-multiarch.tgz -C /
```
