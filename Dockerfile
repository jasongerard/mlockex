FROM alpine:3.8

RUN apk add libcap && \
    mkdir -p /home/appuser && \
    addgroup -S app && \
    adduser -u 1000 -S -h /home/appuser -G app appuser

WORKDIR /home/appuser
COPY app.o .

RUN chown -R appuser:app /home/appuser
RUN setcap cap_ipc_lock=+ep app.o
USER appuser

CMD ["./app.o"]