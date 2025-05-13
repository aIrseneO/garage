FROM python:3.11-slim-bullseye

RUN apt-get update \
    && apt-get install -y openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /run/sshd

EXPOSE 22

RUN useradd --home-dir /home/garage --create-home --groups sudo --shell /bin/bash garage \
    && echo "garage:password" | chpasswd \
    && mkdir /home/garage/.ssh \
    && ssh-keygen -t rsa -N "" -f /home/garage/.ssh/id_rsa \
    && chown garage:garage /home/garage/.ssh \
    && chmod 700 /home/garage/.ssh \
    && ssh-keygen -A \
    && sed --in-place 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed --in-place 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-D"]