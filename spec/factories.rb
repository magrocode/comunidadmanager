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
    sequence(:identificador) { |n| "DEP#{n}0#{n}" }
    participacion 0.25
    comunidad
  end
end
