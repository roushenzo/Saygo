Fabricator(:page) do
  country {Faker::Name.first_name}
  city {Faker::Name.last_name}
  url {Faker::Internet.domain_word}
  title {Faker::Name.title}
end
