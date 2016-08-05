# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_1 = User.create(email: 'example@email.com', password: '12345', password_confirmation: '12345')
user_2 = User.create(email: 'test@test.com', password: '12345', password_confirmation: '12345')

deck_1 = Deck.create(name: 'Animals', user: user_1)
deck_2 = Deck.create(name: 'Fruits', user: user_1)
deck_3 = Deck.create(name: 'Professions', user: user_2, current: true)
deck_4 = Deck.create(name: 'Birds', user: user_2)


Card.create(original_text: 'hare', translated_text: 'заяц', deck: deck_1, user: user_1)
Card.create(original_text: 'wolf', translated_text: 'волк', deck: deck_1, user: user_1)
Card.create(original_text: 'fox', translated_text: 'лиса', deck: deck_1, user: user_1)
Card.create(original_text: 'tiger', translated_text: 'тигр', deck: deck_1, user: user_1)

Card.create(original_text: 'pear', translated_text: 'груша', deck: deck_2, user: user_1)
Card.create(original_text: 'orange', translated_text: 'апельсин', deck: deck_2, user: user_1)
Card.create(original_text: 'banana', translated_text: 'банан', deck: deck_2, user: user_1)

Card.create(original_text: 'accountant', translated_text: 'бухгалтер', deck: deck_3, user: user_2)
Card.create(original_text: 'driver', translated_text: 'водитель', deck: deck_3, user: user_2)
Card.create(original_text: 'plumber', translated_text: 'водопроводчик', deck: deck_3, user: user_2)

Card.create(original_text: 'woodpecker', translated_text: 'дятел', deck: deck_4, user: user_2)
Card.create(original_text: 'crow', translated_text: 'ворона', deck: deck_4, user: user_2)
Card.create(original_text: 'stork', translated_text: 'аист', deck: deck_4, user: user_2)
Card.create(original_text: 'swallow', translated_text: 'ласточка', deck: deck_4, user: user_2)

cards = Card.all.sample(7)
cards.each do |card|
  card.review_date = 4.days.ago
  card.save
end