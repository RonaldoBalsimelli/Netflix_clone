require 'net/http'
require 'json'
require 'ostruct'


class HomeController < ApplicationController
  def index
    if params[:query].present?
      url = URI("https://api.tvmaze.com/search/shows?q=#{URI.encode_www_form_component(params[:query])}")
    else
      url = URI("https://api.tvmaze.com/shows") # 👈 lista geral de séries
    end
  
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
  
    @shows = if params[:query].present?
      data.map { |item| OpenStruct.new(item["show"]) }
    else
      data.first(20).map { |show| OpenStruct.new(show) } # 👈 pega os primeiros 20
    end
  end
end
  
