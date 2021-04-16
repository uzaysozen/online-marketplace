Rails.application.routes.draw do

  mount EpiCas::Engine, at: "/"
  devise_for :users
  resources :listing_conditions do
    post :search, on: :collection
  end
  resources :listing_statuses do
    post :search, on: :collection
  end
  resources :listing_categories do
    post :search, on: :collection
  end
  resources :listing_questions do
    post :search, on: :collection
  end
  resources :listing_ratings do
    post :search, on: :collection
  end
  
  resources :listing_views

  resources :listings do
    post :search, on: :collection
    post :add_favourite, on: :member
    post :delete_favourite, on: :member
    get :start_conversation, on: :member
    post :delete_conversation, on: :member
  end
  
  resources :users do
    post :search, on: :collection
  end
  
  scope :profile do
    get :mylistings, to: 'listings#mylistings'
    resources :user_favourites
    resources :conversations do
      resources :conversation_messages, except: :create do
        post :send_message, :as => 'send', on: :member
        patch :delete_message, :as => 'delete', on: :member
      end
    end
  end

  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  root to: "pages#home"
  scope :admin do
    resources :reports
    get :moderation, to: 'admin#moderation'
    get :statistics, to: 'admin#statistics'
    get :other, to: 'admin#other'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
