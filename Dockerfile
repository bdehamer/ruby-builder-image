FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    autoconf \
    build-essential \
    libncurses-dev \
    libreadline-dev \
    zlib1g-dev \
    libssl-dev \
    ruby-dev \
    libffi-dev \
    procps

RUN gem install fpm --no-rdoc --no-ri

RUN mkdir /home/user
RUN useradd -g users user

WORKDIR /usr/src
RUN wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
RUN tar xvfz ruby-2.1.2.tar.gz

WORKDIR /usr/src/ruby-2.1.2
RUN chown -R user:users .

USER user
RUN autoconf && ./configure --program-suffix=2.1.2 --prefix=/usr --disable-install-doc
RUN make
RUN make check
USER root

RUN mkdir /tmp/ruby-package
RUN make DESTDIR=/tmp/ruby-package install

ADD update-alt.sh /tmp/update-alt.sh
WORKDIR /tmp
RUN fpm -s dir -t deb -n ruby2.1.2-wheezy -v 2.1.2p95 -C /tmp/ruby-package -p ruby-VERSION_ARCH.deb -d "build-essential (>= 11.5)" -d "libreadline6 (>= 6.2)" -d "libreadline6-dev (>= 6.2)" -d "libncurses5 (>= 5.9)" -d "libncurses5-dev (>= 5.9)" -d "zlib1g (>= 1.2.7)" -d "libssl-dev (>= 1.0.0)" --after-install /tmp/update-alt.sh usr/bin usr/include usr/lib usr/share

CMD cp /tmp/*.deb /target
