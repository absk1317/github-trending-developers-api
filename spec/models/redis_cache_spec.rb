# frozen_string_literal: true

RSpec.describe RedisCache do
  let!(:redis) { Redis.current }
  let!(:key) { 'key:100' }

  subject { RedisCache.new key }

  describe '#dump' do
    before { subject.dump 'test' }

    it 'dumps the key into Redis' do
      expect(redis.keys).to eq([key])
    end

    it 'dumps the value for the key into Redis' do
      expect(redis.get(key)).to eq('test'.to_json)
    end
  end

  describe '#find' do
    it 'finds the records value' do
      redis.set key, 'test'
      expect(subject.find).to eq('test')
    end

    it 'finds the records value and returns parsed json if saved as json' do
      redis.set key, 'test'.to_json
      expect(subject.find).to eq('test')
    end
  end
end
