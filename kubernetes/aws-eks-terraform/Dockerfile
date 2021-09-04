
# Levanto un amazonlinux para instalar las herramientas que necesito y pasarlos a la imagen final
FROM amazonlinux:2.0.20210721.2 as builder

# Instalar todas las herramientas en la imagen builder, Terraform y Kubectl
RUN yum install -y tar git unzip \
    && curl -o /tmp/terraform.zip -LO https://releases.hashicorp.com/terraform/1.0.5/terraform_1.0.5_linux_amd64.zip \
    && unzip /tmp/terraform.zip \
    && chmod +x terraform && mv terraform /usr/local/bin/ \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin 
    


# Multi-stage build donde vuelco todo lo que necesito
FROM alpine:3.13 as pivoteks

# Copio todo desde builder, instalo herramientas, limpio y defino desde donde y como arrancarlo
COPY --from=builder /usr/local/bin /usr/local/bin
COPY . /scaryterry
RUN apk add --no-cache git &&\
    apk add --no-cache aws-cli
WORKDIR /scaryterry
ENTRYPOINT /bin/sh