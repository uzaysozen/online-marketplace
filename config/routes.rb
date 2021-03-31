Rails.application.routes.draw do

  mount EpiCas::Engine, at: "/"
  devise_for :users
  resources :notifications
  resources :messages
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
    scope :profile do
      collection do
        get :mylistings
      end
    end
  end
  resources :reports
  resources :user_favourites
  resources :users do
    post :search, on: :collection
  end
  
  resources :listings do
    scope :profile do
      resources :conversations
    end
    resources :conversation_messages, except: :create
    post 'conversation_messages/:id' => 'conversation_messages#create'
  end

  resource :listing do
    get :mylistings
  end
  scope :profile do
    resources :conversations do
      resources :conversation_messages, except: :create do
        member do
          post :send_message, :as => 'send'
          patch :delete_message, :as => 'delete'
        end
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
  get "pages/admin" => "pages#admin"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
