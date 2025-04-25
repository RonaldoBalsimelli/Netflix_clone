Rails.application.routes.draw do
  root "home#index"

  get "/search", to: "home#index"  # redireciona busca para o mesmo controller da home

  resources :shows, only: [:show]
  resources :episodes, only: [:show]
end
