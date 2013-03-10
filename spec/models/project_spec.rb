require 'spec_helper'

describe Project do

  before { @project = Project.new(name: "Example project", description: "Example project description") }

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:description) }

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
end
