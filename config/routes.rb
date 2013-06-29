TakeANumber::Application.routes.draw do
  devise_for :admin_users, controllers: { sessions: "frontend/users/sessions" }

  devise_scope :admin_user do
    get    "/sign_in"  => "frontend/users/sessions#new"
    delete "/sign_out" => "frontend/users/sessions#destroy"
    get    "/sign_out" => "frontend/users/sessions#destroy"
  end

  StaticPagesController::PAGES.each do |page|
    get "/#{page}", to: "static_pages##{page}", as: page
  end

  namespace :admin do
    root to: "locations#index"

    resources :customers
    resources :locations do
      member do
        get :open
        get :close
        get :refresh
      end
    end
    resources :scheduled_events
    resources :unscheduled_events, only: [ :index ] do
      member do
        post :sort
      end
    end

    resources :service_providers do
      member do
        get :finish
        get :activate
        get :deactivate
      end
    end
  end

  namespace :frontend do
    root to: "locations#index"
    resources :locations, only: [ :index ] do
      resources :customers, only: [ :new, :create ]
    end
  end

  namespace :api do
    resources :messages, only: [] do
      collection do
        post :handle_response
      end
    end
  end

  root to: "frontend/locations#index"
end
