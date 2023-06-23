FROM ruby:3.1.2
  RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
  WORKDIR /space-code-platform
  COPY Gemfile /space-code-platform/Gemfile
  COPY Gemfile.lock /space-code-platform/Gemfile.lock
  RUN bundle install
  COPY . /space-code-platform

  EXPOSE 3000
