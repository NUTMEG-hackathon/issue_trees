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

  def edit_user_info
    p "=================="
    p "aaaaaaaaaa"
    p "=================="
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
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

    def reset_password_params
      params.permit(:user_id, :password, :password_confirmation)
    end

end