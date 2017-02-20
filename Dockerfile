FROM ruby:2.3

RUN apt-get update && apt-get install -y nodejs qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xvfb
RUN apt-get update && apt-get install -y postgresql-client

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /opt/app
WORKDIR /opt/app

RUN RAILS_ENV=production bundle exec rake assets:precompile --trace

EXPOSE 3000

CMD ["/bin/bash", "-c", "bin/setup && rails server"]