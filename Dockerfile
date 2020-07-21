FROM i386/ubuntu

RUN apt-get update && apt-get install --no-install-recommends -y wget libfreetype6 libxt6 libxaw7 libcurl4 musl musl-dev musl-tools
RUN mkdir -p /root/rebol
RUN mkdir /root/host
WORKDIR /root/rebol
RUN wget http://www.rebol.com/downloads/v278/rebol-view-278-4-3.tar.gz
RUN tar xzvf rebol-view-278-4-3.tar.gz
ENV PATH /root/host:/root/rebol/releases/rebol-view:$PATH
RUN chmod u+x /root/rebol/releases/rebol-view/rebol
RUN apt-get autoclean && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /root/host

ENTRYPOINT ["/root/rebol/releases/rebol-view/rebol", "-vs"]