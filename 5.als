sig Elem {}

//preorder: reflexive and transitive
pred PreOrder [R: Elem -> Elem] {
	iden in R
	R.R in R
}

//partial order: Reflexivity, Antisymmetry, Transitivity

pred PartialOrder [R: Elem -> Elem] {
	iden in R
	(R & ~R) in iden
	R.R in R
}

// total order: partial order and a ≤ b o b ≤ a
pred TotalOrder [R: Elem -> Elem] {
	PartialOrder[R]
	(univ->univ) in (R + ~R) // preguntar Elem -> Elem in (R + ~R)
	//all x, y: Elem | x -> y in R or y -> x in R
}

//strict order: Irreflexive, Asymmetric, Transitive
pred StrictOrder [R: Elem -> Elem] {
	//complement univ -> univ - R
	iden not in R
	R in ~(univ -> univ - R) //alternative all x, y: Elem | x -> y in R and y -> x not in R
	R.R in R //alternative  all x, y: Elem | all z: Elem | (x -> z in R and z -> y in R) implies x -> y in R
} 

pred HasFirstElement [R: Elem -> Elem]{
	some a: Elem | all b: Elem | a->b in R
}

pred HasLastElement [R: Elem -> Elem]{
	some a: Elem | all b: Elem | b->a in R
}

//assertions
assert allPartialTotal {
    all R:Elem -> Elem | PartialOrder[R] implies TotalOrder[R] // and or implies?
}

assert allPartialHasFirst {
    all R:(Elem -> Elem) | PartialOrder[R] implies HasFirstElement[R] // and or implies?
}

//todo orden total con primer elemento x y ´ultimo elemento y satisface x != y;
assert allTotalWithFirstAndLast {
	all x,y: Elem | all R:(Elem -> Elem) |
	(x->y in R and PartialOrder[R] and HasFirstElement[R] and HasLastElement[R]) implies
	x != y 
}

//la uni´on de ´ordenes estrictos es un orden estricto;
assert StrictUnionIsStrict {
	all R, S:(Elem -> Elem) | StrictOrder[R] and StrictOrder[S] implies StrictOrder[R+S]
}

// la composici´on de ´ordenes estrictos es un orden estricto
assert StrictCompositionIsStrict {
	all R, S:(Elem -> Elem) | StrictOrder[R] and StrictOrder[S] implies StrictOrder[R.S]
}

check allPartialTotal for 5
//check allPartialHasFirst for 5
//check allTotalWithFirstAndLast for 5
//check StrictUnionIsStrict for 5
//check StrictCompositionIsStrict for 5
