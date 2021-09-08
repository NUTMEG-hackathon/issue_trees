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
