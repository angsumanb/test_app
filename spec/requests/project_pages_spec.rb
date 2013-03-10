require 'spec_helper'

describe "Project pages" do

  subject { page }

  describe "project creation page" do
    before { visit new_project_path }

    it { should have_selector('h1',    text: 'Create new project') }
    it { should have_selector('title', text: full_title('Create new project')) }
  end
end
