Class {
	#name : #AOCMathParser2,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'expr',
		'number'
	],
	#category : #AdventOfCode
}

{ #category : #accessing }
AOCMathParser2 >> expr [
	| term prod prim |
	term := PP2UnresolvedNode new.
	prod := PP2UnresolvedNode new.
	prim := PP2UnresolvedNode new.
	prod
		def:
			((term , $* asPParser trim , prod)
				==> [ :nodes | nodes first * nodes last ]) / term.
	term
		def:
			((prim , $+ asPParser trim , term)
				==> [ :nodes | nodes first + nodes last ]) / prim.
	prim
		def:
			($( asPParser trim , prod , $) asPParser trim
				==> [ :nodes | nodes second ]) / number.
	^ prod
]

{ #category : #accessing }
AOCMathParser2 >> number [ 
	^ #digit asPParser plus token trim ==> [ :token | token value asNumber ].

]

{ #category : #accessing }
AOCMathParser2 >> start [
	^ expr end.
]
