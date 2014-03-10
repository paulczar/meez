FROM racker/precise-with-updates

RUN apt-get -yqq update && apt-get -yqq install ruby1.9.1-dev build-essential libxml2-dev libxslt-dev git curl wget

RUN gem install bundler

RUN wget -q -O /tmp/vagrant.deb http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64.deb \
	&& dpkg -i /tmp/vagrant.deb \
	&& rm /tmp/vagrant.deb 

ADD Gemfile /source/Gemfile

RUN cd /source && bundle install
