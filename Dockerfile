FROM racker/precise-with-updates

RUN apt-get -yqq update && apt-get -yqq install ruby1.9.1-dev build-essential libxml2-dev libxslt-dev git curl wget

RUN gem install bundler

ADD Gemfile /source/Gemfile

RUN cd /source && bundle install --system
