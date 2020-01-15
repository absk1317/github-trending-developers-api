# frozen_string_literal: true

module Api
  module V1
    # trends route handler
    class TrendsController < ApplicationController
      def developers
        trends = Trends::Developer.new(trend_params).current
        meta   = {}
        render json: trends, meta: meta
      end
    end
  end
end
