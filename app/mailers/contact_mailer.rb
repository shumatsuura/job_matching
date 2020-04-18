class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
    mail to: @contact.email, subject: @contact.title
  end

  # def self.test_mail
  #   from = Email.new(email: 'test@forjober.com')
  #   to = Email.new(email: 'shunsuke.mtr@gmail.com')
  #   subject = 'Sending with SendGrid is Fun'
  #   content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
  #   mail = Mail.new(from, subject, to, content)
  #
  #   sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  #   response = sg.client.mail._('send').post(request_body: mail.to_json)
  #   puts response.status_code
  #   puts response.body
  #   puts response.headers
  # end
end
