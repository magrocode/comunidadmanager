FactoryGirl.define do
  factory :comunidad do
    nombre "Comunidad Nuevo Horizonte"
    email "mario@magrocode.com"
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :unidad do
    identificador "A101"
    participacion 0.86
    comunidad_id 1  
  end
end