FROM ruby:2.6

# Configure Yarn repo:
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install required packages:
RUN apt-get update -qq \
    && apt-get install -y nodejs postgresql-client yarn

# Get the bundle installed:
RUN mkdir /datagovuk_find
WORKDIR /datagovuk_find
COPY .ruby-version /datagovuk_find/.ruby-version
COPY Gemfile /datagovuk_find/Gemfile
COPY Gemfile.lock /datagovuk_find/Gemfile.lock
RUN bundle install

# Move the rest of the code in:
COPY . /datagovuk_find

RUN yarn install

# Start the main process.
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
