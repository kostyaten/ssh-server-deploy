FROM alpine:latest

RUN apk add --no-cache --update bash openssh sshpass openssh-client


COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

