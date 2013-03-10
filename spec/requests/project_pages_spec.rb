require 'spec_helper'

describe "Project pages" do

  subject { page }

  describe "project creation page" do
    before { visit new_project_path }

    it { should have_selector('h1',    text: 'Create new project') }
    it { should have_selector('title', text: full_title('Create new project')) }
  end

  describe "project profile page" do
    let(:project) { FactoryGirl.create(:project) }
    before { visit project_path(project) }

    it { should have_selector('h1',    text: project.name) }
    it { should have_selector('title', text: project.name) }
  end

  describe "signup" do

    before { visit new_project_path }

    let(:submit) { "Create new project" }

    describe "with invalid information" do
      it "should not create a project" do
        expect { click_button submit }.not_to change(Project, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example project"
        fill_in "Description",        with: "Example project description"
      end

      it "should create a project" do
        expect { click_button submit }.to change(Project, :count).by(1)
      end
    end
  end
end
