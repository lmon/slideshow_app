namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "tabby99",
                 password_confirmation: " ",
                 admin: true)
    29.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "jimmy99"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    10.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.galleries.create!(title: content) }
    end


  end
end