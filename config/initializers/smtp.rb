# ActionMailer::Base.add_delivery_method :ses,
#                                        AWS::SES::Base,
#                                        access_key_id: ENV['AWS_SES_ACCESS_KEY'],
#                                        secret_access_key: ENV['AWS_SES_SECRET_ACCESS_KEY'],
#                                        server: 'email.us-west-2.amazonaws.com'
ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  domain: 'forjober.com',
  user_name: ENV['SENDGRID_USERNAME'],
  password: ENV['SENDGRID_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true
}
