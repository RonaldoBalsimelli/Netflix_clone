Rails.application.routes.draw do
  root "shows#index"

  resources :shows, only: [:index, :show] do
    resources :episodes, only: [:index, :show]
    resources :actors, only: [:index, :show]
  end
end
