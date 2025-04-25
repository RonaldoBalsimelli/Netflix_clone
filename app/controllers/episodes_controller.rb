require 'net/http'
require 'json'
require 'ostruct'

class EpisodesController < ApplicationController
  def show
    require 'http'
  
    response = HTTP.get("https://api.tvmaze.com/episodes/#{params[:id]}")
    episode_data = JSON.parse(response)
    @episode = OpenStruct.new(episode_data)
  
    # Faz uma nova requisição para buscar o show completo pelo ID do show retornado no _links
    show_url = episode_data.dig("_links", "show", "href")
    if show_url
      show_response = HTTP.get(show_url)
      show_data = JSON.parse(show_response)
      @show_id = show_data["id"]
    else
      @show_id = nil
    end
  end  
end