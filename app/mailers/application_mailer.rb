class ApplicationMailer < ActionMailer::Base
  default from: "notifications@flashcards.com"
  layout 'mailer'
end
