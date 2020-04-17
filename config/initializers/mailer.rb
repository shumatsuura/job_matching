# ActionMailer::Base.add_delivery_method :ses,
#                                        AWS::SES::Base,
#                                        access_key_id: ENV['AWS_SES_ACCESS_KEY'],
#                                        secret_access_key: ENV['AWS_SES_SECRET_ACCESS_KEY'],
#                                        server: 'email.us-west-2.amazonaws.com'
ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  domain: 'em9369.forjober.com',
  user_name: 'apikey',
  password: ENV['SENDGRID_PASSWORD'],
  authentication: "plain",
  enable_starttls_auto: true
}
