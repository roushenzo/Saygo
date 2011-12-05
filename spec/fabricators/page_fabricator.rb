Fabricator(:page) do
  url {Faker::Internet.domain_word}
  title {Faker::Name.title}
end
