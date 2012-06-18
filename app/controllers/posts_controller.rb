class PostsController < ApplicationController

	def create
		@post = current_user.comunidad.posts.build(params[:post])
	    if @post.save
	      flash[:success] = "Nota o Post Creado!"
	      redirect_back_or root_path
	    else
	      redirect_back_or root_path
	    end
	end
  
  	def destroy
  		@post = Post.find(params[:id])
   		@post.destroy
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
			flash[:success] = "Nota o Post actualizado exitosamente!"
			redirect_to comunidad_path(@comunidad)
		else
			render action: 'edit'
		end
	end

end
