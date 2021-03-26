FROM ubuntu:20.04

ARG TERRAFORM_RELEASE=0.14.8

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_RELEASE}/terraform_${TERRAFORM_RELEASE}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_RELEASE}_linux_amd64.zip \
    && mv terraform /usr/bin \
    && rm terraform_${TERRAFORM_RELEASE}_linux_amd64.zip