class Api::V1::CurrentUserApiController < ApplicationController
  #  before_action :authenticate_api_user!
  
  def show
    @user = current_api_user
    render json: { data: @user }
  end

  def get_user_detail
    @user = current_api_user
    user_detail = {
     user: @user
    }
    render json: user_detail
  end

  def get_details
    @users = User.all
    user_details = []
    for i in (0...@users.length)
      @user=@users[i]
      user_skills = @user.skills
      user_projects = @user.project_users
      projects = []
      skills = []
      for user_skill in user_skills
        skill_name = user_skill.name
        skills << {
          skill_name: skill_name,
        }
      end
      for user_project in user_projects
        project_name = user_project.project.name
        projects << {
          project_name: project_name
        }
      end
      user_name = @user.name
      user_details << {
        user_name: user_name,
        skills: skills,
        projects: projects
      }
   end
   render json: user_details
  end

  def password_reset 
    @user = current_api_user
    @user.password = password_reset_params[:password]
    @user.password_confirmation = password_reset_params[:password_confirmation]
    @user.save!
  end


  def edit_user_info
    @user = current_api_user
    @user.name = edit_user_info_params[:name]   
    @user.email = edit_user_info_params[:email]
    @user.save!
  end

  private
    def edit_user_info_params
      params.require(:current_user_api).permit(:name, :email)
    end

    def password_reset_params
      params.permit(:password, :password_confirmation)
    end
end
