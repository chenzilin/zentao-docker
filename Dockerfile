FROM ubuntu:xenial

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yqq sudo git-core subversion build-essential gcc-multilib ccache quilt \
                       bzip2 cpio whois patch perl libncurses5-dev zlib1g-dev gawk flex gettext wget unzip python vim libssl-dev \
                       sed tar rsync bc gperf bison texinfo libtool automake gawk flex help2man tree pkg-config && \
    apt-get clean && \
    useradd -m chenzilin && \
    echo 'chenzilin ALL=NOPASSWD: ALL' > /etc/sudoers.d/chenzilin

COPY entrypoint.sh /usr/local/bin/
COPY ZenTaoPMS/ZenTaoPMS.9.6.2.zbox_64.tar.gz /opt/

RUN cd /opt/ && tar xzvfpa ZenTaoPMS.9.6.2.zbox_64.tar.gz && \
    rm -rf ZenTaoPMS.9.6.2.zbox_64.tar.gz

USER chenzilin
RUN git config --global user.email "chenzilin115@gmail.com" && \
    git config --global user.name "ZiLin Chen"

EXPOSE 80
ENTRYPOINT ["entrypoint.sh"]

WORKDIR /home/chenzilin
