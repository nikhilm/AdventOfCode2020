Class {
	#name : #AOCBagRules,
	#superclass : #Object,
	#category : #'AdventOfCode-AdventOfCode'
}

{ #category : #accessing }
AOCBagRules >> countRecursive: aGraph startingAt: aNode [
	| neighbors thisColorBags below x |
	"important to convert to collection here, otherwise it will act like a set and skip counts that already exist!"
	neighbors := (aGraph at: aNode) asOrderedCollection.
	neighbors isEmpty ifTrue: [ ^ 0 ].
	x := (neighbors collect: [:neighbor |
	   thisColorBags := neighbor first.
		below := self countRecursive:aGraph startingAt:(neighbor second).
		
		thisColorBags + (thisColorBags * below)
	]).
	^ x sum
]

{ #category : #accessing }
AOCBagRules >> reachable: graph from: startNode [
	|visited queue node neighbors |
	visited := Set new.
	queue := OrderedCollection new.
	queue add: startNode.
	[ queue isEmpty ] whileFalse: [
		node := queue removeFirst.
		neighbors := graph at: node ifAbsent: [OrderedCollection new].
		neighbors do: [ :neighbor | (visited includes: neighbor) ifFalse: [ queue add: neighbor. visited add: neighbor. ] ]
	].
	^ visited
	 
]

{ #category : #accessing }
AOCBagRules >> rulesToContainerAssocGraph: rules [
"keys are color, but values are pair of number + color"
| graph container contains |

	graph := Dictionary new.
rules do: [ :rule |
container := rule first.
contains := rule second.
contains do: [ :contain |
	(graph at: container ifAbsentPut: [ Set new] ) add: contain.
].
"remember to add the container regardless of contains being empty!"
"otherwise we won't count that singular bag when it is in something else."
graph at: container ifAbsentPut: [Set new].
].
^ graph.
]

{ #category : #accessing }
AOCBagRules >> rulesToContainingAssocGraph: rules [
| canFitInside container contains |
	canFitInside := Dictionary new.
rules do: [ :rule |
container := rule first.
contains := rule second.
contains do: [ :contain |

"ignore the count for now" 
	(canFitInside at: (contain last) ifAbsentPut: [ Set new] ) add: container.
]
].
^ canFitInside.
]
