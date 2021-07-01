Rails.application.routes.draw do
  resources :project_users
  resources :user_skills
  resources :issues
  resources :issue_skills
  resources :projects
  resources :skills
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace 'api' do
    namespace 'v1' do
      # resources :users
      get "users/index" => "users#index"
      get "users/show" => "users#show"
    end
  end
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end

end
