FROM alpine:latest AS rc

RUN apk update \
	&& apk upgrade \
	&& apk --no-cache add git

RUN git clone https://github.com/tgyurci/rc-base.git /rc-base

FROM alpine:latest

RUN apk update \
	&& apk upgrade \
	&& apk add --no-cache \
		apache2-utils \
		curl \
		drill \
		file \
		iputils \
		jq \
		net-tools \
		netcat-openbsd \
		openssh \
		openssl \
		procps \
		pstree \
		rsync \
		socat \
		strace \
		tcpdump \
		tini \
		traceroute \
		util-linux \
		vim \
		zsh

COPY --from=rc /rc-base/rc/* /root/
COPY root-rc/* /root/

ENTRYPOINT [ "/sbin/tini", "--" ]

CMD [ "zsh", "-l" ]
