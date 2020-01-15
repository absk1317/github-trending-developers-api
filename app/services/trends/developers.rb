# frozen_string_literal: true

module Trends
  # fetch trending developers service
  class Developers
    SERVICE_URL = 'https://github-trending-api.now.sh/developers'
    attr_accessor :language, :since, :type

    def initialize(params)
      @language = params[:language]
      @since    = params[:since]
      @type     = params[:type]
    end

    def results
      NetworkService
        .new(url: SERVICE_URL,
             request_type: :get,
             params: { language: 'javascript', since: 'weekly' })
        .response
    end
  end
end
