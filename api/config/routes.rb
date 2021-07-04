Rails.application.routes.draw do
  resources :clients
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
      get "projects/index" => "projects#index"
      get "projects/show" => "projects#show"
      

      get "get_client_issue" => "client_issue_api#get_client_issue"
      get "get_issue_skill" => "issue_skill_api#get_issue_skill"
      get "get_project_client" => "project_client_api#get_project_client"
      get "get_project_user" => "project_user_api#get_project_user"
      get "get_user_issue" => "user_issue_api#get_user_issues"
      get "get_user_skill" => "user_skill_api#get_user_skill"
      get "get_client_name" => "client_issue_api#get_client_name"
    end
  end
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end

end
