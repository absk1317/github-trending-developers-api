# frozen_string_literal: true

# Supported Filters
module SupportedFilters
  def self.language_codes
    SupportedFilters.languages.map { |language| language['code'] }
  end

  def self.languages
    file = File.read('public/valid_languages.json')
    JSON.parse(file)
  end

  def self.trending_periods
    %w[daily weekly monthly]
  end
end
