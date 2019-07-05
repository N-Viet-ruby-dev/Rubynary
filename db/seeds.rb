50.times do |n|
  Word.create!(
    ja: Faker::Name.name,
    en: Faker::Name.name,
    vi: Faker::Name.name,
    description: Faker::Lorem.sentences(5))

99.times do |n|
  name  = Faker::App.name
  color_code = Faker::Color.hex_color
  Project.create!(name:  name,
               color_code: color_code,
               created_at: rand(2.years).seconds.ago)
end
