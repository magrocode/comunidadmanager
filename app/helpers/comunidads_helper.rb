module ComunidadsHelper

	def current_comunidad=(comunidad)
	    @current_comunidad = comunidad
	end
	
	def current_comunidad
		@current_comunidad  ||= current_user.comunidad
	end
	 
	def current_comunidad?(comunidad)
		comunidad == current_comunidad
	end
 
 private
    
    def clear_return_to
      session.delete(:return_to)
    end

end
