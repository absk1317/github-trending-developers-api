# frozen_string_literal: true

#   Include in your rspec config like so:
#   RSpec.configure do |spec|
#     spec.include RSpec::RedisHelper, redis: true
#   end
#   This helper will clean redis around each example.
module RedisCleaner
  # When this module is included into the rspec config,
  # it will set up an around(:each) block to clear redis.
  def self.included(rspec)
    rspec.around(:each, redis: true) do |example|
      with_clean_redis do
        example.run
      end
    end
  end

  def redis
    @redis ||= ::Redis.current
  end

  def with_clean_redis
    redis.flushall            # clean before run
    begin
      yield
    ensure
      redis.flushall          # clean up after run
    end
  end
end
