require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

RSpec.describe 'roles', type: :feature do
  describe 'admin role' do
    let!(:user) { create(:user) }
    before(:each) do
      user.add_role :admin
      visit root_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'can show all users' do
      expect(page).to have_content I18n.t('shared.admin_header.all_users')
    end

    it 'have link to admin dashboard' do
      expect(page).to have_content I18n.t('shared.admin_header.dashboard')
    end

    it 'can to go to admin dashboard' do
      visit rails_admin_path
      expect(current_path).not_to eq rails_admin.dashboard_path
    end
  end

  describe 'user role' do
    let!(:user) { create(:user) }
    before(:each) do
      visit root_path
      login('test@test.com', '12345', I18n.t('shared.header.log_in'))
    end

    it 'can\'t show all users' do
      expect(page).not_to have_content I18n.t('shared.admin_header.all_users')
    end

    it 'haven\'t link to admin dashboard' do
      expect(page).not_to have_content I18n.t('shared.admin_header.dashboard')
    end

    it 'can\'t to go to admin dashboard' do
      visit rails_admin_path
      expect(current_path).not_to eq rails_admin.dashboard_path
    end

    context 'type \admin' do
      it 'get message "permission denied"' do
        visit rails_admin_path
        expect(page).to have_content I18n.t('defaults.not_authorized')
      end
    end
  end
end
