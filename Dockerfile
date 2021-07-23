FROM ruby:2.7.0

ENV INSTALL_PATH /usr/src/agenda_social

RUN gem install rails

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN rm -rf node_modules vendor

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]