Fabricator(:city) do
  name {Faker::Name.name}
  country!
end
