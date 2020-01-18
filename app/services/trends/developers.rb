# frozen_string_literal: true

module Trends
  # fetch trending developers service
  class Developers
    BASE_SERVICE_URL = 'https://github.com/trending'
    SERVICE_URL = BASE_SERVICE_URL + '/developers'
    attr_accessor :language, :since, :type, :redis_key

    def initialize(params)
      @language  = params[:language]
      @since     = params[:since]
      @type      = params[:type]
      @redis_key = "language:#{language}-since:#{since}-developers"
    end

    def results
      # fetch_data
      redis_data || fetch_data
    end

    private

    def redis_data
      RedisCache.new(redis_key).find
    end

    def fetch_data
      query = {}
      %i[language since type].each do |key|
        query[key] = send(key) if send(key)
      end

      url = "#{SERVICE_URL}?#{query.to_query}"

      data = GithubParser.parse_trending_developers(url)
      # data = NetworkService.new(url: SERVICE_URL, request_type: :get, query: query)
      #                      .response

      RedisCache.new(redis_key).dump(data, fetch_expiry)
      data
    end

    def fetch_expiry
      case since
      when 'daily'
        60 # 60 seconds expiry for daily
      when 'weekly', 'monthly'
        600 # 10 minutes expiry for weekly and monthly
      else
        6
      end
    end
  end
end
