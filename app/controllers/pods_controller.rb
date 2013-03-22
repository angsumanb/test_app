class PodsController < ApplicationController
  
  before_filter :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user,     only: :destroy

  def show
    @pod = Pod.find(params[:id])
  end

  def new
    if (params[:project_id] != nil) 
      @project = Project.find(params[:project_id])
      @pod = Pod.new
    else
      redirect_to projects_path, notice: "Please select a project first."
    end
  end
  
  def index
    @pods = Pod.paginate(page: params[:page]) 
  end

  def create
    @project = Project.find_by_id(params[:pod][:project_id])
#    @pod = @project.pods.build(params[:pod])
    @pod = @project.pods.build(name: params[:pod][:name], description: params[:pod][:description])
    if @pod.save
      flash[:success] = "Congratulaions! You have created a new pod."
      redirect_to @pod 
    else
      render 'new'
    end

  end

  def edit 
    @pod = Pod.find(params[:id])
  end

  def update 
    @pod = Pod.find(params[:id])
    if @pod.update_attributes(params[:pod])
      flash[:success] = "Profile updated"
      redirect_to @pod
    else
      render 'edit'
    end
  end

  def destroy
    Pod.find(params[:id]).destroy
    flash[:success] = "Pod destroyed."
    redirect_to pods_url
  end
end
