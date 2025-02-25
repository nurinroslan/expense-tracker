Rails.application.routes.draw do
  # Devise authentication routes
  devise_for :users

  # Resources for your main models
  resources :expenses
  resources :categories do
    resources :category_budgets, only: [:new, :create, :edit, :update]
  end

  # Set the root path to a valid controller
  root to: "expenses#index"

  # Route for updating the monthly budget using the month-specific method.
  post 'update_budget', to: 'expenses#update_budget'

  # Root path logic: Redirect based on authentication status
  authenticated :user do
    root to: 'expenses#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'devise/sessions#new', as: :unauthenticated_root
  end
end
