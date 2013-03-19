require 'spec_helper'

describe Project do

  before { @project = Project.new(name: "Example project", description: "Example project description") }

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:pods) }

  it { should be_valid }

  describe "when name is not present" do
    before { @project.name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @project.description = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @project.name = "a" * 51 }
    it { should_not be_valid }
  end

=begin
PENDING
Add a test to not let the project name start with
a special character or a number. It should only start
with a string/char
=end

  describe "when project name is already taken" do 
    before do
      project_with_same_name = @project.dup
      project_with_same_name.name = @project.name.downcase
      project_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "pod associations" do

    before { @project.save }
    let!(:older_pod) do 
      FactoryGirl.create(:pod, project: @project, created_at: 1.day.ago)
    end
    let!(:newer_pod) do
      FactoryGirl.create(:pod, project: @project, created_at: 1.hour.ago)
    end

    it "should have the right pods in the right order" do
      @project.pods.should == [newer_pod, older_pod]
    end

     it "should destroy associated pods" do
      pods = @project.pods.dup
      @project.destroy
      pods.should_not be_empty
      pods.each do |pod|
        Pod.find_by_id(pod.id).should be_nil
      end
    end
  end
end
