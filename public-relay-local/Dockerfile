FROM ubuntu

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl -y
RUN apt-get install redir -y
RUN apt-get install ping -y
RUN apt-get install net-tools -y

CMD ["/bin/bash"]