class Api::V1::ProjectsController < ApplicationController
  def index
    @projects = Project.all
    render json: { status: 'SUCCESS', message: 'Loaded projects', data: @projects }
  end
  
  def show
    @projects = Project.find(params[:id])
    render json: { data: @projects }
  end
end