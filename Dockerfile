FROM golang:1.10.6-alpine3.8 AS build-env
RUN apk add git alpine-sdk bash
RUN mkdir -p $GOPATH/src/github.com/virtual-kubelet && \
    cd $GOPATH/src/github.com/virtual-kubelet && \
    git clone https://github.com/virtual-kubelet/virtual-kubelet && \
    cd virtual-kubelet && \
    make build && \
    mv bin/virtual-kubelet /usr/bin/

FROM golang:1.10.6-alpine3.8
RUN apk add python py-pip
RUN pip install awscli
RUN wget -O /usr/bin/aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/0.4.0-alpha.1/aws-iam-authenticator_0.4.0-alpha.1_linux_amd64 
COPY --from=build-env /usr/bin/virtual-kubelet /usr/bin/virtual-kubelet
COPY fargate.toml /
COPY docker-entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/docker-entrypoint.sh /usr/bin/virtual-kubelet /usr/bin/aws-iam-authenticator

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["virtual-kubelet", "--provider", "aws", "--provider-config", "/fargate.toml", "--kubeconfig", "/root/.kube/config"]