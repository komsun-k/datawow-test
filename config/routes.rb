Rails.application.routes.draw do
  namespace :api do
    resources :search_requests, only: %i(index show)
    resources :categories, only: %i(show)
  end

  root to: "categories#index"
end
