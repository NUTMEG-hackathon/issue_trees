class Api::V1::IssueDetailApiController < ApplicationController
    def get_issue_detail
        issuedetails=[]
        @issue = Issue.find(params[:id])
        issue_id = @issue.id
        issue_name = @issue.name
        issue_description = @issue.description
        issue_level = @issue.level
        issue_user_name = @issue.user.name
        issuedetails << {
            issue_id: issue_id,
            issue_name: issue_name,
            issue_description: issue_description,
            issue_level: issue_level,
            user_name: issue_user_name
        }
        issue_skills = @issue.issue_skills
        for issue_skill in issue_skills
          id = issue_skill.skill.id
          name = issue_skill.skill.name
          status = issue_skill.skill.status
          level = issue_skill.skill.level
          issuedetails << {
            skill_id: id,
            skill_name: name,
            skill_status: status,
            skill_level: level
          }
        end
        render json:issuedetails
    end
end
