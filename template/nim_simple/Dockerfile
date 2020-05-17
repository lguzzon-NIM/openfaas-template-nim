FROM openfaas/of-watchdog:0.7.7 as watchdog

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

COPY nim_basic.nim                         .
COPY nim_basic.nimble                      .
COPY function/handler.nim                  ./function

USER root

RUN nimble install -d
RUN nim c nim_basic.nim

USER app
ENV USER=app

ENV fprocess="nim_basic"

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
