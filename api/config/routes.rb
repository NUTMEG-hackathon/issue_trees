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
    namespace 'auth' do
      get "registrations" => "registrations#account_update_params"
      post "registrations" => "registrations#account_update_params"
    end

    namespace 'v1' do
      # resources :users
      get "users/index" => "users#index"
      get "users/show" => "users#show"
      get "projects/index" => "projects#index"
      get "projects/show" => "projects#show"
      post "users/edit_user_info" => "users#edit_user_info"
      post "users/reset_password" => "users#reset_password"


      get "get_client_issue/:id" => "client_issue_api#get_client_issue"
      get "get_issue_skill" => "issue_skill_api#get_issue_skills"
      get "get_project_client/:id" => "project_client_api#get_project_client"
      get "get_project_user" => "project_user_api#get_project_user"
      get "get_user_project/:id" => "project_user_api#get_user_project"
      get "get_user_issue" => "user_issue_api#get_user_issue"
      get "get_user_skill" => "user_skill_api#get_user_skills"

      get "current_user/show" => "current_user_api#show"
      post "current_user/edit_user_info" => "current_user_api#edit_user_info"
      put "current_user/edit_user_info" => "current_user_api#edit_user_info"
      post "current_user/password_reset" => "current_user_api#password_reset"
    end
  end
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end

end
