boolean_array = [true, false]

5.times do
  User.create!(
    email:    Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
end
users = User.all

15.times do
  Wiki.create!(
    title: Faker::StarWars.quote,
    body: Faker::Hipster.paragraph,
    user: users.sample,
    private: boolean_array.sample
  )
end


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"