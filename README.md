# Github Trending Developers, Backend

# System dependencies

## Setup Ruby

* Use `rbenv` or `rvm` for ruby setup. Installation steps are specified [here](https://github.com/rbenv/rbenv) and [here](https://rvm.io/).

* Rails version- **6.0.2**

* Ruby version - **2.6.5**. Install with the following commands:
```
rvm install ruby-2.6.2
rvm use 2.6.5
```

## Database Initialization

* Setup DBs within postgres
```
rake db:create:all
rake db:migrate
```


## Test Suite

* Run tests with command `bundle exec rspec spec`


### Local Setup

```
gem install bundler
bundle install
rails server -p 3001
```


We have used service pattern extensively across the app, keeping Single Responsibility Principle in mind.
Coupling is low, and cohesion is high.

Earlier, I had used an external service for fetching trending data, (https://github-trending-api.now.sh/developers), later I decided to host the service on my own, so built a parser using nokogiri.

The API has been significantly faster ever since, with a performance gain of over 20%.

Also, I have provisioed for Caching on redis level, with expiry of 60 or 600 seconds, depending on the trend period. As soon as the user hits the API, it will read data from gitlab pages and cache it in redis.

For further requests of same language and filter, that redis db will be used, provided that it hasn't expired yet.