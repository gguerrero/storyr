namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke

    User.create!(name: "admin",
                 email: "yeses2000@hotmail.com",
                 fullname: "name",
                 password: "Admin1234",
                 password_confirmation: "Admin1234",
                 admin: true)

    104.times do |n|
      name = Faker::Name.name
      user = User.create!(name: Faker::Internet.user_name(name)[0..14],
                          email: "example-#{n+1}@railstutorial.org",
                          fullname: name,
                          password: "User1234",
                          password_confirmation: "User1234")

      rand(5).times do |n|
        Story.create!(title: Faker::Lorem.words(3).join(" "),
                      description: Faker::Lorem.sentence(4),
                      tags: ["fake","misc","comic","impact"],
                      published_on: (Date.today-rand(100)),
                      user: user)
      end
    end

    # Already created stories and users, now rate them
    Story.find_each do |story|
      rand(20).times do |n|
          Rate.create!(value: rand(10)+1,
                       comment: Faker::Lorem.paragraphs(rand(3)+1).join("\n"),
                       story: story,
                       user: User.find_by_id(rand(105)+1),
                       rated_on: (story.published_on+rand(10)))
      end
    end

  end
end