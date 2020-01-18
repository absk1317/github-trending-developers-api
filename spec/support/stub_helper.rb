# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each) do
    mock_file = Rails.root.join('spec', 'support', 'mock_data', 'developers.html')

    stub_request(:get, %r{github.com/trending/developers})
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: mock_file, headers: {})
  end
end
