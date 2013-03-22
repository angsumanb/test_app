require 'spec_helper'
#require 'ruby-debug'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation


describe "Testcase pages" do

  subject { page }


 
  describe "index" do


   let(:user) { FactoryGirl.create(:user) }
   let(:suite) { FactoryGirl.create(:suite) }
   let(:testcase) { FactoryGirl.create(:testcase, suite: suite) }

    before(:each) do
      sign_in user
      visit testcases_path
    end

    it { should have_selector('title', text: 'All testcases') }
    it { should have_selector('h1',    text: 'All testcases') }

    describe "pagination" do

      before(:all) { 15.times { FactoryGirl.create(:testcase, suite: suite) } }
#no need now. using database_cleaner
#      after(:all)  { Testcase.delete_all }

      it { should have_selector('div.pagination') }
      
      it "should list each testcase" do
        Testcase.paginate(page: 1).each do |testcase|
          page.should have_selector('li', text: testcase.title)
        end
      end
    end

    describe "delete links" do
      
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        let(:suite) { FactoryGirl.create(:suite) }
        let(:testcase) { FactoryGirl.create(:testcase, suite: suite) }
        before do
          sign_in admin
          visit testcases_path
        end
        
        it { should have_link('delete', href: testcase_path(Testcase.first)) }
        it "should be able to delete a testcase" do
          expect { click_link('delete') }.to change(Testcase, :count).by(-1)
        end
      end
    end
  end


  describe "testcase creation page" do
    let(:user) { FactoryGirl.create(:user) }
      let(:suite) { FactoryGirl.create(:suite) }
     
      describe "without passing suite ID" do
        before do
          sign_in user
          visit new_testcase_path
        end
        it { should have_selector('h1', text: 'All suites')}
      end

      describe "with passing suite ID" do
        before do
          sign_in user
          visit new_testcase_path(suite_id: suite.id)
        end

        it { should have_selector('h1',    text: 'Create new testcase') }
        it { should have_selector('title', text: full_title('Create new testcase')) }

    end
   end
  
describe "testcase profile page" do
    let(:suite) { FactoryGirl.create(:suite) }
    let(:testcase) { FactoryGirl.create(:testcase, suite: suite) }

   # let(:testcase) { FactoryGirl.create(:testcase) }
    before { visit testcase_path(testcase) }

    it { should have_selector('h1',    text: suite.title) }
    it { should have_link('back to suite', href: suite_path(suite)) }
    it { should have_selector('h1',    text: testcase.title) }
    it { should have_selector('h2',    text: testcase.steps) }
    it { should have_selector('h2',    text: testcase.type) }
    it { should have_selector('h2',    text: testcase.priority) }
   #It should have_text of description, value of type, priority 
   # or may be above test cases are testing this only
    it { should have_selector('title', text: testcase.title) }
  end
  

describe "create new testcase" do

    let(:user) { FactoryGirl.create(:user) }
    let(:suite) { FactoryGirl.create(:suite) }
    
    before do
      sign_in user
      visit new_testcase_path(suite_id: suite.id)
    end

    let(:submit) { "Create new testcase" }

    describe "with invalid information" do
      it "should not create a testcase" do
        expect { click_button submit }.not_to change(Testcase, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Title",         with: "Example testcase"
        fill_in "Steps",        with: "Example testcase steps"
      end

      it "should create a testcase" do
        expect { click_button submit }.to change(Testcase, :count).by(1)
      end
    end
  end

  describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      let(:suite) { FactoryGirl.create(:suite) }
      let(:testcase) { FactoryGirl.create(:testcase, suite: suite) }

    before do
      sign_in user
      visit edit_testcase_path(testcase)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update testcase details") }
      it { should have_selector('title', text: "Edit testcase") }
    end

    describe "with valid information" do
      let(:new_title)  { "New Title" }
      let(:new_steps) { "new steps" }
      before do
        fill_in "Title",             with: new_title
        fill_in "Steps",      with: new_steps
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_title.upcase) }
      it { should have_selector('h1', text: new_title.upcase) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { testcase.reload.title.should  == new_title.upcase }
      specify { testcase.reload.steps.should == new_steps }
    end
  end
   DatabaseCleaner.clean
end
