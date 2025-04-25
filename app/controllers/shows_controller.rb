require 'net/http'
require 'json'
require 'ostruct'
require 'uri'

class ShowsController < ApplicationController
  def show
    show_id = params[:id]

    # Dados da série
    show_url = URI("https://api.tvmaze.com/shows/#{show_id}")
    show_response = Net::HTTP.get(show_url)
    show_data = JSON.parse(show_response)

    # Traduz resumo da série
    summary = show_data["summary"] || ""
    summary_clean = ActionView::Base.full_sanitizer.sanitize(summary).strip[0...500]
    translated_summary = translate_text(summary_clean)

    show_data["summary"] = translated_summary
    @show = OpenStruct.new(show_data)

    # Episódios
    episodes_url = URI("https://api.tvmaze.com/shows/#{show_id}/episodes")
    episodes_response = Net::HTTP.get(episodes_url)
    episodes_data = JSON.parse(episodes_response)

    episodes_data.each do |ep|
      if ep["summary"]
        clean = ActionView::Base.full_sanitizer.sanitize(ep["summary"]).strip[0...500]
        ep["summary"] = translate_text(clean)
      end
    end

    @episodes_by_season = episodes_data.group_by { |ep| ep["season"] }
  end

  private

  def translate_text(text)
    return "" if text.blank?

    uri = URI("https://api-free.deepl.com/v2/translate")
    response = Net::HTTP.post_form(uri, {
      "auth_key" => ENV["DEEPL_API_KEY"],
      "text" => text,
      "target_lang" => "PT"
    })

    result = JSON.parse(response.body)
    result["translations"][0]["text"]
  rescue
    text # Se der erro, mostra o texto original
  end
end
