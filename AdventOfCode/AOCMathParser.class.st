Class {
	#name : #AOCMathParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'expr',
		'number'
	],
	#category : #AdventOfCode
}

{ #category : #accessing }
AOCMathParser >> expr [
	| term prod prim rest |
	term := PP2UnresolvedNode new.
	prod := PP2UnresolvedNode new.
	prim := PP2UnresolvedNode new.
	rest := PP2UnresolvedNode new.
	"term
		def:
			((prod , $+ asPParser trim , term)
				==> [ :nodes | nodes first + nodes last ]) / prod.
	prod
		def:
			((prim , $* asPParser trim , prod)
				==> [ :nodes | nodes first * nodes last ]) / prim."
	term
		def:
			prim , rest star ==> [ :nodes | (nodes second) inject: (nodes first) into: [ :val :block | block value: val ] ].
	rest
		def:
			(($+ asPParser trim / $* asPParser trim), prim) ==> [ :nodes |
				(nodes first = $+) ifTrue: [ [ :other | nodes second + other ] ]
				ifFalse: [ [ :other | nodes second * other ] ]
			].
	prim
		def:
			($( asPParser trim , term , $) asPParser trim
				==> [ :nodes | nodes second ]) / number.
	^ term
]

{ #category : #accessing }
AOCMathParser >> number [ 
	^ #digit asPParser plus token trim ==> [ :token | token value asNumber ].

]

{ #category : #accessing }
AOCMathParser >> start [
	^ expr end.
]
