# frozen_string_literal: true

describe Trends::Developers do
  let!(:redis) { Redis.current }

  it 'returns the developers list and sets redis keys', redis: true do
    # redis clean before service call
    expect(redis.keys).to eq([])

    developers = Trends::Developers.new(language: 'ruby', since: 'monthly').results

    expect(developers).not_to be_empty
    expect(developers.count).to eq(25)
    expect(developers.first.keys).to contain_exactly(:username, :avatar, :name, :repo, :type, :url)

    # redis got dumped with data after service
    expect(redis.keys).to eq(['language:ruby-since:monthly-developers'])
  end

  it 'sets the redis key', redis: true do
    # redis clean before service call
    expect(redis.keys).to eq([])

    key = 'language:ruby-since:daily-developers'
    _developers = Trends::Developers.new(language: 'ruby', since: 'daily').results

    # redis got dumped with data after service
    expect(redis.keys).to eq([key])
  end

  it 'sets the redis cache expiration time according to trend period', redis: true do
    # redis clean before service call
    expect(redis.keys).to eq([])

    key1 = 'language:ruby-since:daily-developers'
    _developers = Trends::Developers.new(language: 'ruby', since: 'daily').results
    # redis got dumped with data after service
    expect(redis.keys).to eq([key1])
    expect(redis.ttl(key1)).to eq(60)
    redis.flushall

    key2 = 'language:ruby-since:monthly-developers'
    _developers = Trends::Developers.new(language: 'ruby', since: 'monthly').results
    # redis got dumped with data after service
    expect(redis.keys).to eq([key2])
    expect(redis.ttl(key2)).to eq(600)
  end
end
