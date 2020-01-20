# frozen_string_literal: true

module Trends
  # fetch trending developers service
  class Developers
    BASE_SERVICE_URL = 'https://github.com/trending'
    SERVICE_URL = BASE_SERVICE_URL + '/developers'
    attr_accessor :language, :since, :type, :redis_key

    def initialize(params)
      # initialize with default attrs
      @language  = params[:language]
      @since     = params[:since]
      @type      = params[:type]
      @redis_key = "language:#{language}-since:#{since}-developers"
    end

    def results
      # if redis store has data, send from there,
      # hit the url and save it in redis otherwise
      redis_data || fetch_data
    end

    private

    def redis_data
      RedisCache.new(redis_key).find
    end

    def fetch_data
      query = {}
      # if the below attrs are present, add them to the query object
      %i[language since type].each do |key|
        query[key] = send(key) if send(key)
      end

      # generate the url
      url = "#{SERVICE_URL}?#{query.to_query}"

      # read data from github parser service, written with help of nokogiri
      data = GithubParser.parse_trending_developers(url)

      ## we can use extrnal service also, like -
      ## https://github-trending-api.now.sh/developers?language=javascript&since=weekly

      # data = NetworkService.new(url: SERVICE_URL, request_type: :get, query: query)
      #                      .response

      # store data in redis and return the same
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
