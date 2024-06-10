sig Vertex{}

sig Graph {
	vertices: set Vertex,
 	edge: Vertex -> Vertex
}

//el grafo es acíclico
pred AcyclicGraph [g: Graph] {
	 no iden & ^(g.edge)
}

//el grafo es dirigido
pred DirectedGraph [g: Graph] {
	g.edge = ~(g.edge)
}

//el grafo es fuertemente conexo
pred StronglyConnected [g: Graph] {
	//all v, w: g.vertices | v != w implies (v in w.^(g.edge) and w in v.^(g.edge))
	^(g.edge) = univ
}

//el grafo es conexo
pred ConnectedGraph [g: Graph] {
//	^(g.edge + ~(g.edge)) = univ
}

//el grafo contiene una componente fuertemente conexa
pred StronglyConnectedComponent [g: Graph] {

}

//el grafo contiene una componente conexa
pred ConnectedComponent [g: Graph] {

}
