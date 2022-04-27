# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |n|
    User.create!(name: "user#{n}", email: "user#{n}@test.com", password: "111111")
    Post.create!(user_id: User.last.id, title: "post#{n}", description: "content#{n}",
          image: File.open("./app/assets/images/choice-8.jpg"),
          status: "public")
    Label.create!(genre: "生活#{n}")
    Labelling.create!(post_id: Post.last.id, label_id: Label.last.id)
end
Label.create!([ { genre: 'お金' }, { genre: '仕事' }, { genre: '文化' }, { genre: '教育' }, { genre: 'スポーツ' },
    { genre: 'ゲーム' }, { genre: '法律' }, { genre: '政治' }, { genre: '経済' }, { genre: '科学技術' }])

