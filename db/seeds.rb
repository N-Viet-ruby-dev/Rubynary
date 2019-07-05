50.times do |n|
  Word.create!(
    ja: Faker::Name.name,
    en: Faker::Name.name,
    vi: Faker::Name.name,
    description: Faker::Lorem.sentences(5))
end
