class ApplicationController < ActionController::Base
  	protect_from_forgery
  	include SessionsHelper

  	before_filter :set_locale

	def set_locale
		# I18n.locale = params[:locale] || I18n.default_locale
		if defined? current_user.lenguaje
			I18n.locale = current_user.lenguaje || I18n.default_locale
		else
			I18n.locale = params[:locale] || I18n.default_locale
		end
	end

	def default_url_options(options={})
  		logger.debug "default_url_options is passed options: #{options.inspect}\n"
  		{ :locale => I18n.locale }
	end
end
