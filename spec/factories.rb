FactoryGirl.define do
  factory :comunidad do
    sequence(:nombre) { |n| "Condominio #{n}" }
    street "Avda. Bernardo Ohiggins 2200"
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
end
