# frozen_string_literal: true

RSpec.describe Api::V1::TrendsController, type: :request do
  describe 'response structure' do
    it 'gives trending developers json in a predefined json structure' do
      get '/api/v1/trends/developers'

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('trends/developers')
    end
  end
end
