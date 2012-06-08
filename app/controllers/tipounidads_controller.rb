class TipounidadsController < ApplicationController

before_filter :signed_in_user
before_filter :comunidad_correcta, 	:only => [:index, :new]
#before_filter :usuario_correcto,    :only => [:show]
before_filter :admin_user,          :only => [:index, :new, :edit, :update, :destroy]

helper_method :sort_column, :sort_direction

	def index
		@comunidad = Comunidad.find(params[:comunidad_id])
		@tipounidads = @comunidad.tipounidads.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
	end

	def new	
		@comunidad = Comunidad.find(params[:comunidad_id])
		@tipounidad = @comunidad.tipounidads.build	
	end

	def create
		@comunidad = Comunidad.find(params[:comunidad_id])
		@tipounidad = @comunidad.tipounidads.build(params[:tipounidad])

		if @tipounidad.save
			flash[:success] = "Tipo de unidad creado!"
			redirect_to comunidad_tipounidads_path(@comunidad)
		else
			render action: 'new'
		end
	end

	#def show
	#	@tipounidad = Tipounidad.find(params[:id])
	#	@comunidad = @tipounidad.comunidad
	#end

	def edit
		@tipounidad = Tipounidad.find(params[:id])
		@comunidad = @tipounidad.comunidad
	end

	def update
		@tipounidad = Tipounidad.find(params[:id])
		@comunidad = @tipounidad.comunidad

		if @tipounidad.update_attributes(params[:tipounidad])
			flash[:success] = 'Tipo de unidad actualizado exitosamente!'
			redirect_to tipounidad_path
		else
			render action: 'edit'
		end
	end

	def destroy
		@tipounidad = Tipounidad.find(params[:id])
		@comunidad = @tipounidad.comunidad		
		@tipounidad.destroy

		redirect_to comunidad_tipounidads_path(@comunidad)
	end

	private
		
		def signed_in_user
			redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
	    end
		
		def admin_user
	    	redirect_to comunidad_path(current_user.comunidad), notice: "Wrong!! No eres administrador" unless current_user.administrador? or current_user.system_admin?
	    end

	    def usuario_correcto
	    	@tipounidad = Tipounidad.find(params[:id])
	    	redirect_to comunidad_path(current_user.comunidad) unless @tipounidad.comunidad == current_user.comunidad or current_user.system_admin?
	    end

		def comunidad_correcta
	      @comunidad_autorizada = current_user.comunidad
	      @comunidad_solicitada = Comunidad.find(params[:comunidad_id])
	      redirect_to comunidad_path(current_user.comunidad) unless @comunidad_autorizada == @comunidad_solicitada or current_user.system_admin?
	    end

		def sort_column
	      Tipounidad.column_names.include?(params[:sort]) ? params[:sort] : "nombre"
	    end
	    
	    def sort_direction
	      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	    end

end
