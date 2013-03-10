class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:success] = "Congratulaions! You have created a new project."
      redirect_to @project 
    else
      render 'new'
    end
  end
end
