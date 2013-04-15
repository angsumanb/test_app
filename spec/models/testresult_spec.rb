require 'spec_helper'

describe Testresult do

  before { @testresult = Testresult.new(status: "Passed", comments: "Example testresult comments") }

  subject { @testresult }

  it { should respond_to(:status) }
  it { should respond_to(:comments) }
  it { should respond_to(:testcase) }
  it { should respond_to(:testrun) }
  it { should respond_to(:testcase_id) }
  it { should respond_to(:testrun_id) }

  it { should be_valid }

  describe "when status is not present" do
    before { @testresult.status = " " }
    it { should_not be_valid }
  end


  describe "when status is not in the SOPTIONS list" do
    before { @testresult.status = "somestatus" }
    it { should_not be_valid }
  end

=begin
PENDING
Add a test to not let the testresult status start with
a special character or a number. It should only start
with a string/char
=end


end
