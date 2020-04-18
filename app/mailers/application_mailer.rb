class ApplicationMailer < ActionMailer::Base
  # require 'sendgrid-ruby'
  # include SendGrid

  default from: 'noreply@forjober.com'
  layout 'mailer'
end
