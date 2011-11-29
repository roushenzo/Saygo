Fabricator(:country) do
  name {Faker::Name.name}
  flag File.new(File.join(Rails.root, 'spec/fabricators/avatar.jpg'))
end
