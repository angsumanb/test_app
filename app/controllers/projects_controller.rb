class ProjectsController < ApplicationController
  
  before_filter :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user,     only: :destroy

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end
  
  def index
    @projects = Project.paginate(page: params[:page]) 
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

  def edit 
    @project = Project.find(params[:id])
  end

  def update 
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:success] = "Profile updated"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Project destroyed."
    redirect_to projects_url
  end
end
