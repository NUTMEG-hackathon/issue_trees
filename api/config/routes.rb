Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :project_users
  resources :user_skills
  resources :issues
  resources :issue_skills
  resources :projects
  resources :skills
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
