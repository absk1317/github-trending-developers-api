# frozen_string_literal: true

module Api
  module V1
    # trends route handler
    class TrendsController < ApplicationController
      def developers
        trends = Trends::Developers.new(trend_params).results
        render json: trends
      end

      def trend_params
        params.permit(:language, :since, :type)
      end
    end
  end
end
