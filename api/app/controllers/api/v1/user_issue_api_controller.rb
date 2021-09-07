class Api::V1::UserIssueApiController < ApplicationController
  #before_action :authenticate_api_user!

  def get_user_issue
    @user = current_api_user
    issues = @user.issues
    userIssues = []
    for issue in issues do
      id = issue.id
      name = issue.name
      description = issue.description
      level = issue.level
      userIssues << {
        id: id,
        name: name,
        description: description,
        level: level
      }
    end
    render json:userIssues
  end
end