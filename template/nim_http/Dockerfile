FROM ghcr.io/openfaas/of-watchdog:0.9.2 as watchdog

FROM nimlang/nim:latest-alpine-onbuild

# Allows you to add additional packages via build-arg
ARG ADDITIONAL_PACKAGE

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog
RUN apk --no-cache add ca-certificates ${ADDITIONAL_PACKAGE}


# Add non root user
RUN addgroup -S app && adduser app -S -G app

RUN mkdir -p /home/nimble-app && mkdir -p /home/nimble-app/function && chown -R app /home/nimble-app

WORKDIR /home/nimble-app

COPY nim_http.nim                          .
COPY nim_http.nimble                       .
COPY function/handler.nim                  ./function

USER root

RUN nimble install -d
RUN nim c nim_http.nim

USER app
ENV USER=app

ENV fprocess="nim_http"
EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
