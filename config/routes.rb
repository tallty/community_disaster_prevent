Rails.application.routes.draw do

  devise_for :users
  root 'admin/home#index'
  mount Ckeditor::Engine => '/ckeditor'
  mount WeixinRailsMiddleware::Engine, at: "/"

  resources :warnings, only: [:show]
  resources :articles, only: [:show]
  resources :aqi, only: [:show]
  resource :volunteers, only: [:new, :create, :update]
  resource :subscribers, only: [:new, :update] do
    collection do
      get :get_districts
    end
  end
  resources :disasters

  namespace :admin do
    resources :home, only: [:index]
    resources :diymenus
    resources :disaster_pictures
    resources :volunteers
    resources :subscribers
    resources :communities do
      collection do
        get :get_streets
        get :get_districts
      end
    end
    resources :disaster_positions
    resources :disasters
    resources :articles
    resources :message_processors
    resources :article_managers
    resources :send_logs
    resources :monitor_stations
    resources :users
  end

  resource :upload_file, only: [:create]

end
