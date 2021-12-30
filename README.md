# GoogleCloud_SDK
Docker Image Google Cloud SDK

# Build Image

    $ docker build -t gcsdk .

# Initialize Google Cloud SDK

    $ docker container run -it --name gcsdk gcsdk
    gcsdk$ gcloud init
