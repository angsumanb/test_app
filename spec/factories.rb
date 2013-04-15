=begin FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
=end

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :project do
    sequence(:name)  { |n| "Project #{n}" }
    sequence(:description) { |n| "project_#{n}_description"}
  end
 
  factory :pod do
    sequence(:name) { |n| "Pod #{n}" }
    sequence(:description) { |n| "pod_#{n}_description"}
    project
  end

  factory :suite do
    sequence(:name) { |n| "Suite #{n}" }
    sequence(:description) { |n| "Suite_#{n}_description"}
    pod
  end

  factory :testcase do
    sequence(:title) { |n| "Testcase #{n}" }
    sequence(:testtype) { |n| "Regression" }
    sequence(:priority) { |n| "High" }
    sequence(:steps) { |n| "testcase_#{n}_steps"}
    suite 
  end

  factory :testrun do
    sequence(:name)  { |n| "Testrun #{n}" }
    sequence(:description) { |n| "Testrun_#{n}_description"}
  end
end
