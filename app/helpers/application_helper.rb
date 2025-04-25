module ApplicationHelper
    require 'net/http'
    require 'uri'
    require 'json'
  
    def translate_text(text)
      require "net/http"
      require "json"
    
      uri = URI("https://api.mymemory.translated.net/get?q=#{URI.encode(text)}&langpair=en|pt")
      res = Net::HTTP.get(uri)
      json = JSON.parse(res)
      json["responseData"]["translatedText"]
    end
  end