Class {
	#name : #AOCXMAS,
	#superclass : #Object,
	#instVars : [
		'preambleLength',
		'stream'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCXMAS >> firstNonCompliant [
	| preambleStart preamble sums test |
	preambleStart := 1.
	[ [ true ]
		whileTrue: [ preamble := stream
				collect: [ :x | x ]
				from: preambleStart
				to: preambleStart + preambleLength - 1.
			sums := self sums: preamble.
			test := stream at: preambleStart + preambleLength.
			(sums includes: test)
				ifFalse: [ ^ test ].
			preambleStart := preambleStart + 1. ] ]
		on: SubscriptOutOfBounds
		do: [  ]
]

{ #category : #'as yet unclassified' }
AOCXMAS >> preambleLength: anInteger stream: aCollection [ 
	preambleLength := anInteger.
	stream := aCollection.
]

{ #category : #'as yet unclassified' }
AOCXMAS >> sequenceThatSumsTo: anInteger [ 
	| start end seq sum |
	start := 1.
	end := 2.
	[ start < stream size ] whileTrue: [ 
		[ end <  stream size ] whileTrue: [ 
			seq := stream collect: [ :x | x ] from: start to: end.
			sum := seq sum.
			 sum < anInteger ifTrue: [ 
				"extend the range"
				end := end + 1.
			 ] ifFalse: [ 
				sum > anInteger ifTrue: [ 
					"this won't work, begin with a new start and end."
					start := start + 1.
					end := start + 1.
				 ] ifFalse: [ 
					"yay!"
					^ seq.
				 ]
			 ]
		]
	 ]
]

{ #category : #'as yet unclassified' }
AOCXMAS >> sums: aCollection [ 
	| sums |
	sums := Set new.
	(aCollection combinations: 2 atATimeDo: [ :combo | sums add: ((combo first) + (combo second)) ]).
	^ sums
]
