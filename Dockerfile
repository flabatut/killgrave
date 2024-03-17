FROM alpine AS builder

ARG VERSION=0.5.1
ARG TARGETOS
ARG TARGETARCH
WORKDIR /build

RUN <<-EOF
    if [ "$TARGETARCH" = "amd64" ] ; then
        wget -q -O killgrave.tar.gz "https://github.com/friendsofgo/killgrave/releases/download/v${VERSION}/killgrave_${VERSION}_${TARGETOS}_x86_64.tar.gz"
    else
        wget -q -O killgrave.tar.gz "https://github.com/friendsofgo/killgrave/releases/download/v${VERSION}/killgrave_${VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz"
    fi
    tar zxf killgrave.tar.gz killgrave
    rm killgrave.tar.gz
EOF

FROM scratch
COPY --from=builder /build /app
ENTRYPOINT ["/app/killgrave"]