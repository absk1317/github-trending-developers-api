# frozen_string_literal: true

# base application controller
class ApplicationController < ActionController::API
  def redis
    Redis.current
  end
end
