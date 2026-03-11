FROM docker.io/python:3.14-slim-trixie

LABEL Maintainer="Mark Taguiad <marktaguiad@marktaguiad.dev>"
LABEL Description="Ansible Debian"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /ansible

RUN apt update -y && \
    apt install -y sshpass git tree curl python3-libvirt python3-lxml

RUN pip install --upgrade pip
RUN pip install ansible ansible-core argcomplete jmespath requests passlib

RUN mkdir -p /app
COPY ./docker/entrypoint.sh /app
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
