# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :check_lead_comtor

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @project = Project.new project_params
    if @project.save
      @projects = Project.order("created_at desc")
      respond_to do |format|
        format.js
      end
    else
      render :new
    end
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy
    @projects = Project.all
    respond_to do |format|
      format.js
    end
  end

  private

  def project_params
    params.require(:project).permit :name, :color_code
  end
end
