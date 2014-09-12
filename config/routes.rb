Rails.application.routes.draw do
  resources :albums, only: [:create, :play, :stop] do
    member do
      get 'play'
      get 'stop'
    end
    post 'create'
  end
  resources :playlist, only: [:index, :history, :add, :update_playlist, :update_now_playing, :load_releases] do
    collection do
      get 'index'
      get 'history'
      get 'add'
      get 'update_playlist'
      get 'update_now_playing'
      get 'load_releases'
    end
  end
  resource :discogs, only: [:callback]
  root 'playlist#index'
end