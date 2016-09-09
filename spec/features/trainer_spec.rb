require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

RSpec.describe 'review cards without blocks', type: :feature do
  describe 'training without cards' do
    before(:each) do
      create(:user)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'no cards' do
      expect(page).to have_content I18n.t('dashboard.trainer.review_form.no_review_card')
    end
  end
end

describe 'review cards with one block' do
  describe 'training without cards' do
    before(:each) do
      create(:user_with_one_block_without_cards)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'no cards' do
      expect(page).to have_content I18n.t('dashboard.trainer.review_form.no_review_card')
    end
  end

  describe 'training with two cards' do
    before(:each) do
      user = create(:user_with_one_block_and_two_cards)
      user.cards.each do |card|
        card.update_attribute(:review_date, Time.now - 3.days)
      end
      visit trainer_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'first visit' do
      expect(page).to have_content 'Оригинал'
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content I18n.t(:correct_translation_notice)
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content 'Вы ввели перевод c опечаткой.'
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end
  end

  describe 'training with one card' do
    before(:each) do
      user = create(:user_with_one_block_and_one_card)
      user.cards.each do |card|
        card.update_attribute(:review_date, Time.now - 3.days)
      end
      visit trainer_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content I18n.t('dashboard.trainer.review_form.no_review_card')
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content 'Вы ввели перевод c опечаткой.'
    end

    it 'correct translation quality=3' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      fill_in 'user_translation', with: 'House'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content 'Текущая карточка'
    end

    it 'correct translation quality=4' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      fill_in 'user_translation', with: 'House'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      fill_in 'user_translation', with: 'House'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content I18n.t('dashboard.trainer.review_form.no_review_card')
    end
  end
end

describe 'review cards with two blocks' do
  describe 'training without cards' do
    before(:each) do
      create(:user_with_two_blocks_without_cards)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'no cards' do
      expect(page).to have_content I18n.t('dashboard.trainer.review_form.no_review_card')
    end
  end

  describe 'training with two cards' do
    before(:each) do
      user = create(:user_with_two_blocks_and_one_card_in_each)
      user.cards.each do |card|
        card.update_attribute(:review_date, Time.now - 3.days)
      end
      visit trainer_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'first visit' do
      expect(page).to have_content 'Оригинал'
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content I18n.t(:correct_translation_notice)
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content 'Вы ввели перевод c опечаткой.'
    end
  end

  describe 'training with one card' do
    before(:each) do
      user = create(:user_with_two_blocks_and_only_one_card)
      user.cards.each do |card|
        card.update_attribute(:review_date, Time.now - 3.days)
      end
      visit trainer_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content I18n.t('dashboard.trainer.review_form.no_review_card')
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content 'Вы ввели перевод c опечаткой.'
    end
  end
end

describe 'review cards with current_block' do
  describe 'training without cards' do
    before(:each) do
      create(:user_with_two_blocks_without_cards, current_block_id: 1)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'no cards' do
      expect(page).to have_content I18n.t('dashboard.trainer.review_form.no_review_card')
    end
  end

  describe 'training with two cards' do
    before do
      user = create(:user_with_two_blocks_and_two_cards_in_each)
      block = user.blocks.last
      user.set_current_block(block)
      card = user.cards.find_by(block_id: block.id)
      card.update_attribute(:review_date, Time.now - 3.days)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'first visit' do
      expect(page).to have_content 'Оригинал'
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content I18n.t(:correct_translation_notice)
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content 'Вы ввели перевод c опечаткой.'
    end
  end

  describe 'training with one card' do
    before(:each) do
      user = create(:user_with_two_blocks_and_one_card_in_each)
      block = user.blocks.last
      user.set_current_block(block)
      card = user.cards.find_by(block_id: block.id)
      card.update_attribute(:review_date, Time.now - 3.days)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content I18n.t('dashboard.trainer.review_form.no_review_card')
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).
        to have_content I18n.t(:incorrect_translation_alert)
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('dashboard.trainer.review_form.check_card')
      expect(page).to have_content I18n.t('dashboard.trainer.review_form.no_review_card')
    end
  end
end
