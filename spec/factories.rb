FactoryGirl.define do
  factory :comunidad do
    sequence(:nombre) { |n| "Condominio #{n}" }
    sequence(:email) { |n| "condominio#{n}@gmail.com" }
    password "foobar"
    password_confirmation "foobar"
    
    #factory :admin do
    #  admin true
    #end
  end
  
  factory :unidad do
    identificador "A101"
    participacion 0.86
    comunidad
  end
end
