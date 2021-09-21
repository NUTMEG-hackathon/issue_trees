class Api::V1::ProjectClientApiController < ApplicationController
  #before_action :authenticate_api_user!

  def get_project_client
    @project= Project.find(params[:id])
    clients = @project.clients
    projectclients = []
    for client in clients do
      client_id = client.id
      name = client.name
      projectclients<< {
        client_id: client_id,
        name: name
      }
    end
    render json:projectclients
  end
end