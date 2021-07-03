class Api::V1::UserSkillController < ApplicationController

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