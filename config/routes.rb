Rails.application.routes.draw do
  get 'statistics/index'
  resources :statistics, only: [] do
    collection do
      get 'visits_use_social'
      get 'loads_images_from_flickr'
      get 'results_review_cards'
      get 'visits_from_countries'
    end
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  filter :locale

  root 'main#index'

  scope module: 'home' do
    resources :user_sessions, only: [:new, :create]
    resources :users, only: [:new, :create]
    get 'login' => 'user_sessions#new', :as => :login

    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/callback' => 'oauths#callback'
    get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  end

  scope module: 'dashboard' do
    get '/search' => 'search#new'
    resources :user_sessions, only: :destroy
    resources :users, only: [:destroy, :index]
    post 'scrap' => 'fill#scrap'
    get 'add' => 'fill#add'
    get 'recent' => 'fill#index'
    delete 'logout' => 'user_sessions#destroy', :as => :logout

    resources :cards

    resources :blocks do
      member do
        put 'set_as_current'
        put 'reset_as_current'
      end
    end

    put 'review_card' => 'trainer#review_card'
    get 'trainer' => 'trainer#index'

    get 'profile/:id/edit' => 'profile#edit', as: :edit_profile
    put 'profile/:id' => 'profile#update', as: :profile
  end
end
