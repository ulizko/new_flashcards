require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

RSpec.describe 'password authentication', type: :feature do
  describe 'register' do
    before do
      visit root_path
    end

    it 'register TRUE' do
      register('test@test.com', '12345', '12345', I18n.t('shared.header.sign_up'))
      expect(page).to have_content I18n.t(:user_created_successfully_notice)
    end

    it 'password confirmation FALSE' do
      register('test@test.com', '12345', '56789', I18n.t('shared.header.sign_up'))
      expect(page).to have_content I18n.t('activerecord.errors.messages.confirmation')
    end

    it 'e-mail FALSE' do
      register('test', '12345', '12345', I18n.t('shared.header.sign_up'))
      expect(page).to have_content I18n.t('activerecord.errors.messages.invalid')
    end

    it 'e-mail has already been taken' do
      register('test@test.com', '12345', '12345', I18n.t('shared.header.sign_up'))
      click_link I18n.t('shared.user_header.log_out')
      register('test@test.com', '12345', '12345', I18n.t('shared.header.sign_up'))
      expect(page).to have_content I18n.t('activerecord.errors.messages.taken')
    end

    it 'password is too short' do
      register('test@test.com', '1', '12345', I18n.t('shared.header.sign_up'))
      expect(page).to have_content I18n.t('activerecord.errors.messages.too_short')
    end
  end

  describe 'authentication' do
    before do
      create(:user)
      visit root_path
    end

    it 'require_login root' do
      expect(page).to have_content I18n.t('main.index.welcome')
    end

    it 'authentication TRUE' do
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
      expect(page).to have_content I18n.t(:log_in_is_successful_notice)
    end

    it 'incorrect e-mail' do
      login('1@1.com', '12345', I18n.t('shared.header.log_in'))
      expect(page).to have_content I18n.t(:not_logged_in_alert)
    end

    it 'incorrect password' do
      login('test@test.com', '56789', I18n.t('shared.header.log_in'))
      expect(page).to have_content I18n.t(:not_logged_in_alert)
    end

    it 'incorrect e-mail and password' do
      login('1@1.com', '56789', I18n.t('shared.header.log_in'))
      expect(page).to have_content I18n.t(:not_logged_in_alert)
    end
  end

  describe 'change language' do
    before do
      visit root_path
    end

    it 'home page' do
      click_link 'en'
      expect(page).to have_content 'Welcome.'
    end

    it 'register TRUE' do
      click_link 'en'
      register('test@test.com', '12345', '12345', 'Sign up')
      expect(page).to have_content 'User created successfully.'
    end

    it 'default locale' do
      click_link 'ru'
      register('test@test.com', '12345', '12345', I18n.t('shared.header.sign_up'))
      user = User.find_by_email('test@test.com')
      expect(user.locale).to eq('ru')
    end

    it 'available locale' do
      click_link 'en'
      register('test@test.com', '12345', '12345', 'Sign up')
      click_link 'Profile'
      fill_in 'user[password]', with: '12345'
      fill_in 'user[password_confirmation]', with: '12345'
      click_button 'Save'
      expect(page).to have_content 'Профиль пользователя успешно обновлен.'
    end

    it 'authentication TRUE' do
      create(:user)
      click_link 'en'
      login('test@test.com', '12345', 'Log in')
      expect(page).to have_content 'Login is successful.'
    end
  end
end
