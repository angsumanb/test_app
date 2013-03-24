require 'spec_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

describe Testcase do
  
  let(:suite) { FactoryGirl.create(:suite) }
  before { @testcase = suite.testcases.build(title: "Lorem ipsum", steps: "testcase steps", testtype: "testtype1", priority: "priority1") }

  subject { @testcase }

  it { should respond_to(:title) }
  it { should respond_to(:steps) }
  it { should respond_to(:priority) }
  it { should respond_to(:testtype) }
  it { should respond_to(:estimate) }
  it { should respond_to(:preconditions) }
  it { should respond_to(:comments) }
  it { should respond_to(:suite_id) }
  it { should respond_to(:suite) }
  its(:suite) { should == suite }

  it { should be_valid }

  describe "when title is not present" do
    before { @testcase.title = " " }
    it { should_not be_valid }
  end

  describe "when steps are not present" do
    before { @testcase.steps = " " }
    it { should_not be_valid }
  end

  describe "when testtype is not present" do
    before { @testcase.testtype = " " }
    it { should_not be_valid }
  end
 
  describe "when priority is not present" do
    before { @testcase.priority = " " }
    it { should_not be_valid }
  end
 
   describe "when title is too long" do
    before { @testcase.title = "a" * 51 }
    it { should_not be_valid }
  end

=begin
PENDING
Add a test to not let the testcase title start with
a special character or a number. It should only start
with a string/char
=end

  describe "when testcase title is already taken" do 
    before do
      testcase_with_same_title = @testcase.dup
      testcase_with_same_title.title = @testcase.title.downcase
      testcase_with_same_title.save
    end

    it { should_not be_valid }
  end

  describe "when suite_id is not present" do
    before { @testcase.suite_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to suite_id" do
      expect do
        Testcase.new(suite_id: suite.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  DatabaseCleaner.clean
end
