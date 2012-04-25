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

  departamento = comunidadA.tipounidads.create(nombre: "Departamento")
  bodega = comunidadA.tipounidads.create(nombre: "Bodega")
  estacionamiento = comunidadA.tipounidads.create(nombre: "Estacionamiento")

  comunidadA.unidads.create(identificador: 'DEP-A101', participacion: 12.5, superficie: 54.65, tipounidad: departamento )
  comunidadA.unidads.create(identificador: 'DEP-B101', participacion: 25.0000, superficie: 75, tipounidad: departamento )
  comunidadA.unidads.create(identificador: 'BOD-C101', participacion: 12.5, superficie: 54.65, tipounidad: bodega )
  comunidadA.unidads.create(identificador: 'EST-D101', participacion: 25.0000, superficie: 75, tipounidad: estacionamiento )


# COMUNIDAD B
comunidadB = Comunidad.create(nombre: 'Edificio Nuevo Mundo')

  comunidadB.usuarios.create(email: 'mario@nuevomundo.com', nombre: 'Mario Espinoza', administrador: true, password: 'foobar', password_confirmation: 'foobar')
  comunidadB.usuarios.create(email: 'claudia@nuevomundo.com', nombre: 'Claudia Valenzuela', administrador: false, password: 'foobar', password_confirmation: 'foobar')
  comunidadB.usuarios.create(email: 'pablo@nuevomundo.com', nombre: 'Pablo Vicuna', administrador: false, password: 'foobar', password_confirmation: 'foobar')
  comunidadB.usuarios.create(email: 'esteban@nuevomundo.com', nombre: 'Esteban Espinoza', administrador: false, password: 'foobar', password_confirmation: 'foobar')

  parcela = comunidadB.tipounidads.create(nombre: "Parcela")
  bodegaB = comunidadB.tipounidads.create(nombre: "Bodega")


  comunidadB.unidads.create(identificador: 'A', participacion: 12.5, superficie: 54.65, tipounidad: parcela )
  comunidadB.unidads.create(identificador: 'B', participacion: 25.0000, superficie: 75, tipounidad: bodegaB )
  comunidadB.unidads.create(identificador: 'C', participacion: 12.5, superficie: 54.65, tipounidad: parcela )
  comunidadB.unidads.create(identificador: 'D', participacion: 25.0000, superficie: 75, tipounidad: bodegaB )
  comunidadB.unidads.create(identificador: 'E', participacion: 25.0000, superficie: 75, tipounidad: parcela )
