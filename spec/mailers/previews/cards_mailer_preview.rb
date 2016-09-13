# Preview all emails at http://localhost:3000/rails/mailers/cards_mailer
class CardsMailerPreview < ActionMailer::Preview
  def pending_cards_notification
    user = User.first
    CardsMailer.pending_cards_notification(user.email)
  end
end
