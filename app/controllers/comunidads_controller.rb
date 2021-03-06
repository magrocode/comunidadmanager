class ComunidadsController < ApplicationController

  before_filter :signed_in_user,            only: [:index, :edit, :update, :show]
  before_filter :usuario_correcto,          only: [:show]
  before_filter :usuario_administrador,     only: [:edit, :update]
  before_filter :usuario_systemadmin,       only: [:index]
  before_filter :comunidad_desactivada,     only: [:show, :edit, :update]

  helper_method :sort_column, :sort_direction


  def index
    @comunidads = Comunidad.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
  end 

  def new
    @comunidad = Comunidad.new
    @usuario = @comunidad.usuarios.build
  end

  def show
    @comunidad = Comunidad.find(params[:id])
    @post = @comunidad.posts.build(usuario_id: current_user.id)
    @feed_posts = @comunidad.feed_posts.paginate(page: params[:page], per_page: 10).order("created_at DESC")
    #redirect_to root_path if @comunidad.nil?
  end
  
  def create
    @comunidad = Comunidad.new(nombre: params[:comunidad][:nombre])
    @usuario = Usuario.new(email: params[:usuario][:email],
                                         nombre: params[:usuario][:nombre],
                                         ##administrador: true,
                                         password: params[:usuario][:password],
                                         password_confirmation: params[:usuario][:password_confirmation])
    @usuario_existente = Usuario.find_by_email(params[:usuario][:email])

    if @usuario_existente != nil
    # usuario si existe
      @usuario = @usuario_existente

      if @comunidad.valid?

        if @comunidad.save
            @comunidad.autorizar_usuario!(@usuario)
            @comunidad.autorizar_administrador!(@usuario)
            sign_in @usuario
            set_comunidad @comunidad          
            flash[:success] = "Bienvenido a Cloudapolis"
            redirect_to @comunidad
            UsuarioMailer.welcome_email(@usuario).deliver  
        end 

      else
        render 'new'
      end

    else

      if @comunidad.valid? and @usuario.valid?

        if @comunidad.save

          if@usuario.save
            
            @comunidad.autorizar_usuario!(@usuario)
            @comunidad.autorizar_administrador!(@usuario)
            sign_in @usuario
            set_comunidad @comunidad          
            flash[:success] = "Bienvenido a Cloudapolis"
            redirect_to @comunidad
            UsuarioMailer.welcome_email(@usuario).deliver
          end                    
        end   

      else
        render 'new'
      end

    end
  end
  
  def edit
    @comunidad = Comunidad.find(params[:id])  
  end
  
  def update
    @comunidad = Comunidad.find(params[:id])
    
    if @comunidad.update_attributes(params[:comunidad])
      flash[:success] = "Comunidad actualizada exitosamente!"
      redirect_to comunidad_path
    else
      render action: 'edit'
    end  
  end

  def destroy
    @comunidad = Comunidad.find(params[:id])
    @comunidad.destroy
    flash[:success] = "Comunidad eliminada"
    redirect_to comunidads_path
  end

  def desactivar
    @comunidad = Comunidad.find(params[:id])
    @comunidad.desactivar!
    flash[:notice] = "Comunidad desactivada"
    redirect_to comunidads_path
  end

  def activar
    @comunidad = Comunidad.find(params[:id])
    @comunidad.activar!
    flash[:notice] = "Comunidad Activada"
    redirect_to comunidads_path
  end

  def seleccionar
    @comunidad = Comunidad.find(params[:id])
    set_comunidad @comunidad
    flash[:success] = "Ahora estas usando la comunidad #{@comunidad.nombre}!"
    redirect_to @comunidad
  end

  #def unidads
  #  @comunidad = Comunidad.find(params[:id])
  #  @unidads = @comunidad.unidads
  #  render 'show_unidads'
  #end
  
  private
  
    def signed_in_user
      # un usuario que se ha logeado en el sistema
      redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
    end
    
    def usuario_correcto
      # el usuario correcto pertenece a la comunidad, o es system_admin
      # el usuario correcto podra ver solamente :show
      #@comunidad_autorizada = current_comunidad
      @comunidad_autorizada = current_comunidad
      @comunidad_solicitada = Comunidad.find(params[:id])
      
      redirect_to comunidad_path(current_comunidad), alert: "Rayos! no eres un usuario en la comunidad que deseas..." unless @comunidad_autorizada == @comunidad_solicitada or current_user.system_admin?
    end
    
    def usuario_administrador
      # el usuario tiene privilegios de administrador
      #redirect_to comunidad_path(current_comunidad), alert: "Wrong! no eres un administrador" unless current_user.administrador?(current_comunidad) or current_user.system_admin?
      redirect_to comunidad_path(current_comunidad), alert: "Wrong! no eres un administrador" unless current_user.administrador?(current_comunidad) or current_user.system_admin?
    end

    def usuario_systemadmin
      # el usuario tiene privilegios de system_admin
      #redirect_to comunidad_path(current_comunidad), alert: "Hack! esto es imposible para ti" unless current_user.system_admin?
      redirect_to comunidad_path(current_comunidad), alert: "Hack! esto es imposible para ti" unless current_user.system_admin?
    end

    def comunidad_desactivada
      @comunidad = Comunidad.find(params[:id])
      redirect_to comunidad_desactivada_path unless @comunidad.activa? or current_user.system_admin?
    end

    ###########################################################
    # Helper Methods
    ###########################################################
    def sort_column
      Comunidad.column_names.include?(params[:sort]) ? params[:sort] : "nombre"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
