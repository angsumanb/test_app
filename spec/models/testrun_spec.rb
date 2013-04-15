require 'spec_helper'

describe Testrun do

  before { @testrun = Testrun.new(name: "Example testrun", description: "Example testrun description") }

  subject { @testrun }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:testcases) }
  it { should respond_to(:testresults) }

  it { should be_valid }

  describe "when name is not present" do
    before { @testrun.name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @testrun.description = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @testrun.name = "a" * 51 }
    it { should_not be_valid }
  end

=begin
PENDING
Add a test to not let the testrun name start with
a special character or a number. It should only start
with a string/char
=end

  describe "when testrun name is already taken" do 
    before do
      testrun_with_same_name = @testrun.dup
      testrun_with_same_name.name = @testrun.name.downcase
      testrun_with_same_name.save
    end

    it { should_not be_valid }
  end

end
