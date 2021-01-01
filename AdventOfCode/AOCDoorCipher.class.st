Class {
	#name : #AOCDoorCipher,
	#superclass : #Object,
	#instVars : [
		'subject'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCDoorCipher >> performRound: value [
	^ (value * subject) rem: 20201227.
]

{ #category : #'as yet unclassified' }
AOCDoorCipher >> performRounds: numberOfRounds [
	| value |
	value := 1.
	numberOfRounds timesRepeat: [ value := self performRound: value ].
	^ value
]

{ #category : #'as yet unclassified' }
AOCDoorCipher >> roundsFor: aCompare [
	| counter value |
	counter := 0.
	value := 1.
	"since we module by this number, limit to that number"
	20201227 timesRepeat: [ 
		counter := counter + 1.
		value := self performRound: value.
		value = aCompare ifTrue: [ ^ counter ].
	].
	^ nil.
]

{ #category : #'as yet unclassified' }
AOCDoorCipher >> subject: anInteger [ 
	subject := anInteger
]
