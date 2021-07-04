class Api::V1::ProjectClientApiController < ApplicationController
  #before_action :authenticate_api_user!

  def get_project_client
    @project= Project.find(params[:id])
    clients = @project.clients
    projectclients = []
    for client in clients do
      name = client.name
      projectclients<< {
        name: name
      }
    end
    render json:projectclients
  end
end