class PostsController < ApplicationController

	def create
		@post = current_user.comunidad.posts.build(params[:post])
	    if @post.save
	      flash[:success] = "Nota o Post Creado!"
	      redirect_to comunidad_path(current_user.comunidad)
	    else
	      redirect_to comunidad_path(current_user.comunidad)
	    end
	end
  
  	def destroy
   		@post.destroy
    	redirect_back_or root_path
	end
end
