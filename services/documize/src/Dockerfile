FROM debian:latest
RUN apt-get update
RUN apt-get install -y wget
RUN wget https://community-downloads.s3.us-east-2.amazonaws.com/documize-community-linux-amd64
RUN chmod 777 ./documize-community-linux-amd64
ENTRYPOINT [ "./documize-community-linux-amd64" ] 