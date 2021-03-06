# frozen_string_literal: true

require 'open-uri'

# Gitub parser
class GithubParser
  GITHUB_URL = 'https://github.com'

  class << self
    def parse_trending_developers(url)
      # open the page in memory, with nokogiri
      page = HtmlParser.open(url)

      # for each element of class Box, iterate and find required data
      page.css('.Box article.Box-row').map do |element|
        parse_data(element)
      end
    end

    private

    # below method is called for each .Box row
    def parse_data(element)
      repo_element = element.css('.mt-2 > article')
      {
        username: element.css('.h3 a').attr('href').to_s.split('/')[1].strip,
        name: element.css('.h3 a').text.strip,
        type: element.css('img')[0].parent.attr('data-hovercard-type'),
        url: GITHUB_URL + element.css('.h3 a').attr('href'),
        avatar: element.css('img').attr('src').value.to_s.gsub(/\?s=.*$/, ''),
        repo: parse_repo(repo_element)
      }
    end

    # parse the repo data
    def parse_repo(repo_element)
      {
        name: repo_element.css('a').text.strip,
        description: repo_element.css('.f6.mt-1').text.strip,
        url: GITHUB_URL + repo_element.css('a').attr('href').value
      }
    end
  end
end
