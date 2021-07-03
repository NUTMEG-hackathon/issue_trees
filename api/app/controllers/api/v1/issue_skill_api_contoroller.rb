class Api::V1::IssueSkillsApiController < ApplicationController
  #before_action :authenticate_api_user!
  
  def get_issue_skills
    @issue = current_api_issue
    issue_skills = @issue.issue_skill
    issueskills = []
    for issue_skill in issue_skills 
      name = issue_skill.skill.name
      description = issue_skill.skill.description
      level = issue_skill.skill.level
      userIssue << {
        name: name,
        description: description,
        level: level
      }
    end
    render json:issueskills
  end
end