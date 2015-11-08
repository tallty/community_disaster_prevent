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
  resources :disasters, only: [:index, :new, :show, :create] do
    collection do
      get :get_disaster
    end
  end
  resources :disaster_pictures, only: [:new, :create]
  resource :monitor_stations, only: [:show]
  resources :surveys
  
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
