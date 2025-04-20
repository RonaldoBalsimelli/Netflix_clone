Rails.application.routes.draw do
  root 'shows#index'
  resources :shows, only: [:index, :show]
end
