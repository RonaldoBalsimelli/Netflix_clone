require 'net/http'
require 'json'
require 'ostruct'
require 'action_view/helpers/sanitize_helper'

class EpisodesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  def show
    episode_id = params[:id]

    # Busca dados do episódio
    episode_url = URI("https://api.tvmaze.com/episodes/#{episode_id}")
    episode_response = Net::HTTP.get(episode_url)
    episode_data = JSON.parse(episode_response)

    @episode = OpenStruct.new(episode_data)
    @image = @episode.image&.dig("original")

    # NOVO: buscar o show_id corretamente
    if @episode&._links&.dig("show", "href")
      show_url = URI(@episode._links["show"]["href"])
      show_response = Net::HTTP.get(show_url)
      show_data = JSON.parse(show_response)

      @show_id = show_data["id"]
    else
      @show_id = nil
    end

    # Traduz descrição do episódio
    if @episode.summary.present?
      @translated_summary = strip_tags(@episode.summary)
    else
      @translated_summary = nil
    end
  end
end
