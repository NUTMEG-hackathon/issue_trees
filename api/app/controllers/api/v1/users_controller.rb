class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_user!


  def index
    @users = User.all
    render json: { status: 'SUCCESS', message: 'Loaded users', data: @users }
  end

  def show
    @user = current_api_user
    render json: { data: @user }
  end

  def update
    @user = User.find(params[:id])
    @user.update(edit_user_info)
    render json: @user
  end

  def getUserSkills
    @user = current_api_user
    @userSkills = @user.user_skills
    @skills = [],
    for @userSkill in @userSkills
      @skill = @userSkill.skills
      @skills << {
        skill: skill
      }
    end
    render json: { data: @skills }
  end

  def get_user_details
    @user = User.find(params[:id])
    render json: @user
  end

  def get_user_skill_ids
    @user = User.find(params[:id])
    @user_skill_ids = @user.skill_ids
    render json: @user_skill_ids
  end

  def edit_user_info
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.save!
  end

  def edit_user_skills
    @user = User.find(params[:id])
    @user.skill_ids = edit_user_skills_params[:skill_ids]
    @user.save!
  end

  def reset_password
    @user = User.find(reset_password_params[:id])
    @user.password = reset_password_params[:password]
    @user.password_confirmation = reset_password_params[:password_confirmation]
    @user.save!
  end

  private
    #issue96で直したところ
    def edit_user_info_params
      params.permit(user_id, :name, :email)
    end

    def edit_user_skills_params
      params.permit(skill_ids: [])
    end

    def reset_password_params
      params.permit(:user_id, :password, :password_confirmation)
    end

end