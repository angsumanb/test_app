namespace :db do
  desc "Fill database with sample data"
#  @@m = 1
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    39.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  
   39.times do |n|
      name  = Faker::Name.name
      description = "project-#{n+1} description"
      Project.create!(name: name,
                   description: description) 
    end
 
   projects = Project.all(limit: 6)
   39.times do |n|
      name1 = Faker::Name.name
      name = "pod-#{n+1}"
      _m = 1
      description = Faker::Lorem.sentence(5)
	  for project in projects do
	    project.pods.create!(description: description, name: name+"-"+"#{_m}")
	    _m = _m+1
	  end
    end

    pods = Pod.all(limit: 6)
   39.times do |n|
      name = "Suite-#{n+1}"
      _m = 1
      description = Faker::Lorem.sentence(5)
          for pod in pods do
            pod.suites.create!(description: description, name: name+"-"+"#{_m}")
            _m = _m+1
          end
    end

    suites = Suite.all(limit: 6)
   39.times do |n|
      title = "Testcase-#{n+1}"
      _m = 1
      steps = Faker::Lorem.sentence(5)
      testtype = "Regression"
      priority = "Medium"
          for suite in suites do
            suite.testcases.create!(steps: steps, title: title+"-"+"#{_m}", testtype: testtype, priority: priority)
            _m = _m+1
          end
    end
  end
end
