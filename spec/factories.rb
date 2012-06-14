FactoryGirl.define do
  factory :comunidad do
    sequence(:nombre) { |n| "Condominio #{n}" }
    street "Avda. Bernardo Ohiggins 2200"
    activa true
  end

  factory :usuario do
    sequence(:email) { |n| "usuario#{n}@foobar.com" }
    sequence(:nombre) { |n| "Usuario#{n}" }
    password "foobar"
    password_confirmation "foobar"
    comunidad
    # asigna permso de administracion
    factory :usuario_admin do
      administrador true
    end

    factory :system_admin do
      administrador false
      system_admin true
    end
  end

  factory :tipounidad do
    sequence(:nombre) { |n| "Tipo unidad #{n}" }
    comunidad
  end
  
  factory :unidad do
    sequence(:identificador) { |n| "DEP#{n}" }
    participacion 2.0001
    superficie 75.65
    comunidad
    tipounidad
  end

  factory :post do
    sequence(:titulo) { |n| "Post numero #{n}" }
    contenido "Contenido del post"
    comunidad
    usuario 
  end
end