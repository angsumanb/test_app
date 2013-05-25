class StaticPagesController < ApplicationController

  respond_to :html, :json, :xml

  before_filter :find_runs, only: [:dashboard, :dashboard1]
  before_filter :signed_in_user, only: [:dashboard, :dashboard1]
 
  def home
  end

  def pendingstuff 
  end
  
  def help
  end

  def about 
  end

  def contact
  end

  def dashboard 
    if (@runs.size > 0)
    #@latestRun = Testrun.first(order: 'created_at DESC')
    @latestRun = @runs.first 
    @totalcases = @latestRun.testresults.count
    @passed = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Passed"])
    @pending = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Pending"])
    @failed = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Failed"])
    @blocked = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Blocked"])
    
    respond_with(@passed)
    end
  end
#PendingStuff 
# integrate dashboard and dashboard1
  def dashboard1
   if (@runs.size > 0)
#    @latestRun = Testrun.first(order: 'created_at DESC')
    @latestRun = Testrun.find(params[:testrunId])
    @totalcases = @latestRun.testresults.count
    @passed = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Passed"])
    @pending = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Pending"])
    @failed = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Failed"])
    @blocked = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Blocked"])
    
    respond_with(@passed)
    end
  end
  private 
  def find_runs
    @runs = Testrun.all
  end
end
