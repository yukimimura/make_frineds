5.times do |n|
  User.create!(
    email: "test#{n + 1}@test",
    name: "test#{n + 1}",
    sex: "male",
    language: "english",
    age: 20,
    intro: "I like Japan. we should be friends. let's get started.",
    password: "testtest",
    password_confirmation: "testtest"
  )
end