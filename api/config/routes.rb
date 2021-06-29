Rails.application.routes.draw do
  resources :project_users
  resources :user_skills
  resources :issues
  resources :issue_skills
  resources :projects
  resources :skills
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
