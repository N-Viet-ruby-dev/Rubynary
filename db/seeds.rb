80.times do |n|
  Word.create!(
    ja: Faker::Name.name,
    en: Faker::Name.name,
    vi: Faker::Name.name,
    description: Faker::Lorem.sentences(5))
end

6.times do |n|
  name  = Faker::App.name
  color_code = Faker::Color.hex_color
  Project.create!(name:  name,
               color_code: color_code,
               created_at: rand(2.years).seconds.ago)
end

50.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: "ex-#{n+1}@gmail.com",
    password: "123456",
    role: rand(0..2)
    )
end

50.times do |n|
  ProjectWord.create!(
    project: Project.all.sample,
    word: Word.all.sample
  )
end
