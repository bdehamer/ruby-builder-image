#!/bin/bash

update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.1.2 400 \
  --slave /usr/bin/ri ri /usr/bin/ri2.1.2 \
  --slave /usr/bin/irb irb /usr/bin/irb2.1.2 \
  --slave /usr/bin/rdoc rdoc /usr/bin/rdoc2.1.2 \

update-alternatives --install /usr/bin/erb erb /usr/bin/erb2.1.2 400 \

update-alternatives --install /usr/bin/gem gem /usr/bin/gem2.1.2 400 \

update-alternatives --install /usr/bin/rake rake /usr/bin/rake2.1.2 400 \
