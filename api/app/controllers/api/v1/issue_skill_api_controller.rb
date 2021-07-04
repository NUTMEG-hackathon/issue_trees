class Api::V1::IssueSkillApiController < ApplicationController
  #before_action :authenticate_api_user!
  
  def get_issue_skill
    @issue = Issue.find(params[:id])
    issue_skills = @issue.issue_skills
    issueskills = []
    for issue_skill in issue_skills 
      name = issue_skill.skill.name
      status = issue_skill.skill.status
      level = issue_skill.skill.level
      issueskills << {
        name: name,
        status: status,
        level: level
      }
    end
    render json:issueskills
  end
end