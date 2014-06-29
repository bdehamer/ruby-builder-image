FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    autoconf \
    build-essential \
    libncurses-dev \
    libreadline-dev \
    ruby-dev \
    libffi-dev \
    procps

RUN gem install fpm --no-rdoc --no-ri

RUN mkdir /home/user
RUN useradd -g users user
USER user

WORKDIR /tmp
RUN wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
RUN tar xvfz ruby-2.1.2.tar.gz

WORKDIR /tmp/ruby-2.1.2
RUN chown -R user:users .
RUN autoconf && ./configure --program-suffix=2.1.2 --prefix=/usr --disable-install-doc
RUN make
RUN make check
USER root

RUN mkdir /tmp/ruby-package
RUN make DESTDIR=/tmp/ruby-package install

WORKDIR /tmp
RUN fpm -s dir -t deb -n ruby2.1.2-wheezy -v 2.1.2p95 -C /tmp/ruby-package -p ruby-VERSION_ARCH.deb -d "build-essential (>= 11.5)" -d "libreadline6 (>= 6.2)" -d "libreadline6-dev (>= 6.2)" -d "libncurses5 (>= 5.9)" -d "libncurses5-dev (>= 5.9)" usr/bin usr/include usr/lib usr/share

CMD cp /tmp/*.deb /target
