require 'spec_helper'

describe Pod do
  
  let(:project) { FactoryGirl.create(:project) }
  before { @pod = project.pods.build(name: "Lorem ipsum", description: "pod description") }

  subject { @pod }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:project_id) }
  it { should respond_to(:project) }
  its(:project) { should == project }

  it { should be_valid }

  describe "when name is not present" do
    before { @pod.name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @pod.description = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @pod.name = "a" * 51 }
    it { should_not be_valid }
  end

=begin
PENDING
Add a test to not let the pod name start with
a special character or a number. It should only start
with a string/char
=end

  describe "when pod name is already taken" do 
    before do
      pod_with_same_name = @pod.dup
      pod_with_same_name.name = @pod.name.downcase
      pod_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when project_id is not present" do
    before { @pod.project_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to project_id" do
      expect do
        Pod.new(project_id: project.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
