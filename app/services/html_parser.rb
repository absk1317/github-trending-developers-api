# frozen_string_literal: true

require 'open-uri'

# download url to memory
class HtmlParser
  def self.open(url)
    Nokogiri::HTML(Kernel.open(url))
  end
end
