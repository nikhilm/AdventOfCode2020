Class {
	#name : #AOCBatchValidator,
	#superclass : #Object,
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCBatchValidator class >> validate: aString [
	| entries current |
	entries := OrderedCollection new.
	current := ''.
	aString lines
		do: [ :line | 
			line isEmpty
				ifTrue: [ entries add: current.
					current := '' ] ifFalse: [ current := current,' ',line ] ].
	entries add: current.
	^ entries collect: [ :entry | AOCPassportValidator isValid: entry ]
]
