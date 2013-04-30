class StaticPagesController < ApplicationController

  respond_to :html, :json, :xml
  def home
  end

  def help
  end

  def about 
  end

  def contact
  end

  def dashboard
    @latestRun = Testrun.first(order: 'created_at DESC')
    @totalcases = @latestRun.testresults.count
    @passed = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Passed"])
    @pending = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Pending"])
    @failed = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Failed"])
    @blocked = @latestRun.testresults.find(:all, :conditions => ["status = ? ", "Blocked"])
    
    respond_with(@pending)

  end
end
