FROM ruby:2.4.1-alpine
LABEL maintainer 'Naoya TOKASHIKI <ggtoka@gmail.com>'

ENV LANG C.UTF-8
ENV ROOT_PATH /myapp

RUN mkdir $ROOT_PATH
WORKDIR $ROOT_PATH

ADD Gemfile $ROOT_PATH/Gemfile
ADD Gemfile.lock $ROOT_PATH/Gemfile.lock


RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache --virtual=.build-dependencies \
      build-base \
      curl-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      postgresql-dev \
      # mariadb-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev && \
    apk add --update --no-cache \
      bash \
      git \
      openssh \
      postgresql \
      ruby-json \
      tzdata \
      nodejs \
      yaml && \
    gem install bundler && \
    bundle install -j4 && \
    apk del .build-dependencies

ADD . $ROOT_PATH
