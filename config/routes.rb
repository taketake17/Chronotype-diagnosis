Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "tops" =>"tops#index"
  root "tops#index"

  resources :question_first
  get "dolphin"=>"chronotype#dolphin"
  get "question_second"=>"question_second#index"

  resources :question_second
  get "wolf"=>"chronotype#wolf"
  get "bear"=>"chronotype#bear"
  get "lion"=>"chronotype#lion"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
