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
end