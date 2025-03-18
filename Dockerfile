FROM alpine:latest AS rc

RUN apk add --no-cache git

RUN git clone https://github.com/tgyurci/rc-base.git /rc-base


FROM alpine:latest

COPY apk-world /etc/apk/world

RUN apk fix --no-cache

COPY --from=rc /rc-base/rc/* /root/
COPY root-rc/* /root/

ENTRYPOINT [ "/sbin/tini", "--" ]

CMD [ "zsh", "-l" ]
