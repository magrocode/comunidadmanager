module UsuariosHelper
# Returns the Gravatar (http://gravatar.com/) for the given usuario.
  def gravatar_for(usuario, options = { size: 50, addclass: '' })
    gravatar_id = Digest::MD5::hexdigest(usuario.email.downcase)
    size = options[:size]
    addclass = options[:addclass]
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: usuario.nombre, class: "gravatar #{addclass}")
  end
end
