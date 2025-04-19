require 'net/http'
require 'json'

class TvmazeService
  BASE_URL = "https://api.tvmaze.com"

  def self.search_show_by_name(name)
    url = URI("#{BASE_URL}/singlesearch/shows?q=#{URI.encode(name)}")
    response = Net::HTTP.get(url)
    JSON.parse(response)
  rescue
    nil
  end
end
