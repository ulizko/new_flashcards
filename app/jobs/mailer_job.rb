class MailerJob < ApplicationJob
  queue_as :mailer

  def perform(email)
    CardsMailer.pending_cards_notification(email)
  end
end
