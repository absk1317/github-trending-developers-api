# frozen_string_literal: true

# Supported Filters
module SupportedFilters
  # pseudo model to hold logic for filters
  def self.language_codes
    SupportedFilters.languages.map { |language| language['code'] }
  end

  def self.languages
    # read the json file from public folder, parse and return the content
    file = File.read('public/valid_languages.json')
    JSON.parse(file)
  end

  def self.trending_periods
    %w[daily weekly monthly]
  end
end
