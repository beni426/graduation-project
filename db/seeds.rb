# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Label.create([{ genre: 'life' }, { genre: 'money' }, { genre: 'work' }, { genre: 'culture' }, { genre: 'education' }, { genre: 'sports' },
              { genre: 'game' }, { genre: 'law' }, { genre: 'politic' }, { genre: 'economy' }, { genre: 'technology' }])
Labelling.create!(post_id: Post.last.id, label_id: Label.last.id)
