# Remote development environment for Clion and embedded

In Clion, we can use remote host to support the development. To understand the setup of the environment visit [this](https://blog.jetbrains.com/clion/2020/01/using-docker-with-clion/) official blog post. Recently, studying Igor's Viarcheichyk "Embedded Programmimg with modern C++ cooknook", I needed to have the necessary toolchain to compile for ARM.

# Steps

Build and run:
```
    docker build -t plusangel/remote-embedded-cpp-env:0.1 -f Dockerfile .
    docker run -d --cap-add sys_ptrace -p127.0.0.1:2222:22 --name clion_remote_embedded_env plusangel/remote-embedded-cpp-env:0.1
    ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:2222"
```
Stop:
```
    docker stop clion_remote_embedded_env
```

ssh credentials (test user):    user@password

# Maintainer
angelos plastropoulos