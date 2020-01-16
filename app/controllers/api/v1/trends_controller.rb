# frozen_string_literal: true

module Api
  module V1
    # trends route handler
    class TrendsController < ApplicationController
      before_action :validte_language, :validte_trending_period, only: [:developers]

      def developers
        trends = Trends::Developers.new(trend_params).results
        render json: trends
      end

      def languages
        render json: SupportedFilters.languages
      end

      private

      def validte_language
        return unless trend_params[:language]

        return if SupportedFilters.language_codes.include?(trend_params[:language])

        render json: { key: 'invalid_language' }, status: 422
      end

      def validte_trending_period
        return unless trend_params[:since]

        return if SupportedFilters.trending_periods.include?(trend_params[:since])

        render json: {
          key: 'invalid_trending_period',
          message: "Please try #{SupportedFilters.trending_periods.join(' or ')}"
        }, status: 422
      end

      def trend_params
        # language: coding language
        # since: Time since
        # type: Organization || User
        params.permit(:language, :since, :type)
      end
    end
  end
end
