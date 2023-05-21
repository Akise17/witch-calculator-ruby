FROM ruby:3.1.1

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    &&  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    &&  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    &&  apt-get update -y \
    &&  apt-get -y --no-install-recommends install libpq-dev nodejs procps yarn \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mkdir -p /app
WORKDIR /app
COPY Gemfile* ./
RUN bundle config set --local without 'development test' && \
    bundle install && \
    bundle pack --quiet
COPY . ./

ARG SECRET_KEY_BASE=${SECRET_KEY_BASE}
ENV RAILS_SERVE_STATIC_FILES=true

RUN yarn install

RUN RAILS_ENV=production \
    SECRET_KEY_BASE=$SECRET_KEY_BASE \
    RAILS_SERVE_STATIC_FILES=true \
    DB_ADAPTER=nulldb \
    bundle exec rails assets:precompile

EXPOSE 8080

RUN chmod +x run_service.sh
ENTRYPOINT ./run_service.sh