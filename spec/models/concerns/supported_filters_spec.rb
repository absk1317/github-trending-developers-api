# frozen_string_literal: true

RSpec.describe SupportedFilters, type: :module do
  let(:file) { File.read('public/valid_languages.json') }
  let(:languages) { JSON.parse(file) }
  let(:language_codes) { languages.map { |language| language['code'] } }
  let(:trending_periods) { %w[daily weekly monthly] }

  describe 'methods' do
    it 'gives supported languages' do
      expect(languages).to eq(SupportedFilters.languages)
    end

    it 'gives supported language codes' do
      expect(language_codes).to eq(SupportedFilters.language_codes)
    end

    it 'gives supported time based filters' do
      expect(trending_periods).to eq(SupportedFilters.trending_periods)
    end
  end
end
