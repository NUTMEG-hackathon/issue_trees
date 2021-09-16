class Api::V1::IssueSkillApiController < ApplicationController
  #before_action :authenticate_api_user!

  def get_issue_skill
    @issue = Issue.find(params[:id])
    issue_skills = @issue.issue_skills
    issue_skill_ids = @issue.skill_ids
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
    issueskills << { issue_skill_ids: issue_skill_ids }
    render json:issueskills
  end

  def get_issue_skills
    @issue = Issue.find(params[:id])
    issue_skills = @issue.issue_skills
    issueSkills = []
    for issue_skill in issue_skills
      issue_id = issue_skill.issue_id
      skill_id = issue_skill.skill_id
      issueSkills << {
        issue_id: issue_id,
        skill_id: skill_id,
      }
    end
    render json:issueSkills
  end

end