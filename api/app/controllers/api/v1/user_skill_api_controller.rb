class Api::V1::UserSkillApiController < ApplicationController

  def get_user_skills
    @user = current_api_user
    user_skills = @user.user_skills
    skills = []
    for user_skill in user_skills
      name = user_skill.skill.name
      status = user_skill.skill.status
      level = user_skill.skill.level
      skills << {
        name: name,
        status: status,
        level: level
      }
    end
    render json:skills
  end

  def get_user_skill_details
    @user = User.find(params[:id])
    skills = @user.skills
    user_skill_details = []
    skill_details = []
    for skill in skills
      skill_name = skill.name
      skill_details << {
        skill_name: skill_name,
      }
    end
    user_skill_details << {
      user_name: @user.name,
      skill_names: skill_details,
    }
    render json: user_skill_details
  end

  def edit_user_skill
    @user_skill = UserSkill.find(params[:id])
    @user_skill.id = edit_user_project_params[:id]
    @user_skill.name = edit_user_project_params[:name]
    @user_skill.status = edit_user_project_params[:status]
    @user_skill.level = edit_user_project_params[:level]
    @user_skill.save!
  end

  private
    def edit_user_project_params
      params.require(:user_skill_api).permit(:id, :name, :status, :level)
    end

end