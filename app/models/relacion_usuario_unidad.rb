class RelacionUsuarioUnidad < ActiveRecord::Base
	attr_accessible :unidad_id
	
	belongs_to :usuario
end
