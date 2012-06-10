ActionMailer::Base.smtp_settings = {
	:address              => "mail.magrocode.com",
  	:port                 => 26,
  	:domain               => "magrocode.com",
  	:user_name            => "mario@magrocode.com",
  	:password             => "ma@12.DEV",
  	:authentication       => "plain",
  	:enable_starttls_auto => true
}