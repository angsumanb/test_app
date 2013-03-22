class SuitesController < ApplicationController
  
  before_filter :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user,     only: :destroy

  def show
    @suite = Suite.find(params[:id])
  end
  
  def new
    if (params[:pod_id] != nil) 
      @pod = Pod.find(params[:pod_id])
      @suite = Suite.new
    else
      redirect_to pods_path, notice: "Please select a pod first."
    end
  end
  
  def index
    @suites = Suite.paginate(page: params[:page]) 
  end

  def create
    @pod = Pod.find_by_id(params[:suite][:pod_id])
#    @suite = @pod.suites.build(params[:suite])
    @suite = @pod.suites.build(name: params[:suite][:name], description: params[:suite][:description])
    if @suite.save
      flash[:success] = "Congratulaions! You have created a new suite."
      redirect_to @suite 
    else
      render 'new'
    end

  end

  def edit 
    @suite = Suite.find(params[:id])
  end

  def update 
    @suite = Suite.find(params[:id])
    if @suite.update_attributes(params[:suite])
      flash[:success] = "Suite updated"
      redirect_to @suite
    else
      render 'edit'
    end
  end

  def destroy
    Suite.find(params[:id]).destroy
    flash[:success] = "Suite destroyed."
    redirect_to suites_url
  end
end
