class RelacionComunidadUsuario < ActiveRecord::Base

	belongs_to :comunidad 
	belongs_to :usuario 
end
