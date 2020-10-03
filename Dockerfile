# CLion remote docker environment for embedded development (How to build docker container, run and stop it)
#
# Build and run:
#   docker build -t plusangel/remote-embedded-cpp-env:0.1 -f Dockerfile .
#   docker run -d --cap-add sys_ptrace -p127.0.0.1:2222:22 --name clion_remote_embedded_env plusangel/remote-embedded-cpp-env:0.1
#   ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:2222"
#
# stop:
#   docker stop clion_remote_embedded_env
#
# ssh credentials (test user):
#   user@password

FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y crossbuild-essential-armel \
    gdb \
    gdb-multiarch \
    cmake \
    ssh \
    rsync \
    tar \
    && apt-get clean

RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
    ) > /etc/ssh/sshd_config_test_clion \
    && mkdir /run/sshd

RUN useradd -m user \
  && yes password | passwd user

CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]