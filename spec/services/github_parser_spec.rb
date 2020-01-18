# frozen_string_literal: true

describe GithubParser do
  let(:url) { Trends::Developers::SERVICE_URL }

  it 'returns the developers list according to the html recieved' do
    file = File.read(Rails.root.join('spec', 'support', 'schemas', 'developers.json'))
    data = GithubParser.parse_trending_developers(url)
    expected_developers = JSON.parse(file)
    developers = data.map { |dev| HashWithIndifferentAccess.new(dev) }

    expect(developers).to match_array(expected_developers)
  end
end
