module UsuariosHelper
# Returns the Gravatar (http://gravatar.com/) for the given usuario.
  def gravatar_for(usuario, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(usuario.email.downcase)
    size = options[:size]
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: usuario.nombre, class: "gravatar")
  end
end
