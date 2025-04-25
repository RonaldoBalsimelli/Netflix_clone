class SearchController < ApplicationController
    def index
      if params[:query].present?
        query = params[:query]
        url = URI("https://api.tvmaze.com/search/shows?q=#{URI.encode_www_form_component(query)}")
        response = Net::HTTP.get(url)
        results = JSON.parse(response)
  
        @shows = results.map { |r| r["show"] }
      else
        @shows = []
      end
    end
  end
  