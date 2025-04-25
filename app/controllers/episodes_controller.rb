require 'net/http'
require 'json'
require 'ostruct'
require 'deepl'

class EpisodesController < ApplicationController
  def show
    url = URI("https://api.tvmaze.com/episodes/#{params[:id]}")
    response = Net::HTTP.get(url)
    episode_data = JSON.parse(response)

    # Prevenir erro de imagem ou show_id ausente
    @episode = OpenStruct.new(episode_data)
    @image = @episode.image ? @episode.image["original"] : nil
    @show_id = episode_data.dig("show", "id")

    # Limitar texto e traduzir
    raw_summary = episode_data["summary"] || "Sem descrição disponível"
    limited_summary = ActionView::Base.full_sanitizer.sanitize(raw_summary)[0..490]

    @translated_summary = translate_text(limited_summary)
  end

  private

  def translate_text(text)
    translator = DeepL::Translator.new(ENV["DEEPL_API_KEY"])
    translator.translate_text(text, target_lang: "PT-BR").text
  rescue
    text
  end
end
