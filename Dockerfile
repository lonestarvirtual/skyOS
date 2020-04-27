FROM ruby:2.6.3-alpine AS Builder

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    imagemagick \
    nodejs \
    yarn \
    git \
    tzdata \
    file

ENV RAILS_ENV production
ENV RAILS_BUILD_IN_PROGRESS yes

WORKDIR /app

COPY . .

RUN bundle config --local without 'development test' && \
    bundle install -j4 --retry 3 && \
    bundle clean --force && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

RUN mv config/credentials/production.yml.enc \
       config/credentials/production.yml.enc.bak 2>/devnull || true

RUN SECRET_KEY_BASE=dummy \
    RAILS_MASTER_KEY=dummy \
    bundle exec rails assets:precompile

RUN mv config/credentials/production.yml.enc.bak \
       config/credentials/production.yml.enc 2>/dev/null || true

RUN rm -rf .git node_modules tmp/cache vendor/bundle test spec

###########################################################

FROM ruby:2.6.3-alpine

RUN apk add --update --no-cache \
    postgresql-client \
    imagemagick \
    tzdata \
    file

ENV RAILS_ENV production

WORKDIR /app

RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app

COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder --chown=app:app /app /app

EXPOSE 3000

USER app

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
