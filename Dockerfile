FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install rails

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile

RUN gem install bundler -v 2.0.1
RUN bundle install

COPY . /myapp

CMD ./entrypoint.sh
# CMD ["rails", "server", "-b", "0.0.0.0"]