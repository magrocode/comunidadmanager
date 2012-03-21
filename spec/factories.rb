FactoryGirl.define do
  factory :usuario do
    nombre_comunidad "Comunidad Nuevo Horizonte"
    email "mario@magrocode.com"
    password "foobar"
    password_confirmation "foobar"
  end
end