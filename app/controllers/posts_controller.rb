class PostsController < ApplicationController

	before_filter :signed_in_user

	def create
		@comunidad = Comunidad.find(params[:comunidad_id])
		@post = @comunidad.posts.build(params[:post])
	    if @post.save
	      flash[:success] = "Nota Creada!"
	      redirect_to :back
	    else
	      redirect_to :back
	    end
	end
  
  	def destroy
  		@post = Post.find(params[:id])
  		@comunidad = @post.comunidad
   		@post.destroy
   		flash[:success] = "Nota eliminada"
    	redirect_back_or root_path
	end

	def edit
		@post = Post.find(params[:id])
		@comunidad = @post.comunidad 
	end

	def update
		@post = Post.find(params[:id])
		@comunidad = @post.comunidad

		if @post.update_attributes(params[:post])
			flash[:success] = "Nota actualizada exitosamente!"
			redirect_to comunidad_path(@comunidad)
		else
			render action: 'edit'
		end
	end

	private
  
	    def signed_in_user
	      # usuario logeado
	      redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
	    end
end
