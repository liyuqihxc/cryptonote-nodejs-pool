# Why node:8 and not node:10? Because (a) v8 is LTS, so more likely to be stable, and (b) "npm update" on node:10 breaks on Docker on Linux (but not on OSX, oddly)
FROM node:8-slim

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD . /pool/
WORKDIR /pool/

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
  echo 'deb http://mirrors.163.com/debian/ jessie main non-free contrib' > /etc/apt/sources.list && \
  echo 'deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib' >> /etc/apt/sources.list && \
  echo 'deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib' >> /etc/apt/sources.list

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs-legacy npm git libboost1.55-all libssl-dev \
  && rm -rf /var/lib/apt/lists/* \
  && cp wait-for-it.sh /wait-for-it.sh && chmod +x /wait-for-it.sh \
  && npm install --registry=https://registry.npm.taobao.org

EXPOSE 8117
EXPOSE 3333
EXPOSE 5555
EXPOSE 7777

VOLUME ["/config"]

CMD node init.js -config=/config/config.json
