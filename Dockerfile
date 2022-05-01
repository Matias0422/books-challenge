FROM ruby:3.1
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]