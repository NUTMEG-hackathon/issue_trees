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

  def edit_user_issue
    @user = current_api_user
    issues = @user.issues
    @edit_issue=issues.where(id:edit_user_issue_params[:id])
    @edit_issue[0].name = edit_user_issue_params[:name]
    @edit_issue[0].description = edit_user_issue_params[:description]
    @edit_issue[0].level = edit_user_issue_params[:level]
    @edit_issue[0].save!
  end

  private
  def edit_user_issue_params
    params.require(:user_issue_api).permit(:id,:name,:description,:level)
  end
end