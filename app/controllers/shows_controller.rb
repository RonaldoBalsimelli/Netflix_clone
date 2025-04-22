require 'net/http'
require 'json'
require 'ostruct'

class ShowsController < ApplicationController
  def index
    @shows = Show.all
  end

  def show
    show_id = params[:id]

    uri = URI("https://api.tvmaze.com/shows/#{show_id}?embed[]=cast&embed[]=episodes")
    response = Net::HTTP.get(uri)
    show_data = JSON.parse(response)

    @show = OpenStruct.new(
      id: show_data["id"],
      name: show_data["name"],
      summary: show_data["summary"],
      image: show_data.dig("image", "original")
    )

    @actors = (show_data.dig("_embedded", "cast") || []).map do |actor_data|
      OpenStruct.new(
        name: actor_data.dig("person", "name"),
        image: actor_data.dig("person", "image", "medium")
      )
    end

    @episodes = (show_data.dig("_embedded", "episodes") || []).map do |episode_data|
      OpenStruct.new(
        id: episode_data["id"],
        name: episode_data["name"]
      )
    end
  end
end
