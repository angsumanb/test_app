require 'spec_helper'
#require 'ruby-debug'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation


describe "Suite pages" do

  subject { page }


 
  describe "index" do


   let(:user) { FactoryGirl.create(:user) }
   let(:pod) { FactoryGirl.create(:pod) }
   let(:suite) { FactoryGirl.create(:suite, pod: pod) }

    before(:each) do
      sign_in user
      visit suites_path
    end

    it { should have_selector('title', text: 'All suites') }
    it { should have_selector('h1',    text: 'All suites') }

    describe "pagination" do

      before(:all) { 15.times { FactoryGirl.create(:suite, pod: pod) } }
#no need now. using database_cleaner
#      after(:all)  { Suite.delete_all }

      it { should have_selector('div.pagination') }
      
      it "should list each suite" do
        Suite.paginate(page: 1).each do |suite|
          page.should have_selector('li', text: suite.name)
        end
      end
    end

    describe "delete links" do
      
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        let(:pod) { FactoryGirl.create(:pod) }
        let(:suite) { FactoryGirl.create(:suite, pod: pod) }
        before do
          sign_in admin
          visit suites_path
        end
        
        it { should have_link('delete', href: suite_path(Suite.first)) }
        it "should be able to delete a suite" do
          expect { click_link('delete') }.to change(Suite, :count).by(-1)
        end
      end
    end
  end


  describe "suite creation page" do
    let(:user) { FactoryGirl.create(:user) }
      let(:pod) { FactoryGirl.create(:pod) }
     
      describe "without passing pod ID" do
        before do
          sign_in user
          visit new_suite_path
        end
        it { should have_selector('h1', text: 'All pods')}
      end

      describe "with passing pod ID" do
        before do
          sign_in user
          visit new_suite_path(pod_id: pod.id)
        end

        it { should have_selector('h1',    text: 'Create new suite') }
        it { should have_selector('title', text: full_title('Create new suite')) }

   DatabaseCleaner.clean
    end
   end
  
describe "suite profile page" do
    let(:user) { FactoryGirl.create(:user) }

    let(:pod) { FactoryGirl.create(:pod) }
    let(:suite) { FactoryGirl.create(:suite, pod: pod) }

    let!(:testcase1) { FactoryGirl.create(:testcase, suite: suite, title: "testcase1", steps: "testcase steps", priority: "p1", testtype: "automated") }
    let!(:testcase2) { FactoryGirl.create(:testcase, suite: suite, title: "testcase2", steps: "testcase steps", priority: "p2", testtype: "regression") }

   # let(:suite) { FactoryGirl.create(:suite) }
    before do
      sign_in user
      visit suite_path(suite)
    end 

    it { should have_selector('h4',    text: pod.name) }
    it { should have_link('back to pod', href: pod_path(pod)) }
    it { should have_selector('h1',    text: suite.name) }
    it { should have_selector('title', text: suite.name) }

    describe "testcases" do
      it { should have_content(testcase1.title) }
      it { should have_content(testcase2.title) }
      it { should have_content(suite.testcases.count) }
    end
  end
  

describe "create new suite" do

    let(:user) { FactoryGirl.create(:user) }
    let(:pod) { FactoryGirl.create(:pod) }
    
    before do
      sign_in user
      visit new_suite_path(pod_id: pod.id)
    end

    let(:submit) { "Create new suite" }

    describe "with invalid information" do
      it "should not create a suite" do
        expect { click_button submit }.not_to change(Suite, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example suite"
        fill_in "Description",        with: "Example suite description"
      end

      it "should create a suite" do
        expect { click_button submit }.to change(Suite, :count).by(1)
      end
    end
  end

  describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      let(:pod) { FactoryGirl.create(:pod) }
      let(:suite) { FactoryGirl.create(:suite, pod: pod) }

    before do
      sign_in user
      visit edit_suite_path(suite)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update suite details") }
      it { should have_selector('title', text: "Edit suite") }
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
      specify { suite.reload.name.should  == new_name.upcase }
      specify { suite.reload.description.should == new_description }
    end
  end

end
