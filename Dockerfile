FROM golang:1.7-alpine
MAINTAINER Irakli Nadareishvili

ENV PORT=77701
ENV GOPATH=/go
ENV PATH=${GOPATH}/bin:${PATH}
ENV APP_USER=appuser
ENV APP_ENV=production

COPY . ${GOPATH}/src/app
WORKDIR ${GOPATH}/src/app

USER root

RUN adduser -s /bin/false -D ${APP_USER} \
 && echo "Installing git and ssh support" \ 
 && apk update && apk upgrade \
 && apk add --no-cache bash git \
 && echo "Installing infrastructural go packages…" \
 && go get github.com/githubnemo/CompileDaemon \
 && go get github.com/Masterminds/glide \
 ## If you are checking-in your deps, you can remove following line
 && echo "Building project…" \
 && glide up \
 && go-wrapper install \
 && echo "Fixing permissions..." \
 && chown -R ${APP_USER} ${GOPATH} \
 && echo "Cleaning up installation caches to reduce image size" \
 && rm -rf /root/src /tmp/* /usr/share/man /var/cache/apk/* 

USER ${APP_USER}
EXPOSE 7701

CMD ["go-wrapper", "run"]