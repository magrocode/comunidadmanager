# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# COMUNIDAD A
comunidadA = Comunidad.create(nombre: 'Cloudapolis', street: 'Rafael Sotomayor 55', city: 'Santiago', country: 'Chile', telefono: '5626990177', email: 'cloudapolis@gmail.com', twitter: '@cloudapolis')

  comunidadA.usuarios.create(email: 'mario@magrocode.com', nombre: 'Mario Espinoza', system_admin: true, password: 'foobar', password_confirmation: 'foobar', twitter: '@codelious', telefono: '56-2-688-3010')
  comunidadA.usuarios.create(email: 'claudia@foobar.com', nombre: 'Claudia Valenzuela', password: 'foobar', password_confirmation: 'foobar', twitter: '@claudiavalenzuela', telefono: '56-9-8199-0964')
  comunidadA.usuarios.create(email: 'pablo@foobar.com', nombre: 'Pablo Vicuna', password: 'foobar', password_confirmation: 'foobar', twitter: '@sabogados', telefono: '56-2-696-2356')
  comunidadA.usuarios.create(email: 'esteban@foobar.com', nombre: 'Esteban Espinoza', password: 'foobar', password_confirmation: 'foobar', twitter: '@reyflow', telefono: '56-2-627-0348')

  departamento = comunidadA.tipounidads.create(nombre: "Departamento")
  bodega = comunidadA.tipounidads.create(nombre: "Bodega")
  estacionamiento = comunidadA.tipounidads.create(nombre: "Estacionamiento")

  comunidadA.unidads.create(identificador: 'DEP-A101', participacion: 12.5, superficie: 54.65, tipounidad: departamento )
  comunidadA.unidads.create(identificador: 'DEP-B101', participacion: 25.0000, superficie: 75, tipounidad: departamento )
  comunidadA.unidads.create(identificador: 'BOD-C101', participacion: 12.5, superficie: 54.65, tipounidad: bodega )
  comunidadA.unidads.create(identificador: 'EST-D101', participacion: 25.0000, superficie: 75, tipounidad: estacionamiento )


# COMUNIDAD B
comunidadB = Comunidad.create(nombre: 'Parcelacion Dona Ines del Oliveto', street: 'Camino Lonquen p. 29', city: 'Calera de Tango', country: 'Chile', telefono: '5695553265', email: 'donainesdeloliveto@yahoo.es', twitter: '@donainesdeloliveto')

  comunidadB.usuarios.create(email: 'mario@nuevomundo.com', nombre: 'Mario Espinoza', password: 'foobar', password_confirmation: 'foobar', twitter: '@codelious', telefono: '56-2-688-3010')
  comunidadB.usuarios.create(email: 'claudia@nuevomundo.com', nombre: 'Claudia Valenzuela', password: 'foobar', password_confirmation: 'foobar', twitter: '@claudiavalenzuela', telefono: '56-9-8199-0964')
  comunidadB.usuarios.create(email: 'pablo@nuevomundo.com', nombre: 'Pablo Vicuna', password: 'foobar', password_confirmation: 'foobar', twitter: '@sabogados', telefono: '56-2-696-2356')
  comunidadB.usuarios.create(email: 'esteban@nuevomundo.com', nombre: 'Esteban Espinoza', password: 'foobar', password_confirmation: 'foobar', twitter: '@reyflow', telefono: '56-2-627-0348')

  parcela = comunidadB.tipounidads.create(nombre: "Parcela")
  bodegaB = comunidadB.tipounidads.create(nombre: "Bodega")


  comunidadB.unidads.create(identificador: 'A', participacion: 12.5, superficie: 54.65, tipounidad: parcela )
  comunidadB.unidads.create(identificador: 'B', participacion: 25.0000, superficie: 75, tipounidad: bodegaB )
  comunidadB.unidads.create(identificador: 'C', participacion: 12.5, superficie: 54.65, tipounidad: parcela )
  comunidadB.unidads.create(identificador: 'D', participacion: 25.0000, superficie: 75, tipounidad: bodegaB )
  comunidadB.unidads.create(identificador: 'E', participacion: 25.0000, superficie: 75, tipounidad: parcela )


# COMUNIDAD C
comunidadC = Comunidad.create(nombre: 'Edificio Agua Azul', street: 'Alameda 1315', city: 'Santiago', country: 'Chile', telefono: '5695553265', email: 'aguaazul@yahoo.es', twitter: '@aguaazul')

  comunidadC.usuarios.create(email: 'mario@nuevomundo.com', nombre: 'Mario Espinoza', password: 'foobar', password_confirmation: 'foobar', twitter: '@codelious', telefono: '56-2-688-3010')