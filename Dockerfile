FROM tutum/curl:trusty
MAINTAINER Feng Honglin <hfeng@tutum.co>

ENV CADVISOR_TAG 0.4.1

RUN apt-get update -y && \
    apt-get install --no-install-recommends -yq git mercurial && \
    apt-get install -yq gcc && \
    mkdir /goroot && \
    curl -s https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz | tar xzf - -C /goroot --strip-components=1 && \
    export GOROOT=/goroot && \
    export GOPATH=/gopath && \
    export PATH=$PATH:${GOROOT}/bin/ && \
    go get github.com/tools/godep && \
    git clone https://github.com/google/cadvisor.git $GOPATH/src/github.com/google/cadvisor && \
    cd $GOPATH/src/github.com/google/cadvisor && \
    git checkout ${CADVISOR_TAG} && \
    $GOPATH/bin/godep go install && \
    cp $GOPATH/bin/cadvisor / && \
    rm -fr ${GOROOT} ${GOPATH} /var/lib/apt/lists && \
    apt-get autoremove -y git gcc && \
    apt-get clean

ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV DB_NAME cadvisor
ENV DB_USER root
ENV DB_PASS root

CMD ["/run.sh"]
