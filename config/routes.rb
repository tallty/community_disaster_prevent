Rails.application.routes.draw do

  resources :publish_surveys
  devise_for :users
  root 'admin/disasters#index'
  mount Ckeditor::Engine => '/ckeditor'
  mount WeixinRailsMiddleware::Engine, at: "/"

  resources :warnings, only: [:show]
  resources :articles, only: [:show]
  resources :aqi, only: [:show]

  resource :volunteers, only: [:new, :create, :update]
  resource :subscribers, only: [:new, :update] do
    collection do
      get :get_streets
    end
  end
  resources :disasters do
    collection do
      get :get_disaster
    end
  end
  resources :disaster_pictures, only: [:new, :create]
  resources :disaster_positions, only: [:new, :create]
  resource :monitor_stations, only: [:show]
  resources :surveys

  resources :oauths, only: [:index] do
    collection do 
      get :check
    end
  end

  # 预报服务（全市预警、五日预报、气象指数、空气质量、健康气象）
  resources :forecast_services do
    collection do
      get :locate
      get :city_warn
      get :five_day_weather
      get :life_index
      get :air_quality
      get :healthy_weather
    end
  end
  
  # 社区
  resources :communities do
    collection do
      get :interact
      get :detection
      get :centre
      get :change_community
    end
  end

  namespace :admin do
    resources :survey_results, only: [:show]
    
    resources :surveys do
      resources :questions, only: [] do 
        member do
          get :draw
        end
      end
    end
    resources :home, only: [:index]
    resources :diymenus
    resources :disaster_pictures
    resources :volunteers do
      collection do
        get :down
      end
    end
    resources :subscribers
    resources :communities do
      collection do
        get :get_streets
        get :get_districts
        get :search
      end
      member do
        get :switch
      end
    end
    resources :publish_surveys do
      member do
        get :switch
      end
    end
    resources :disaster_positions
    resources :disasters
    resources :articles
    resources :message_processors
    resources :article_managers
    resources :send_logs
    resources :monitor_stations do
      collection do
        get :down
      end
    end
    resources :users
    resources :questions
  end

  resource :upload_file, only: [:create]
end
