# run:  docker build --tag yaljazairi/ruby-trending-developers .
#       docker run -p 9292:9292 yaljazairi/ruby-trending-developers
# check localhost in browser
#
# push: docker push yaljazairi/ruby-trending-developers

FROM ruby:2.6.7-alpine

WORKDIR /usr/src/app

COPY . /usr/src/app

# As with any Ruby installation, you need dev tools to install gems with native extensions:
RUN apk update \
 && apk add --no-cache  \
    build-base  \
    ruby-dev

RUN gem install bundler
RUN bundle install

# Run rackup 
EXPOSE 9292
# CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]   # CMD looks the same like => bundle exec rackup --host 0.0.0.0 -p 4567
CMD ["rackup", "--host", "0.0.0.0", "-p", "9292"]
