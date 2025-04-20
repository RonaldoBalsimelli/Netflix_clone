require 'net/http'
require 'json'

class ShowsController < ApplicationController
  def index
    url = URI("https://api.tvmaze.com/shows")
    response = Net::HTTP.get(url)
    @shows = JSON.parse(response)
  end

  def show
    show_id = params[:id]
    url = URI("https://api.tvmaze.com/shows/#{show_id}?embed[]=episodes&embed[]=cast")
    response = Net::HTTP.get(url)
    @show = JSON.parse(response)
  end
end
