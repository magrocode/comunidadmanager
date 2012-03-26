FactoryGirl.define do
  factory :comunidad do
    nombre "Condominio Alcazar"
    email "alcazar@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :unidad do
    identificador "A101"
    participacion 0.86
    comunidad
  end
end