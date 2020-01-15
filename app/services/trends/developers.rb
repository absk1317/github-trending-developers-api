# frozen_string_literal: true

module Trends
  # fetch trending developers service
  class Developers
    attr_accessor :language, :since, :type

    def initialize(params)
      @language = params[:language]
      @since    = params[:since]
      @type     = params[:type]
    end

    def results
      []
    end
  end
end
