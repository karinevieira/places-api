FROM ruby:2.5.8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /places-api
WORKDIR /places-api
ADD Gemfile /places-api/Gemfile
ADD Gemfile.lock /places-api/Gemfile.lock
RUN bundle install
ADD . /places-api