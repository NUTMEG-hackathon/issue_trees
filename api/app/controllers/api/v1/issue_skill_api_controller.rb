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

  def get_issue_skill_ids
    @issue = Issue.find(params[:id])
    issue_skill_ids = @issue.skill_ids
    render json:issue_skill_ids
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