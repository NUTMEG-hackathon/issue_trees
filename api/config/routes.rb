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
      post "users/edit_user_info" => "users#edit_user_info"
      post "users/reset_password" => "users#reset_password"
      put "edit_user_skills/:id" => "users#edit_user_skills"
      get "user_details/:id" => "users#get_user_details"
      get "get_user_skill_ids/:id" => 'users#get_user_skill_ids'


      #api周り
      get "get_client_issue/:id" => "client_issue_api#get_client_issue"
      get "get_issue_skill/:id" => "issue_skill_api#get_issue_skill"
      get "get_issue_skill_ids/:id" => "issue_skill_api#get_issue_skill_ids"
      get "get_issue_skills/:id" => "issue_skill_api#get_issue_skills"
      get "get_project_client/:id" => "project_client_api#get_project_client"
      get "get_project_user" => "project_user_api#get_project_user"
      get "get_project_users/:id" => "project_user_api#get_project_users"
      get "get_user_project_ids/:id" => 'project_user_api#get_user_project_ids'
      get "get_user_project/:id" => "project_user_api#get_user_project"
      get "get_user_issue" => "user_issue_api#get_user_issue"
      get "get_user_skill" => "user_skill_api#get_user_skills"
      get "get_user_skill_details/:id" => "user_skill_api#get_user_skill_details"
      get "get_issue_details/:id" => "issue_detail_api#get_issue_detail"
      get "get_issue_user/:id" => "issue_detail_api#get_issue_user"
      get "get_details" => "current_user_api#get_details"

      get "current_user/show" => "current_user_api#show"


      #編集api
      put "current_user/edit_user_info" => "current_user_api#edit_user_info"
      put "project_user/edit_user_projects/:id" => "project_user_api#edit_user_projects"
      post "project_user/edit_project_users/:id" => "project_user_api#edit_project_users"
      put "userskill/edit_user_skill" => "user_skill_api#edit_user_skill"
      put "userissue/edituserissue" => "user_issue_api#edit_user_issue"
      get "current_user/get_user_detail" => "current_user_api#get_user_detail"
      #post "current_user/password_reset" => "current_user_api#password_reset"
    end
  end
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end

end
