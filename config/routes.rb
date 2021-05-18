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
    post :search_and_filter, on: :collection
    post :add_favourite, on: :member
    post :complete, on: :member
    post :delete_favourite, on: :member
    get :start_conversation, on: :member
    post :swap_conversation, on: :member
    get :swap, on: :member
    post :delete_conversation, on: :member
    get :rating, on: :member
    post :add_rating, on: :member
    post :delete_rating, on: :member
    get :report, on: :member
    post :send_report, on: :member
  end
  
  resources :users do
    post :search, on: :collection
  end
  
  scope :profile do
    get :mylistings, to: 'listings#mylistings'
    get :reviews, to: 'users#reviews'
    get :settings, to: 'users#settings'
    resources :user_favourites
    resources :conversations do
      resources :conversation_messages, except: :create do
        get :report, on: :member
        post :send_report, on: :member
        post :send_message, :as => 'send', on: :member
        patch :delete_message, :as => 'delete', on: :member
      end
    end
  end

  # Admin Pages
  scope :admin do
    resources :reports do
      get :see_message, on: :member
      get :moderate, on: :member
      post :moderate_update, on: :member
    end
    get :moderation, to: 'admin#moderation'
    get :statistics, to: 'admin#statistics'
    get :other, to: 'admin#other'
    post :other, to: 'admin#site_settings'
    get :promote_user, to: 'admin#get_admin'
    post :promote_user, to: 'admin#promote'
    post :demote_user, to: 'admin#demote'
    get :add_question, to: 'admin#get_question'
    post :add_question, to: 'admin#add_question'
    post :remove_question, to: 'admin#remove_question'
    post :approve_listing, to: 'admin#approve_listing'
    get :ban_user, to: 'admin#get_user'
    post :ban_user, to: 'admin#ban_user'
    post :unban_user, to: 'admin#unban_user'
    get :user_view, to: 'admin#user_view'
    get :view_listings, to: 'admin#view_listings'
  end
  
  # Static Pages
  get :contact, to: "pages#contact"
  post :contact, to: "pages#contact_mail"
  get :terms, to: "pages#terms"
  get :faq, to: "pages#faq"
  get :about, to: "pages#about"
  get :covid, to: "pages#covid"

  # Error Routes

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  # Home Page

  root to: 'listings#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
