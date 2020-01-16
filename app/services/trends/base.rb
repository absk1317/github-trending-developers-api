# frozen_string_literal: true

module Trends
  # base service for trends
  class Base
    BASE_SERVICE_URL = 'https://github-trending-api.now.sh'

    protected

    def redis
      Redis.current
    end

    def parse_data(data)
      JSON.parse(data)
    end

    def redis_data
      data = redis.get(redis_key)

      return JSON.parse(data) if data
    end

    # expire the cache in 60 s by default
    def redis_set(key, value, expiry = fetch_expiry)
      redis.set key, value.to_json
      redis.expire key, expiry
    end

    def fetch_expiry
      case since
      when 'daily'
        60 # 60 seconds expiry for daily
      when 'weekly', 'monthly'
        600 # 10 minutes expiry for weekly and monthly
      else
        100 # 100 seconds otherwise
      end
    end
  end
end
