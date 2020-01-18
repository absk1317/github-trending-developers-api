# frozen_string_literal: true

module Trends
  # fetch trending developers service
  class Developers < Trends::Base
    BASE_SERVICE_URL = 'https://github.com/trending'
    SERVICE_URL = BASE_SERVICE_URL + '/developers'
    attr_accessor :language, :since, :type, :redis_key

    def initialize(params)
      @language  = params[:language]
      @since     = params[:since]
      @type      = params[:type]
      @redis_key = "#{language}-#{since}-developers"
    end

    def results
      # fetch_data
      redis_data || fetch_data
    end

    private

    def fetch_data
      query = {}
      %i[language since type].each do |key|
        query[key] = send(key) if send(key)
      end

      url = "#{SERVICE_URL}?#{query.to_query}"

      data = GithubParser.parse_trending_developers(url)
      # data = NetworkService.new(url: SERVICE_URL, request_type: :get, query: query)
      #                      .response

      redis_set(redis_key, data)
      data
    end
  end
end
