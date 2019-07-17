80.times do |n|
  Word.create!(
    ja: Gimei.kanji,
    en: Faker::Name.name,
    vi: Faker::Name.name,
    description: Faker::Lorem.sentences(2),
    created_by_id: "1",
    last_update_by_id: "1"
    )
end

10.times do |n|
  Project.create!(
    name: Faker::App.name,
    color_code: Faker::Color.hex_color,
    created_at: rand(2.years).seconds.ago
    )
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
