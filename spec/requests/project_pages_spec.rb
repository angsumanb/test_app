require 'spec_helper'
#require 'ruby-debug'

describe "Project pages" do

  subject { page }

  
      before(:all) { 31.times { FactoryGirl.create(:project) } }
      
      after(:all)  { Project.delete_all }


  describe "index" do
   let(:user) { FactoryGirl.create(:user) }
   #let(:admin) { FactoryGirl.create(:admin) }
   let(:project) { FactoryGirl.create(:project) }

    before(:each) do
      #sign_in admin 
      sign_in user
      visit projects_path
    end

    it { should have_selector('title', text: 'All projects') }
    it { should have_selector('h1',    text: 'All projects') }

    describe "pagination" do

      #before(:all) { 31.times { FactoryGirl.create(:project) } }
      #after(:all)  { Project.delete_all }

      it { should have_selector('div.pagination') }
      
      it "should list each project" do
        Project.paginate(page: 1).each do |project|
          page.should have_selector('li', text: project.name)
        end
      end
    end

    describe "delete links" do
       
      
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit projects_path
        end
        
        it { should have_link('delete', href: project_path(Project.first)) }
        it "should be able to delete a project" do
          expect { click_link('delete') }.to change(Project, :count).by(-1)
        end
      end
    end
  end

  describe "project creation page" do
    let(:user) { FactoryGirl.create(:user) }
     # let(:project) { FactoryGirl.create(:project) }
    before do
      sign_in user
      visit new_project_path
    end


    it { should have_selector('h1',    text: 'Create new project') }
    it { should have_selector('title', text: full_title('Create new project')) }
  end

  describe "project profile page" do

   let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let!(:pod1) { FactoryGirl.create(:pod, project: project, name: "Foo1", description: "pod description") }
    let!(:pod2) { FactoryGirl.create(:pod, project: project, name: "Foo2", description: "pod description") }

    before do 
      sign_in user
      visit project_path(project) 
    end


    it { should have_selector('h1',    text: project.name) }
    it { should have_selector('title', text: project.name) }

    describe "pods" do
      it { should have_content(pod1.name) }
      it { should have_content(pod2.name) }
      it { should have_content(project.pods.count) }
    end

    describe "should have create pod link" do
     # it { should have_link('Create new Pod') }
      it { should have_link('Create new Pod', href: new_pod_path(project_id: project.id)) }
    end
  end

  describe "create new project" do

    let(:user) { FactoryGirl.create(:user) }
      let(:project) { FactoryGirl.create(:project) }
    before do
      sign_in user
      visit new_project_path
    end

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

  describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      let(:project) { FactoryGirl.create(:project) }
    before do
      sign_in user
      visit edit_project_path(project)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update project details") }
      it { should have_selector('title', text: "Edit project") }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_description) { "new description" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Description",      with: new_description
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name.upcase) }
      it { should have_selector('h1', text: new_name.upcase) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { project.reload.name.should  == new_name.upcase }
      specify { project.reload.description.should == new_description }
    end
  end

end
