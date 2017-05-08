FROM ruby:2.4.1-alpine

RUN mkdir -p /opt/web


RUN apk add --update \
    build-base \
    sqlite-dev \
    && rm -rf /var/cache/apk/*

WORKDIR /opt/prediction
COPY Gemfile Gemfile.lock ./
ENV BUNDLE_PATH /bundle
RUN bundle install --jobs 20 --retry 5
EXPOSE 80
ADD . /opt/prediction
CMD puma -p 80
