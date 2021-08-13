class Api::V1::ClientIssueApiController < ApplicationController
  #before_action :authenticate_api_user!

  def get_client_issue
    @client= Client.find(params[:id])
    issues = @client.issues
    clientissues = []
    for issue in issues do
      name = issue.name
      client_id = issue.client_id
      user_id = issue.user_id
      description = issue.description
      level = issue.level
      clientissues<< {
        name: name,
        client_id: client_id,
        user_id: user_id,
        description: description,
        level: level
      }
    end
    render json:clientissues
  end
end