# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Comunidadmanager::Application.initialize!

# action mailer en stmp
config.action_mailer.delivery_method = :smtp