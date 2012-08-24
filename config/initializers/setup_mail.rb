#load email config
EMAIL_CONFIG = YAML.load_file("#{Rails.root}/config/email.yml")[Rails.env]

#Action Mailer
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_charset = 'utf-8'
ActionMailer::Base.smtp_settings = {
  :address        => "tvserienonline.megiteam.pl",
  :port           => 25,
  :domain         => "www.serialowyswiat.pl",
  :user_name      => EMAIL_CONFIG['login'],
  :password       => EMAIL_CONFIG['password'],
  :authentication => :login,
  :enable_starttls_auto => true
}
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
