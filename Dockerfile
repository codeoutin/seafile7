FROM ubuntu:18.04
MAINTAINER psteger.com <ps@psteger.com>
RUN apt-get update && apt-get install -y wget mariadb-server && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /root
COPY setup.sh /root
RUN chmod +x setup.sh
EXPOSE 80
ENTRYPOINT /root/setup.sh && /bin/bash
