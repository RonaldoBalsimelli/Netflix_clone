module ApplicationHelper
    require 'net/http'
    require 'uri'
    require 'json'
  
    def traduzir_para_portugues(texto)
      return "" if texto.blank?
  
      url = URI("https://api.mymemory.translated.net/get?q=#{URI.encode_www_form_component(texto)}&langpair=en|pt-BR")
      response = Net::HTTP.get(url)
      data = JSON.parse(response)
  
      data["responseData"]["translatedText"]
    rescue => e
      texto # se der erro, retorna o texto original
    end
  end
  