FROM ubuntu:jammy

RUN apt update && apt install -y wget curl && apt clean

ARG HELPER_VERSION=1.1.1
RUN set -e \
    && curl -o /usr/bin/aws_signing_helper --fail https://rolesanywhere.amazonaws.com/releases/${HELPER_VERSION}/X86_64/Linux/aws_signing_helper \
    && chmod +x /usr/bin/aws_signing_helper

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh
