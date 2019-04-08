FROM alpine:latest

ENV CONFIG_JSON1=none CONFIG_JSON2=none UUID=0a6b6075-8f91-442c-81a7-9a5152caf50f CONFIG_JSON3=none CERT_PEM=none KEY_PEM=none VER=4.18.0

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && mkdir -m 777 /v2raybin \ 
 && cd /v2raybin \
 && curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
 && unzip v2ray.zip \
 && chmod +x /v2raybin/v2* \
 && rm -rf v2ray.zip \
 && chgrp -R 0 /v2raybin \
 && chmod -R g+rwX /v2raybin 
#单独使用注释下面三行 
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
#cicd使用时注释下面四行
#ADD nonci4entrypoint.sh /nonci4entrypoint.sh
#ADD config.json  /v2ray
#RUN chmod +x /nonci4entrypoint.sh
#CMD /nonci4entrypoint.sh



