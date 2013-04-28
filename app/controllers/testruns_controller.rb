class TestrunsController < ApplicationController
  
  before_filter :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user,     only: :destroy

  def show
    @testrun = Testrun.find(params[:id])
    @testcases = Testcase.find(:all) #do I need this #pendingStuff
#    @pods = @testrun.pods.paginate(page: params[:page])
  end

  def new
    @testrun = Testrun.new
    @testcases = Testcase.find(:all)
  end
  
  def index
    @testruns = Testrun.paginate(page: params[:page]) 
  end

  def create
   # @testrun = Testrun.new(params[:testrun])
#    @testcase = Testcase.find(params[:xxx])
 #   @testrun.attributes = {'testcase_ids' => []}.merge(params[:user] || {}) 
    @testrun = Testrun.new(params[:testrun])
    testcases = Testcase.find(params[:testrun][:testcase_ids]) rescue []
    @testrun.testcases = testcases
    if @testrun.save
      flash[:success] = "Congratulaions! You have created a new testrun."
      redirect_to @testrun 
    #  @testrun.testcases << @testcase
    else
      render 'new'
    end
  end

  def edit 
    @testrun = Testrun.find(params[:id])
  end

  def update 
    @testrun = Testrun.find(params[:id])
    if @testrun.update_attributes(params[:testrun])
      flash[:success] = "Profile updated"
      redirect_to @testrun
    else
      render 'edit'
    end
  end

  def destroy
    Testrun.find(params[:id]).destroy
    flash[:success] = "Testrun destroyed."
    redirect_to testruns_url
  end
end
