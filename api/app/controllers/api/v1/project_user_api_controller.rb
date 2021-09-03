class Api::V1::ProjectUserApiController < ApplicationController
  #before_action :authenticate_api_user!
  
  def get_project_user
    @user = current_api_user
    project_users = @user.project_users
    projects = []
    for project_user in project_users
      name = project_user.project.name 
      id = project_user.project.id
      projects <<{
      name:name,
      id:id
    }
    end
    render json:projects
    
  end
end