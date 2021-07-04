class Api::V1::ProjectClientsApiController < ApplicationController
  #before_action :authenticate_api_user!

  def get_project_client
    @project= current_api_project
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