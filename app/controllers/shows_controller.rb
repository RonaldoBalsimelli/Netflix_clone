require 'net/http'
require 'json'
require 'ostruct'

class ShowsController < ApplicationController
  def show
    show_id = params[:id]

    # Busca dados da série
    show_url = URI("https://api.tvmaze.com/shows/#{show_id}")
    show_response = Net::HTTP.get(show_url)
    @show = OpenStruct.new(JSON.parse(show_response))

    # Busca episódios da série
    episodes_url = URI("https://api.tvmaze.com/shows/#{show_id}/episodes")
    episodes_response = Net::HTTP.get(episodes_url)
    episodes_data = JSON.parse(episodes_response)

    # Agrupar por temporada
    @episodes_by_season = episodes_data.group_by { |ep| ep["season"] }
  end
end
