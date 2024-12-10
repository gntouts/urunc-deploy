FROM alpine:3.17
COPY scripts/ /scripts/
RUN chmod +x /scripts/install.sh /scripts/uninstall.sh
ENTRYPOINT ["/scripts/install.sh"]
