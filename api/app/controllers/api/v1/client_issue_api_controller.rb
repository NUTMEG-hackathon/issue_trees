class Api::V1::ClientIssueApiController < ApplicationController
  #before_action :authenticate_api_user!

  # def get_client_name
  #   clients = Client.all
  #   client_list = []
  #   for client in clients
  #     client_list << {
  #       id:client.id,
  #       name: client.name
  #     }
  #   end
  #   render json:client_list
  # end




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