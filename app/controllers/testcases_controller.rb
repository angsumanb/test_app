class TestcasesController < ApplicationController
  
  before_filter :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user,     only: :destroy

  def show
    @testcase = Testcase.find(params[:id])
    @suite = Suite.find(@testcase.suite)
  end
  
  def new
    if (params[:suite_id] != nil) 
      @suite = Suite.find(params[:suite_id])
      @testcase = Testcase.new
    else
      redirect_to suites_path, notice: "Please select a suite first."
    end
  end
  
  def index
    @testcases = Testcase.paginate(page: params[:page]) 
  end

  def create
    @suite = Suite.find_by_id(params[:testcase][:suite_id])
#    @testcase = @suite.testcases.build(params[:testcase])
    @testcase = @suite.testcases.build(title: params[:testcase][:title], steps: params[:testcase][:steps], testtype: params[:testcase][:testtype], priority: params[:testcase][:priority], estimate: params[:testcase][:estimate])
#    @testcase = @suite.testcases.build(title: params[:testcase])
    if @testcase.save
      flash[:success] = "Congratulaions! You have created a new testcase."
      redirect_to @testcase 
    else
      render 'new'
    end

  end

  def edit 
    @testcase = Testcase.find(params[:id])
  end

  def update 
    @testcase = Testcase.find(params[:id])
    if @testcase.update_attributes(params[:testcase])
      flash[:success] = "Testcase updated"
      redirect_to @testcase
    else
      render 'edit'
    end
  end

  def destroy
    Testcase.find(params[:id]).destroy
    flash[:success] = "Testcase destroyed."
    redirect_to testcases_url
  end
end
