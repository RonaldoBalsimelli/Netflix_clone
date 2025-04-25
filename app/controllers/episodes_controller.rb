require 'net/http'
require 'json'
require 'ostruct'

class EpisodesController < ApplicationController
def show
  episode_id = params[:id]

  # Faz a requisição à API TVmaze
  url = URI("https://api.tvmaze.com/episodes/#{episode_id}")
  response = Net::HTTP.get(url)
  data = JSON.parse(response)

  @episode = OpenStruct.new(
    id: data["id"],
    name: data["name"],
    season: data["season"],
    number: data["number"],
    summary: data["summary"],
    image: data["image"] && data["image"]["medium"]
  )
end
end

