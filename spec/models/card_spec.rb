require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:user) { create(:user) }

  it 'create card with empty original text' do
    card = Card.create(original_text: '', translated_text: 'house', user: user,
                       block_id: 1)
    expect(card.errors[:original_text]).to include('Необходимо заполнить поле.')
  end

  it 'create card with empty translated text' do
    card = Card.create(original_text: 'дом', translated_text: '', user: user,
                       block_id: 1)
    expect(card.errors[:translated_text]).
      to include('Необходимо заполнить поле.')
  end

  it 'create card with empty texts' do
    card = Card.create(original_text: '', translated_text: '', user: user,
                       block_id: 1)
    expect(card.errors[:original_text]).
      to include('Вводимые значения должны отличаться.')
  end

  it 'equal_texts Eng' do
    card = Card.create(original_text: 'house', translated_text: 'house',
                       user: user, block_id: 1)
    expect(card.errors[:original_text]).
      to include('Вводимые значения должны отличаться.')
  end

  it 'equal_texts Rus' do
    card = Card.create(original_text: 'дом', translated_text: 'дом', user: user,
                       block_id: 1)
    expect(card.errors[:original_text]).
      to include('Вводимые значения должны отличаться.')
  end

  it 'full_downcase Eng' do
    card = Card.create(original_text: 'hOuse', translated_text: 'houSe',
                       user: user, block_id: 1)
    expect(card.errors[:original_text]).
      to include('Вводимые значения должны отличаться.')
  end

  it 'full_downcase Rus' do
    card = Card.create(original_text: 'Дом', translated_text: 'доМ', user: user,
                       block_id: 1)
    expect(card.errors[:original_text]).
      to include('Вводимые значения должны отличаться.')
  end

  it 'create card original_text OK' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user: user, block_id: 1)
    expect(card.original_text).to eq('дом')
  end

  it 'create card translated_text OK' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user: user, block_id: 1)
    expect(card.translated_text).to eq('house')
  end

  it 'create card errors OK' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user: user, block_id: 1)
    expect(card.errors.any?).to be false
  end

  it 'set_review_date OK' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user: user, block_id: 1)
    expect(card.review_date.strftime('%Y-%m-%d %H:%M')).
      to eq(Time.zone.now.strftime('%Y-%m-%d %H:%M'))
  end

  it 'check_translation Eng OK' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user: user, block_id: 1)
    check_result = card.check_translation('house')
    expect(check_result[:state]).to be true
  end

  it 'check_translation Eng NOT' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user: user, block_id: 1)
    check_result = card.check_translation('RoR')
    expect(check_result[:state]).to be false
  end

  it 'check_translation Rus OK' do
    card = Card.create(original_text: 'house', translated_text: 'дом',
                       user: user, block_id: 1)
    check_result = card.check_translation('дом')
    expect(check_result[:state]).to be true
  end

  it 'check_translation Rus NOT' do
    card = Card.create(original_text: 'house', translated_text: 'дом',
                       user: user, block_id: 1)
    check_result = card.check_translation('RoR')
    expect(check_result[:state]).to be false
  end

  it 'check_translation full_downcase Eng OK' do
    card = Card.create(original_text: 'ДоМ', translated_text: 'hOuSe',
                       user: user, block_id: 1)
    check_result = card.check_translation('HousE')
    expect(check_result[:state]).to be true
  end

  it 'check_translation full_downcase Eng NOT' do
    card = Card.create(original_text: 'ДоМ', translated_text: 'hOuSe',
                       user: user, block_id: 1)
    check_result = card.check_translation('RoR')
    expect(check_result[:state]).to be false
  end

  it 'check_translation full_downcase Rus OK' do
    card = Card.create(original_text: 'hOuSe', translated_text: 'ДоМ',
                       user: user, block_id: 1)
    check_result = card.check_translation('дОм')
    expect(check_result[:state]).to be true
  end

  it 'check_translation full_downcase Rus NOT' do
    card = Card.create(original_text: 'hOuSe', translated_text: 'ДоМ',
                       user: user, block_id: 1)
    check_result = card.check_translation('RoR')
    expect(check_result[:state]).to be false
  end

  it 'create card witout block_id' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user: user)
    expect(card.block.title).to eq('Default')
  end

  it 'check_translation Eng OK levenshtein_distance' do
    card = Card.create(original_text: 'дом', translated_text: 'hous',
                       user: user, block_id: 1)
    check_result = card.check_translation('house')
    expect(check_result[:state]).to be true
  end

  it 'check_translation Eng OK levenshtein_distance=1' do
    card = Card.create(original_text: 'дом', translated_text: 'hous',
                       user: user, block_id: 1)
    check_result = card.check_translation('house')
    expect(check_result[:distance]).to be 1
  end

  it 'check_translation Rus OK levenshtein_distance' do
    card = Card.create(original_text: 'house', translated_text: 'до',
                       user: user, block_id: 1)
    check_result = card.check_translation('дом')
    expect(check_result[:state]).to be true
  end

  it 'check_translation Rus OK levenshtein_distance=1' do
    card = Card.create(original_text: 'house', translated_text: 'до',
                       user: user, block_id: 1)
    check_result = card.check_translation('дом')
    expect(check_result[:distance]).to be 1
  end

  it 'check_translation Eng NOT levenshtein_distance=2' do
    card = Card.create(original_text: 'дом', translated_text: 'hou',
                       user: user, block_id: 1)
    check_result = card.check_translation('RoR')
    expect(check_result[:state]).to be false
  end

  it 'check_translation Rus NOT levenshtein_distance=2' do
    card = Card.create(original_text: 'house', translated_text: 'д',
                       user: user, block_id: 1)
    check_result = card.check_translation('RoR')
    expect(check_result[:state]).to be false
  end
end
