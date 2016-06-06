require 'random_data'

5.times do
    User.create!(
      pw = RandomData.random_sentence,
      email:    RandomData.random_email,
      password: pw,
      password_confirmation: pw
    )
end

15.times do
  Wiki.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"