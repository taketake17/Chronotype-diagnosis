Rails.application.routes.draw do
  get "calendar/index"
  get "users/show"
  devise_for :users, controllers: {
  omniauth_callbacks: "users/omniauth_callbacks",
  registrations: "users/registrations"
  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  resources :users, only: [ :show ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "tops" =>"tops#index"
  root "tops#index"
  get "description" =>"tops#description"
  get "terms_of_service" =>"tops#terms_of_service"
  get "privacy_policy"=>"tops#privacy_policy"



  get "question_first"=>"question_first#index"
  get "question_second"=>"question_second#index"

  resources :question_first

  resources :question_second

  get "chronotype/summary/bear"=>"chronotype#bear"
  get "chronotype/summary/lion"=> "chronotype#lion"
  get "chronotype/summary/wolf"=>"chronotype#wolf"
  get "chronotype/summary/dolphin"=> "chronotype#dolphin"

  get "chronotype/details/bear"=>"chronotype#details_bear"
  get "chronotype/details/lion"=>"chronotype#details_lion"
  get "chronotype/details/wolf"=>"chronotype#details_wolf"
  get "chronotype/details/dolphin"=> "chronotype#details_dolphin"

  resources :calendar, only: [ :index, :create, :update, :destroy ] do
    collection do
      get "index.json", to: "calendar#index", defaults: { format: "json" }
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
