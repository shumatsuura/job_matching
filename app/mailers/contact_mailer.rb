class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact

    mail to: "sample@sample.com", subject: @contact.title
  end
end
