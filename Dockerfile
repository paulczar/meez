FROM racker/precise-with-updates

RUN apt-get -yqq update && apt-get -yqq install curl build-essential libxml2-dev libxslt-dev git autoconf wget python-pip

RUN wget -q -O /tmp/chefdk.deb https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.1.0-1_amd64.deb \
	&& dpkg -i /tmp/chefdk.deb \
	&& rm /tmp/chefdk.deb

RUN wget -q -O /tmp/vagrant.deb http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64.deb \
	&& dpkg -i /tmp/vagrant.deb \
	&& rm /tmp/vagrant.deb 

RUN pip install swiftly awscli

ENV PATH /opt/chefdk/embedded/bin:/root/.chefdk/gem/ruby/2.1.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV USE_SYSTEM_GECODE 1

ADD Gemfile /tmp/Gemfile

RUN cd /tmp && bundle install && rm Gemfile*
