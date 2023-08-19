FROM ruby:3.1.2
WORKDIR sharko
COPY ./sharko/ .
RUN rm -rf Gemfile.lock && bundle install
RUN rails db:migrate && rails db:seed
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]