FROM ubuntu:18.04
MAINTAINER psteger.com <ps@psteger.com>
RUN apt-get update && apt-get install -y wget mariadb-server && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /root
COPY setup.sh /root
COPY start.sh /root
RUN chmod +x setup.sh
RUN chmod +x start.sh
EXPOSE 80
ENTRYPOINT /root/setup.sh && /root/start.sh && /bin/bash
