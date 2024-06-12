sig Interprete {}
sig Cancion {}
sig Catalogo {
canciones: set Cancion,
interpretes: set Interprete,
interpretaciones: canciones -> interpretes
}{
	//Se dice que un catalogo es consistente si:
	//todas las canciones del catalogo estan registradas por algun interprete
	all c: canciones | some i: interpretes | (c -> i) in interpretaciones
	// todo interprete del catalogo tiene registrada alguna cancion
	all i: interpretes | some c: canciones | (c -> i) in interpretaciones
}

//a) Un predicado que dado un catalogo y una cacnion con su interprete, devuelva un nuevo catalogo
//igual al primero pero con esa interpretacion agragada.

pred add[ca,ca_out:Catalogo, c:Cancion, i:Interprete]{
	ca_out.canciones = ca.canciones + c
	ca_out.interpretes = ca.interpretes + i
	ca_out.interpretaciones = ca.interpretaciones + (c -> i)
}

// b) Un predicado que dado un catalogo y una cancion con su interprete, devuelva un nuevo catalogo
// igual al primero pero eliminando esa interpretacion.
pred remove[ca,ca_out:Catalogo, c:Cancion, i:Interprete]{
	ca_out.canciones = ca.canciones
  	ca_out.interpretes = ca.interpretes
	ca_out.interpretaciones = ca.interpretaciones - (c -> i)
}

//b) Una funcion que, dado un catalogo, devuelva los pares de interpretes que interpretan la misma cancion
fun interpretesMismaCancion(ca: Catalogo): set (Interprete -> Interprete) {
  (~ca.interpretaciones . ca.interpretaciones) //???
}


//fun interpretesMismaCancion(ca: Catalogo): set (Interprete -> Interprete) {
//  { i1, i2: Interprete |
//    some c: ca.canciones |
//      (c -> i1) in ca.interpretaciones and (c -> i2) in ca.interpretaciones and i1 != i2
//  }
//}
