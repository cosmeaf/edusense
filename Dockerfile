FROM ruby:3.1-alpine

RUN apk add --no-cache build-base postgresql-dev tzdata

WORKDIR /usr/src/app

COPY . .

RUN bundle install

ENTRYPOINT ["sh", "entrypoint.sh"]
