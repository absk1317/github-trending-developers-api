# frozen_string_literal: true

RSpec.describe Api::V1::TrendsController, type: :request do
  describe 'developers API' do
    it 'gives trending developers json in a predefined json structure' do
      get '/api/v1/trends/developers'

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('trends/developers')
    end

    it 'throws error if language is not supported' do
      get '/api/v1/trends/developers?language=12345678'

      expect(response).to have_http_status(422)
      expected_response = { 'key' => 'invalid_language' }
      expect(json).to eq(expected_response)
    end

    it 'throws error if trend period is not valid' do
      get '/api/v1/trends/developers?since=12345678'

      expect(response).to have_http_status(422)
      expected_response = {
        'key' => 'invalid_trending_period',
        'message' => "Please try #{SupportedFilters.trending_periods.join(' or ')}"
      }
      expect(json).to eq(expected_response)
    end
  end

  describe 'languages API' do
    it 'gives trending developers json in a predefined json structure' do
      get '/api/v1/languages'

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('languages')
    end
  end
end
