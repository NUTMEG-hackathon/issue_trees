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

  def edit_user
    @user = User.find(edit_user_params[:user_id])
    @user.name = edit_user_info_params[:name]
    @user.email = edit_user_info_params[:email]
    @user.save!
  end

  def reset_password
    @user = User.find(reset_password_params[:user_id])
    @user.password = reset_password_params[:password]
    @user.password_confirmation = reset_password_params[:password_confirmation]
    @user.save!
  end

end