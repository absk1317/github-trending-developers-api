# frozen_string_literal: true

# Redis Cache handler
class RedisCache
  attr_reader :key

  def initialize(key)
    @key = key
  end

  # expire the cache in 60 s by default
  def dump(value, expiry = 60)
    redis.set key, value.to_json
    redis.expire key, expiry
  end

  def find
    value = redis.get key

    if value
      begin
        parsed_data(value)
      rescue StandardError
        value
      end
    end
  end

  private

  def redis
    @redis ||= Redis.current
  end

  def parsed_data(data)
    JSON.parse(data)
  end
end
