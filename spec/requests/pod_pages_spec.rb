require 'spec_helper'
#require 'ruby-debug'

describe "Pod pages" do

  subject { page }


  describe "index" do
   let(:user) { FactoryGirl.create(:user) }
   let(:project) { FactoryGirl.create(:project) }
   let(:pod) { FactoryGirl.create(:pod) }

    before(:each) do
      sign_in user
      visit pods_path
    end

    it { should have_selector('title', text: 'All pods') }
    it { should have_selector('h1',    text: 'All pods') }

    describe "pagination" do

      before(:all) { 31.times { FactoryGirl.create(:pod) } }
      after(:all)  { Pod.delete_all }

      it { should have_selector('div.pagination') }
      
      it "should list each pod" do
        Pod.paginate(page: 1).each do |pod|
          page.should have_selector('li', text: pod.name)
        end
      end
    end

    describe "delete links" do
      
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit pods_path
        end
        
        it { should have_link('delete', href: pod_path(Pod.first)) }
        it "should be able to delete a pod" do
          expect { click_link('delete') }.to change(Pod, :count).by(-1)
        end
      end
    end
  end

  describe "pod creation page" do
    let(:user) { FactoryGirl.create(:user) }
      let(:pod) { FactoryGirl.create(:pod) }
      let(:project) { FactoryGirl.create(:project) }

    before do
      sign_in user
      visit new_pod_path(@project.id)
    end


    it { should have_selector('h1',    text: 'Create new pod') }
    it { should have_selector('title', text: full_title('Create new pod')) }
  end

  describe "pod profile page" do
    let(:pod) { FactoryGirl.create(:pod) }
    before { visit pod_path(pod) }

    it { should have_selector('h1',    text: pod.name) }
    it { should have_selector('title', text: pod.name) }
  end

  describe "create new pod" do

    let(:user) { FactoryGirl.create(:user) }
    let(:pod) { FactoryGirl.create(:pod) }
    let(:project) { FactoryGirl.create(:project) }
    
    before do
      sign_in user
     # visit new_pod_path(@project.id)
    end

    let(:submit) { "Create new pod" }

    describe "with invalid information" do
      it "should not create a pod" do
        expect { click_button submit }.not_to change(Pod, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example pod"
        fill_in "Description",        with: "Example pod description"
      end

      it "should create a pod" do
        expect { click_button submit }.to change(Pod, :count).by(1)
      end
    end
  end

  describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      let(:pod) { FactoryGirl.create(:pod) }
    before do
      sign_in user
      visit edit_pod_path(pod)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update pod details") }
      it { should have_selector('title', text: "Edit pod") }
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
      specify { pod.reload.name.should  == new_name.upcase }
      specify { pod.reload.description.should == new_description }
    end
  end

end
