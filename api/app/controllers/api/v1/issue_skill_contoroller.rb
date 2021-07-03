class Api::V1::IssueSkillController < ApplicationController
  #before_action :authenticate_api_user!
  
  def get_issue_skills
    @issue = current_api_issue
    issue_skills = @issue.issue_skill
    issuekills = []
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
  render json:issuekills

end