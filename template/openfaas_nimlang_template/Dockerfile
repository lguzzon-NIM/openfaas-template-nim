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

COPY index.nim                             .
COPY ../openfaas_nimlang_template.nimble   .
COPY function/handler.nim                  ./function

USER app
ENV PATH=$PATH:/home/app/.local/bin:/home/app/python/bin/
ENV PYTHONPATH=$PYTHONPATH:/home/app/python

RUN nimble install -d
RUN nim c openfaas_nimlang_template.nim

ENV USER=app

RUN chmod +x /usr/bin/fwatchdog

USER app

ENV fprocess="openfaas_nimlang_template"
EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
