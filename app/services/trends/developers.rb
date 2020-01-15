# frozen_string_literal: true

module Trends
  # fetch trending developers service
  class Developers < Trends::Base
    SERVICE_URL = BASE_SERVICE_URL + '/developers'
    attr_accessor :language, :since, :type

    def initialize(params)
      @language = params[:language]
      @since    = params[:since]
      @type     = params[:type]
    end

    def results
      if data_in_redis
        parse_data(data_in_redis)
      else
        query_network
      end
    end

    private

    def data_in_redis
      @data_in_redis ||= redis.get("#{language}-#{since}-developers")
    end

    def query_network
      data = NetworkService.new(url: SERVICE_URL,
                                request_type: :get,
                                query: { language: language, since: since, type: type })
                           .response

      redis_set("#{language}-#{since}-developers", data)
      data
    end
  end
end
