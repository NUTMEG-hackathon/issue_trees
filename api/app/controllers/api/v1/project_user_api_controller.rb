class Api::V1::ProjectUserApiController < ApplicationController
  #before_action :authenticate_api_user!
  
  def get_project_user
    @user = current_api_user
    project_users = @user.project_users
    projects = []
    for project_user in project_users
      project_id = project_user.project_id
      name = project_user.project.name 
      projects <<{
        project_id: project_id,
        name:name
    }
    end
    render json:projects
    
  end
end