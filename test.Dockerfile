FROM ubuntu:focal

ARG TAGS
ARG USERNAME=docker
EXPOSE 22

RUN apt update && apt install -y software-properties-common && apt-add-repository -y ppa:ansible/ansible && apt update && apt install -y curl git ansible sudo

RUN useradd -ms /bin/bash $USERNAME

USER $USERNAME
RUN mkdir /home/$USERNAME/.ssh

USER root
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL " >> /etc/sudoers

USER $USERNAME
ENV USER=$USERNAME

WORKDIR /usr/local/bin
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
