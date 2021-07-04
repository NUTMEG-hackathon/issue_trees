class Api::V1::ClientIssueApiController < ApplicationController
  #before_action :authenticate_api_user!

  def get_client_issue
    @client= Client.find(params[:id])
    issues = @client.issues
    clientissues = []
    for issue in issues do
      name = issue.name
      description = issue.description
      clientissues<< {
        name: name,
        description: description
      }
    end
    render json:clientissues
  end
end