FROM golang:1.21.4 AS BUILDER
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
WORKDIR /go/src/github.com/nholuongut/kube2iam
ENV ARCH=linux
ENV CGO_ENABLED=0
COPY . ./
RUN make setup && make build

FROM alpine:3.18.4
RUN apk --no-cache add \
    ca-certificates \
    iptables
COPY --from=BUILDER /go/src/github.com/nholuongut/kube2iam/build/bin/linux/kube2iam /bin/kube2iam
ENTRYPOINT ["kube2iam"]
