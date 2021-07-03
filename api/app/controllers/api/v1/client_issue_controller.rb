class Api::V1::ClientIssueController < ApplicationController
  #before_action :authenticate_api_user!

  def get_client_issue
    @client= current_api_client
    issues = @project.issues
    clientissues = []
    for issue in issues do
      name = issue.name
      description = issue.description
      clientissues<< {
        name: name
        description: description
      }
    end
  render json:clientissues

end