ARG RUBY_VERSION=2.7
FROM ruby:${RUBY_VERSION}-alpine
WORKDIR /app

# make, gcc and musl-dev are required by yajl native extensions
RUN apk --update add --no-cache \
  bash \
  grep \
  make \
  gcc \
  musl-dev

RUN gem install bundler

COPY . ./

RUN ./bin/setup