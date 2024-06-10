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
