FROM golang:1.17.5-alpine AS builder
RUN apk add build-base libpcap-dev
RUN go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

FROM alpine:3.15.0
RUN apk add nmap libpcap-dev bind-tools ca-certificates
COPY --from=builder /go/bin/naabu /usr/local/bin/naabu
ENTRYPOINT ["naabu"]
