FROM docker.io/ubuntu:14.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y \
        openjdk-7-jre \
        icedtea-plugin \
        wget \
        sudo \
        firefox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/* && \
    wget https://ftp.mozilla.org/pub/firefox/releases/51.0/linux-x86_64/en-US/firefox-51.0.tar.bz2 && \
    tar xjf firefox-51.0.tar.bz2 && \
    mv firefox /opt/firefox51 && \
    mv /usr/bin/firefox /usr/bin/firefox_old && \
    ln -sf /opt/firefox51/firefox /usr/bin/firefox && \
    rm -rf firefox-51.0.tar.bz2

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/firefox && \
    echo "firefox:x:${uid}:${gid}:firefox,,,:/home/firefox:/bin/bash" >> /etc/passwd && \
    echo "firefox:x:${uid}:" >> /etc/group && \
    echo "firefox ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/firefox && \
    chmod 0440 /etc/sudoers.d/firefox && \
    chown ${uid}:${gid} -R /home/firefox

RUN sed -e '/^jdk\.jar\.disabledAlgorithms=/s/^/#/' -i /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security

ENV HOME /home/firefox
WORKDIR /home/firefox

USER firefox
CMD /usr/bin/firefox
