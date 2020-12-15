Class {
	#name : #AOCDockingComputer,
	#superclass : #Object,
	#instVars : [
		'mask',
		'memory'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCDockingComputer >> applyMask: anInteger [
	| answer |
	answer := anInteger.
	self assert: (self mask size = 36).
	self mask withIndexDo: [ :bit :i |
		bit ifNotNil: [ 
			answer := answer bitAt: (36-i+1) put: bit.
		]
	].
	^ answer
]

{ #category : #initialization }
AOCDockingComputer >> initialize [ 
	"We treat memory as a dictionary, since it is a 36 bit address space.
	nil/missing is considered to be 0 since it starts zero initialized."
	memory := Dictionary new.
]

{ #category : #'as yet unclassified' }
AOCDockingComputer >> mask [
	^ mask
]

{ #category : #'as yet unclassified' }
AOCDockingComputer >> mask: aCollection [ 
	mask := aCollection.
]

{ #category : #'as yet unclassified' }
AOCDockingComputer >> memory [
	^ memory
]

{ #category : #'as yet unclassified' }
AOCDockingComputer >> parseMask: aMask [
	"translate a string like XXXX10XXX0 into a upto 36 length sequence. we use a sequence of indices
	because this mask is not AND/ORed it simply overwrites wherever bits are set. so in the sequence, nil indicates don't do anything, while anything else is the actual value. highest bit is first."
	self assert: (aMask size = 36).
	^ aMask collect: [ :ch |
		(ch = $X) ifTrue: [ nil ] ifFalse: [ (ch = $1) ifTrue: [ 1 ] ifFalse: [ 0 ] ]
	] as: OrderedCollection .
]

{ #category : #'as yet unclassified' }
AOCDockingComputer >> runInstruction: aString [ 
	(self runMaskInstruction: aString) ifFalse: [ 
		self runSetInstruction: aString
	 ]
]

{ #category : #'as yet unclassified' }
AOCDockingComputer >> runMaskInstruction: aString [ 
	(aString beginsWith: 'mask = ') ifTrue: [ 
		self mask: (self parseMask: (aString allButFirst: 7)).
		^ true
	] ifFalse: [ 
		^ false
	]
]

{ #category : #'as yet unclassified' }
AOCDockingComputer >> runProgram: aString [ 
	| instructions |
	instructions := aString lines.
	instructions do: [ :ins | self runInstruction: ins ].
	
]

{ #category : #'as yet unclassified' }
AOCDockingComputer >> runSetInstruction: aString [ 
	| close location value |
	(aString beginsWith: 'mem[') ifTrue: [ 
			close := aString indexOf: $].
			"mem[ = 5"
			location := (aString copyFrom: 5 to: close) asNumber.
			"]_=_ -> number starts at close + 4 and goes till the end"
			value := (aString allButFirst: (close+3)) asNumber.
			self memory at: location put: (self applyMask: value).
			^ true
	] ifFalse: [ ^ false ]
]
