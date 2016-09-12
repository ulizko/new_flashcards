class CardsMailer < ApplicationMailer
  def pending_cards_notification(email)
    mail(to: email, subject: 'Наступила дата пересмотра карточек.')
  end
end
