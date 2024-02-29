FROM alpine:3.15.0

RUN apk fix

RUN apk --update add git-daemon && \
	rm /var/cache/apk/*

COPY gitconfig /etc/gitconfig

LABEL app=microservice

WORKDIR /opt

EXPOSE 9418

ENTRYPOINT ["/usr/libexec/git-core/git-daemon", "--base-path=/opt", \
		"--base-path-relaxed", "--port=9418", \
		"--listen=0.0.0.0", "--pid-file=/root/git-pid", \
		"--init-timeout=4", "--enable=receive-pack", \
		"--enable=upload-archive", "--export-all"]
