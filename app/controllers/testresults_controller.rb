class TestresultsController < ApplicationController
  def new
  end
#PendingStuff
#The following 4 methods can be cut down to only 1 mehtod. Just pass
# the status along with other parameters


  def changeStatus 
    @testrun = Testrun.find(params[:testrunId])
    testcase_id = params[:testcaseId]
    newStatus = params[:newStatus]
    @testresult = Testresult.find_by_testrun_id_and_testcase_id(params[:testrunId], params[:testcaseId])
    @testresult.update_attributes(status: params[:newStatus])
    respond_to do |format|
      format.html { redirect_to @testrun }
      format.js
    end
  end
 
=begin 
  def makePassed 
    @testrun = Testrun.find(params[:testrunId])
    testcase_id = params[:testcaseId]
    @testresult = Testresult.find_by_testrun_id_and_testcase_id(params[:testrunId], params[:testcaseId])
    @testresult.update_attributes(status: "Passed")
    respond_to do |format|
      format.html { redirect_to @testrun }
      format.js
    end
  end
  
  def makePending 
    @testrun = Testrun.find(params[:testrunId])
    testcase_id = params[:testcaseId]
    @testresult = Testresult.find_by_testrun_id_and_testcase_id(params[:testrunId], params[:testcaseId])
    @testresult.update_attributes(status: "Pending")
    respond_to do |format|
      format.html { redirect_to @testrun }
      format.js
    end
  end

  def makeFailed 
    @testrun = Testrun.find(params[:testrunId])
    testcase_id = params[:testcaseId]
    @testresult = Testresult.find_by_testrun_id_and_testcase_id(params[:testrunId], params[:testcaseId])
    @testresult.update_attributes(status: "Failed")
    respond_to do |format|
      format.html { redirect_to @testrun }
      format.js
    end
  end

  def makeBlocked 
    @testrun = Testrun.find(params[:testrunId])
    testcase_id = params[:testcaseId]
    @testresult = Testresult.find_by_testrun_id_and_testcase_id(params[:testrunId], params[:testcaseId])
    @testresult.update_attributes(status: "Blocked")
    respond_to do |format|
      format.html { redirect_to @testrun }
      format.js
    end
  end
=end
end
