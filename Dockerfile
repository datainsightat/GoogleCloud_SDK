FROM ubuntu:20.04

# #Hadoop
# EXPOSE 

ENV DEBIAN_FRONTEND noninteractive

ENV JAVA_VERSION=8
ENV JAVA_HOME=/usr/lib/jvm/java-$JAVA_VERSION-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:${PATH}"

ENV SSH_USER="root"

###########
# GENERAL #
###########

RUN apt-get update && \
    apt-get install -y wget curl openssh-server openssh-client net-tools

########
# JAVA #
########

RUN apt-get update && \
    apt-get -y install openjdk-$JAVA_VERSION-jdk openjdk-$JAVA_VERSION-jdk-headless

##########
# Python #
##########

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get install -y python3.8 python3-dev python3-pip python3-pycurl\
    && apt-get remove -y software-properties-common \
    && python3.8 -m pip install --upgrade pip --user

####################
# Google Cloud SDK #
####################
# https://cloud.google.com/sdk/docs/install#deb

RUN apt-get install -y apt-transport-https ca-certificates gnupg

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

RUN apt-get update && apt-get install -y \
    google-cloud-sdk

RUN apt-get update && apt-get install -y \
    google-cloud-sdk-app-engine-python \
    google-cloud-sdk-app-engine-python-extras \
    google-cloud-sdk-app-engine-java \
    google-cloud-sdk-app-engine-go \
    google-cloud-sdk-bigtable-emulator \
    google-cloud-sdk-cbt \
    google-cloud-sdk-cloud-build-local \
    google-cloud-sdk-datalab \
    google-cloud-sdk-datastore-emulator \
    google-cloud-sdk-firestore-emulator \
    google-cloud-sdk-pubsub-emulator \
    kubectl

# RUN gcloud init

# #Run at container start
# CMD ["bin/bash","docker_start.sh"]