user_1 = User.create(email: 'admin@email.com', password: '12345', password_confirmation: '12345')
user_1.add_role :admin
user_2 = User.create(email: 'user1@email.com', password: '12345', password_confirmation: '12345')
user_3 = User.create(email: 'user2@email.com', password: '12345', password_confirmation: '12345')

block_1 = Block.create(title: 'Animals', user: user_2)
block_2 = Block.create(title: 'Fruits', user: user_2)
block_3 = Block.create(title: 'Professions', user: user_3)
block_4 = Block.create(title: 'Birds', user: user_3)

animals = [ {original_text: 'hare', translated_text: 'заяц'},
            {original_text: 'wolf', translated_text: 'волк'},
            {original_text: 'fox', translated_text: 'лиса'},
            {original_text: 'tiger', translated_text: 'тигр'} ]

fruits = [ {original_text: 'pear', translated_text: 'груша'},
           {original_text: 'orange', translated_text: 'апельсин'},
           {original_text: 'banana', translated_text: 'банан'} ]

professions = [ {original_text: 'accountant', translated_text: 'бухгалтер'},
                {original_text: 'driver', translated_text: 'водитель'},
                {original_text: 'plumber', translated_text: 'водопроводчик'} ]

birds = [ {original_text: 'woodpecker', translated_text: 'дятел'},
          {original_text: 'crow', translated_text: 'ворона'},
          {original_text: 'stork', translated_text: 'аист'},
          {original_text: 'swallow', translated_text: 'ласточка'} ]

animals.each do |data|
  Card.create(data.merge({block: block_1, user: user_3}))
end

fruits.each do |data|
  Card.create(data.merge({block: block_2, user: user_3}))
end

professions.each do |data|
  Card.create(data.merge({block: block_3, user: user_2}))
end

birds.each do |data|
  Card.create(data.merge({block: block_4, user: user_2}))
end

cards = Card.all.sample(7)
cards.each do |card|
  card.review_date = 4.days.ago
  card.save
end
