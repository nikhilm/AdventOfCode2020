Class {
	#name : #AOCDockingComputerModel2,
	#superclass : #Object,
	#instVars : [
		'mask',
		'memory'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> allLocations: anInteger [ 
	"given an initial location, returns all the possible locations by applying the current mask"
	"first bitOr: with the 0/1 parts of the mask"
	| maskApplied bitPos answer |
	maskApplied := anInteger.
	self mask withIndexDo: [ :bit :i |
		bit ifNotNil: [ 
			bitPos := (36 - i + 1).
			maskApplied := maskApplied bitAt: bitPos put: ((maskApplied bitAt: bitPos) bitOr: bit).
		].
	].

	"now we need to generate all the possibilities for the Xs"
	answer := self generateFloatingLocations: maskApplied at: 36.
	self assert: (answer size) equals: (2 ** (self mask count: [ :x | x isNil ])).
	^ answer
]

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> applyMask: anInteger [
	| answer |
	answer := anInteger.
	self assert: (self mask size) equals: 36.
	self mask withIndexDo: [ :bit :i |
		bit ifNotNil: [ 
			answer := answer bitAt: (36-i+1) put: bit.
		]
	].
	^ answer
]

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> generateFloatingLocations: startLocation at: bitIndex [
	"given the current mask (used to decide if bitIndex is X or not) and the startLocation, returns a set of floating possibilities."
	| answer subsolutions |
	self assert: (bitIndex > 0 and: [ bitIndex <= 36 ]).
	
	"the base case is where the index is 1 and not an X, where we return a set with just one item, which is the startLocation. This way a mask with no Xs would just return the location itself."
	
	self assert: (self mask size) equals: 36.
	(bitIndex = 1 and: [ (self mask at: (36-bitIndex+1)) isNotNil ]) ifTrue: [ ^ { startLocation } asSet ].
	
	"base case where it is an X, just return the twiddles"
	(bitIndex = 1) ifTrue: [ answer := Set new.
		answer add: (startLocation bitAt: 1 put: 0).
		answer add: (startLocation bitAt: 1 put: 1).
		 ^ answer ]
	
	"otherwise, we call the recursive case, with the next index".
	subsolutions := (self generateFloatingLocations: startLocation at:  (bitIndex - 1)).
	
	"if this is an X, return a new set where for every entry in subsolutions we add two entries to the set"
	((self mask at: (36 - bitIndex + 1)) isNil) ifTrue: [ 
	answer := Set new.
	subsolutions do: [ :soln | 
		answer add: (soln bitAt: bitIndex put: 0).
		answer add: (soln bitAt: bitIndex put: 1).
		 ].
	^ answer.
	] ifFalse: [ "answer the underlying solution" ^ subsolutions ]
]

{ #category : #initialization }
AOCDockingComputerModel2 >> initialize [ 
	"We treat memory as a dictionary, since it is a 36 bit address space.
	nil/missing is considered to be 0 since it starts zero initialized."
	memory := Dictionary new.
]

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> mask [
	^ mask
]

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> mask: aCollection [ 
	mask := aCollection.
]

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> memory [
	^ memory
]

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> parseMask: aMask [
	"translate a string like XXXX10XXX0 into a upto 36 length sequence. we use a sequence of indices
	because this mask needs to handle the floating thing. so in the sequence, nil indicates X (floating), while anything else is the actual value. highest bit is first."
	self assert: (aMask size) equals: 36.
	^ aMask collect: [ :ch |
		(ch = $X) ifTrue: [ nil ] ifFalse: [ (ch = $1) ifTrue: [ 1 ] ifFalse: [ 0 ] ]
	] as: OrderedCollection .
]

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> runInstruction: aString [ 
	(self runMaskInstruction: aString) ifFalse: [ 
		self runSetInstruction: aString
	 ]
]

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> runMaskInstruction: aString [ 
	(aString beginsWith: 'mask = ') ifTrue: [ 
		self mask: (self parseMask: (aString allButFirst: 7)).
		^ true
	] ifFalse: [ 
		^ false
	]
]

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> runProgram: aString [ 
	| instructions |
	instructions := aString lines.
	instructions do: [ :ins | self runInstruction: ins ].
	
]

{ #category : #'as yet unclassified' }
AOCDockingComputerModel2 >> runSetInstruction: aString [ 
	| close location value allLocations |
	(aString beginsWith: 'mem[') ifTrue: [ 
			close := aString indexOf: $].
			"mem[ = 5"
			location := (aString copyFrom: 5 to: close) asNumber.
			"]_=_ -> number starts at close + 4 and goes till the end"
			value := (aString allButFirst: (close+3)) asNumber.
			allLocations := (self allLocations: location).
			allLocations do: [ :loc |
				self memory at: loc put: value.
			].
			^ true
	] ifFalse: [ ^ false ]
]
