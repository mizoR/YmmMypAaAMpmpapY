FROM ruby:2.6.3-alpine

ENV APP="/app"

RUN mkdir -p $APP

WORKDIR $APP

RUN gem install bundler

ADD Gemfile Gemfile

ADD Gemfile.lock Gemfile.lock

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache --virtual=.build-dependencies \
      build-base                                              \
      curl-dev                                                \
      linux-headers                                           \
      libxml2-dev                                             \
      libxslt-dev                                             \
      ruby-dev                                                \
      yaml-dev                                                \
      zlib-dev &&                                             \
    apk add --update --no-cache \
      bash                      \
      git                       \
      openssh                   \
      mariadb-client            \
      mariadb-dev               \
      ruby-json                 \
      tzdata                    \
      yaml &&                   \
    bundle install -j4 && \
    apk del .build-dependencies
