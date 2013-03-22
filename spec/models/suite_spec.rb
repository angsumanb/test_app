require 'spec_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

describe Suite do
  
  let(:pod) { FactoryGirl.create(:pod) }
  before { @suite = pod.suites.build(name: "Lorem ipsum", description: "suite description") }

  subject { @suite }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:pod_id) }
  it { should respond_to(:pod) }
  its(:pod) { should == pod }

  it { should be_valid }

  describe "when name is not present" do
    before { @suite.name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @suite.description = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @suite.name = "a" * 51 }
    it { should_not be_valid }
  end

=begin
PENDING
Add a test to not let the suite name start with
a special character or a number. It should only start
with a string/char
=end

  describe "when suite name is already taken" do 
    before do
      suite_with_same_name = @suite.dup
      suite_with_same_name.name = @suite.name.downcase
      suite_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when pod_id is not present" do
    before { @suite.pod_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to pod_id" do
      expect do
        Suite.new(pod_id: pod.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  DatabaseCleaner.clean
end
