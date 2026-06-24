FROM python:3.14-alpine3.24@sha256:26730869004e2b9c4b9ad09cab8625e81d256d1ce97e72df5520e806b1709f92

WORKDIR /work

RUN apk add --no-cache git && \
    pip install uv && \
    uv pip install --break-system-packages --system zensical==0.0.46

EXPOSE 8080

ENTRYPOINT ["zensical"]
CMD ["serve", "--dev-addr", "0.0.0.0:8080"]
