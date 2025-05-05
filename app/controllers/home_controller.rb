require 'net/http'
require 'json'
require 'ostruct'

class HomeController < ApplicationController
  before_action :authenticate_user! # Protege todas as rotas deste controller

  def index
    if params[:query].present?
      url = URI("https://api.tvmaze.com/search/shows?q=#{URI.encode_www_form_component(params[:query])}")
    else
      url = URI("https://api.tvmaze.com/shows")
    end

    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    @shows = if params[:query].present?
      data.map { |item| OpenStruct.new(item["show"]) }
    else
      data.first(20).map { |show| OpenStruct.new(show) }
    end
  end
end
