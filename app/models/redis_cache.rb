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
    # fetch value from redis data-store
    value = redis.get key

    # if value is there, try to parse and return it, return direct value elsewise
    # we are trying to parse because while storing, we are storing as json
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
    # get the current redis instance
    @redis ||= Redis.current
  end

  def parsed_data(data)
    JSON.parse(data)
  end
end
