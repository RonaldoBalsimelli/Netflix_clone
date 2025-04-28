require 'net/http'
require 'json'
require 'ostruct'
require 'action_view/helpers/sanitize_helper'

class ShowsController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  def show
    show_id = params[:id]

    # Busca dados da série
    show_url = URI("https://api.tvmaze.com/shows/#{show_id}")
    show_response = Net::HTTP.get(show_url)
    @show = OpenStruct.new(JSON.parse(show_response))

    # Episódios
    episodes_url = URI("https://api.tvmaze.com/shows/#{show_id}/episodes")
    episodes_response = Net::HTTP.get(episodes_url)
    episodes_data = JSON.parse(episodes_response)
    @episodes_by_season = episodes_data.group_by { |ep| ep["season"] }

    # Descrição traduzida (simulada)
    if @show.summary.present?
      @translated_summary = strip_tags(@show.summary)
    else
      @translated_summary = nil
    end
  end
end
