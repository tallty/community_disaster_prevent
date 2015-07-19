Rails.application.routes.draw do
  
  devise_for :users
  root 'admin/home#index'
  mount Ckeditor::Engine => '/ckeditor'
  mount WeixinRailsMiddleware::Engine, at: "/"

  resources :articles, only: [:show]
  namespace :admin do
    resources :home, only: [:index]
    resources :diymenus
    resources :disaster_pictures
    resources :volunteers
    resources :subscribers
    resources :communities
    resources :disaster_positions
    resources :disasters
    resources :articles
    resources :message_processors
  end

  resource :upload_file, only: [:create]
  
end
