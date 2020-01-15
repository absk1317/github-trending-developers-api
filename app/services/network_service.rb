# frozen_string_literal: true

# network layer
class NetworkService
  include HTTParty

  attr_accessor :url, :options, :query, :request_type

  def initialize(params)
    @url = params[:url]
    @query = params[:query]
    @request_type = params[:request_type]
  end

  def response
    case request_type
    when :get
      @options = { query: query }
      get_request
    when :post
      @options = { body: query }
      post_request
    end
  end

  private

  # rubocop:disable Naming/AccessorMethodName
  def get_request
    response = HTTParty.get(url, options)
    response.body
  end

  def post_request
    # no need for implementation
  end
  # rubocop:enable Naming/AccessorMethodName
end
