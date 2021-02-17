Class {
	#name : #AOCMemoryGame,
	#superclass : #Object,
	#instVars : [
		'numberDict',
		'lastSpoken',
		'turnNumber'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCMemoryGame class >> seedWith: aSequence [
	"Records the seed turns"
	|ans|
	ans := self new.
	aSequence do: [ :x | ans recordTurn: x ].
	^ ans.
]

{ #category : #initialization }
AOCMemoryGame >> initialize [ 
	turnNumber := 0.
	"a dictionary from number to sequence of numbers is used to find out when was the last time a number was spoken. The key is the spoken number (not the turn number) and the values are turn numbers (not spoken numbers). Everything is 1 indexed. The sequence is actually an array truncated to length 2."
	"IdentityDictionary is roughly an order of magnitude faster than Dictionary. Pharo dicts are still really slow though and part 2 takes ~5-7min on a Pixelbook mobile processor."
	numberDict := Dictionary new: 30000000.
]

{ #category : #'as yet unclassified' }
AOCMemoryGame >> recordTurn: anInteger [
	"updates object state with the new value"

	| record |
	turnNumber := turnNumber + 1.
	lastSpoken := anInteger.
	record := numberDict at: anInteger ifAbsentPut: [ {0 . 0} ].
	record at: 1 put: (record at: 2).
	record at: 2 put: turnNumber
]

{ #category : #'as yet unclassified' }
AOCMemoryGame >> turn [
	"play a turn. answer the number that was spoken."

	| turnsForNumber spoken |
	turnsForNumber := numberDict at: lastSpoken.
	spoken := turnsForNumber first = 0
		ifTrue:
			[ "If that was the first time the number has been spoken, the current player says 0" 0 ]
		ifFalse:
			[ "Otherwise, the number had been spoken before; the current player announces how many turns apart the number is from when it was previously spoken" turnsForNumber last - turnsForNumber first ].
	self recordTurn: spoken.
	^ spoken
]
