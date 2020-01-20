# frozen_string_literal: true

# namespaced API controllers
module Api
  module V1
    # trends route handler
    class TrendsController < ApplicationController
      # validate languages and since query params before actually processing
      before_action :validte_language, :validte_trending_period, only: [:developers]

      def developers
        # call trending developers service with sane params
        trends = Trends::Developers.new(trend_params).results
        render json: trends
      end

      def languages
        render json: SupportedFilters.languages
      end

      private

      def validte_language
        # if no language param is there, allow it
        return unless trend_params[:language]

        # if queried language is allowed, let it pass
        return if SupportedFilters.language_codes.include?(trend_params[:language])

        # raise error otherwise
        render json: { key: 'invalid_language' }, status: 422
      end

      def validte_trending_period
        # if no since param is there, allow it, default is `daily` in the service
        return unless trend_params[:since]

        # if queried trend period is allowed, let it pass
        return if SupportedFilters.trending_periods.include?(trend_params[:since])

        # raise error otherwise
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
