class TestresultsController < ApplicationController
  def new
  end

  def makePass 
    @testrun = Testrun.find(params[:testrunId])
    testcase_id = params[:testcaseId]
    @testresult = Testresult.find_by_testrun_id_and_testcase_id(params[:testrunId], params[:testcaseId])
    @testresult.update_attributes(status: "Passed")
    respond_to do |format|
      format.html { redirect_to @testrun }
      format.js
    end
  end
end
