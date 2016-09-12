require "rails_helper"

RSpec.describe CardsMailer, type: :mailer do
  let(:user) { create :user, email: 'test@test.com' }
  let(:email) { CardsMailer.pending_cards_notification(user.email).deliver_now }

  it 'sends notifications' do
    expect(email.to).to include(user.email)
  end
end
