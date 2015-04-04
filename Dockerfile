FROM gliderlabs/alpine:3.1
RUN mkdir -p /app &&\
    chown daemon:daemon /app &&\
    sed -i.bak -e 's+daemon:x:2:2:daemon:+daemon:x:2:2:daemon:/app:/bin/bash+' /etc/passwd
WORKDIR /app
ENV HOME /app
RUN apk-install nodejs git python
USER daemon
RUN git clone https://github.com/bitpay/insight.git /app
RUN npm install
ENV INSIGHT_DB /data
VOLUME /data
EXPOSE 3000
CMD ["node", "insight.js"]
