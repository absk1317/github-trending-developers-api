# frozen_string_literal: true

module Trends
  # base service for trends
  class Base
    BASE_SERVICE_URL = 'https://github-trending-api.now.sh'

    def redis
      Redis.current
    end

    def parse_data(data)
      JSON.parse(data)
    end

    # expire the cache in 60 s by default
    def redis_set(key, value, expiry = 60)
      redis.set key, value.to_json
      redis.expire key, expiry
    end
  end
end
