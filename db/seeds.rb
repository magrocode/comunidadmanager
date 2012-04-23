# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# COMUNIDAD A
comunidadA = Comunidad.create(nombre: 'Condiminio Alcazar')

  comunidadA.usuarios.create(email: 'mario@foobar.com', nombre: 'Mario Espinoza', administrador: true, password: 'foobar', password_confirmation: 'foobar')
  comunidadA.usuarios.create(email: 'claudia@foobar.com', nombre: 'Claudia Valenzuela', administrador: false, password: 'foobar', password_confirmation: 'foobar')
  comunidadA.usuarios.create(email: 'pablo@foobar.com', nombre: 'Pablo Vicuna', administrador: true, password: 'foobar', password_confirmation: 'foobar')
  comunidadA.usuarios.create(email: 'esteban@foobar.com', nombre: 'Esteban', administrador: false, password: 'foobar', password_confirmation: 'foobar')

  comunidadA.unidads.create(identificador: 'DEP-A101', participacion: 12.5, superficie: 54.65 )
  comunidadA.unidads.create(identificador: 'DEP-B101', participacion: 25.0000, superficie: 75 )
  comunidadA.unidads.create(identificador: 'DEP-C101', participacion: 12.5, superficie: 54.65 )
  comunidadA.unidads.create(identificador: 'DEP-D101', participacion: 25.0000, superficie: 75 )


# COMUNIDAD B
comunidadB = Comunidad.create(nombre: 'Edificio Nuevo Mundo')
comunidadB.usuarios.create(email: 'mario@nuevomundo.com', nombre: 'Mario Espinoza', administrador: true, password: 'foobar', password_confirmation: 'foobar')
comunidadB.usuarios.create(email: 'claudia@nuevomundo.com', nombre: 'Claudia Valenzuela', administrador: false, password: 'foobar', password_confirmation: 'foobar')
comunidadB.usuarios.create(email: 'pablo@nuevomundo.com', nombre: 'Pablo Vicuna', administrador: false, password: 'foobar', password_confirmation: 'foobar')
comunidadB.usuarios.create(email: 'esteban@nuevomundo.com', nombre: 'Esteban Espinoza', administrador: false, password: 'foobar', password_confirmation: 'foobar')

  comunidadB.unidads.create(identificador: 'A', participacion: 12.5, superficie: 54.65 )
  comunidadB.unidads.create(identificador: 'B', participacion: 25.0000, superficie: 75 )
  comunidadB.unidads.create(identificador: 'C', participacion: 12.5, superficie: 54.65 )
  comunidadB.unidads.create(identificador: 'D', participacion: 25.0000, superficie: 75 )
  comunidadB.unidads.create(identificador: 'E', participacion: 25.0000, superficie: 75 )
