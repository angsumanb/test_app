require 'spec_helper'
#require 'ruby-debug'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

describe "Testrun pages" do

  subject { page }

  
      before(:all) { 31.times { FactoryGirl.create(:testrun) } }
      
      after(:all)  { Testrun.delete_all }


  describe "index" do
   let(:user) { FactoryGirl.create(:user) }
   #let(:admin) { FactoryGirl.create(:admin) }
   let(:testrun) { FactoryGirl.create(:testrun) }

    before(:each) do
      #sign_in admin 
      sign_in user
      visit testruns_path
    end

    it { should have_selector('title', text: 'All testruns') }
    it { should have_selector('h1',    text: 'All testruns') }
    it { should have_link('Create new Testrun', href: new_testrun_path) }

    describe "pagination" do

      #before(:all) { 31.times { FactoryGirl.create(:testrun) } }
      #after(:all)  { Testrun.delete_all }

      it { should have_selector('div.pagination') }
      
      it "should list each testrun" do
        Testrun.paginate(page: 1).each do |testrun|
          page.should have_selector('li', text: testrun.name)
        end
      end
    end

    describe "delete links" do
       
      
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit testruns_path
        end
        
        it { should have_link('delete', href: testrun_path(Testrun.first)) }
        it "should be able to delete a testrun" do
          expect { click_link('delete') }.to change(Testrun, :count).by(-1)
        end
      end
    end
  end

  describe "testrun creation page" do
    let(:user) { FactoryGirl.create(:user) }
     # let(:testrun) { FactoryGirl.create(:testrun) }
    before do
      sign_in user
      visit new_testrun_path
    end


    it { should have_selector('h1',    text: 'Create new testrun') }
    it { should have_selector('title', text: full_title('Create new testrun')) }
  end

  describe "testrun profile page" do

   let(:user) { FactoryGirl.create(:user) }
    let(:testrun) { FactoryGirl.create(:testrun) }
#    let!(:pod1) { FactoryGirl.create(:pod, testrun: testrun, name: "Foo1", description: "pod description") }
#    let!(:pod2) { FactoryGirl.create(:pod, testrun: testrun, name: "Foo2", description: "pod description") }

    before do 
      sign_in user
      visit testrun_path(testrun) 
    end


    it { should have_selector('h1',    text: testrun.name) }
    it { should have_selector('title', text: testrun.name) }
    it { should have_link('Add testcases') }

=begin
    describe "pods" do
      it { should have_content(pod1.name) }
      it { should have_content(pod2.name) }
      it { should have_content(testrun.pods.count) }
    end

    describe "should have create pod link" do
     # it { should have_link('Create new Pod') }
      it { should have_link('Create new Pod', href: new_pod_path(testrun_id: testrun.id)) }
    end
=end
end

  describe "create new testrun" do

    let(:user) { FactoryGirl.create(:user) }
      let(:testrun) { FactoryGirl.create(:testrun) }
    before do
      sign_in user
      visit new_testrun_path
    end

    let(:submit) { "Create new testrun" }

    describe "with invalid information" do
      it "should not create a testrun" do
        expect { click_button submit }.not_to change(Testrun, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example testrun"
        fill_in "Description",        with: "Example testrun description"
      end

      it "should create a testrun" do
        expect { click_button submit }.to change(Testrun, :count).by(1)
      end
    end
  end

  describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      let(:testrun) { FactoryGirl.create(:testrun) }
    before do
      sign_in user
      visit edit_testrun_path(testrun)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update testrun details") }
      it { should have_selector('title', text: "Edit testrun") }
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
      specify { testrun.reload.name.should  == new_name.upcase }
      specify { testrun.reload.description.should == new_description }
    end
  end
  DatabaseCleaner.clean
end
