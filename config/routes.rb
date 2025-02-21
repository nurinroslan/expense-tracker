Rails.application.routes.draw do
  devise_for :users

  resources :expenses
  resources :categories
  
  # Redirect root path to login page if user is not signed in
  authenticated :user do
    root to: 'expenses#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'devise/sessions#new', as: :unauthenticated_root
  end
  
  # Route for updating the monthly budget
  post 'update_budget', to: 'budgets#update'
end

