Class {
	#name : #AOCCombatPlayer,
	#superclass : #Object,
	#instVars : [
		'deck',
		'previousPlays'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCCombatPlayer class >> from: aString [ 
	| deck lines |
	deck := OrderedCollection new.
	lines := aString lines asOrderedCollection .
	lines := lines allButFirst. "skip the player name"
	lines do: [ :line | [ deck add: line asNumber ] on: Error do: [ ] ].
	^ AOCCombatPlayer new deck: deck	
]

{ #category : #'as yet unclassified' }
AOCCombatPlayer >> deck: aCollection [ 
	deck := aCollection
]

{ #category : #testing }
AOCCombatPlayer >> hasAtleastCards: aNumber [
	^ deck size >= aNumber
]

{ #category : #initialization }
AOCCombatPlayer >> initialize [ 
	previousPlays := Set new.
]

{ #category : #testing }
AOCCombatPlayer >> isRepeating [
	^ previousPlays includes: deck 
]

{ #category : #'as yet unclassified' }
AOCCombatPlayer >> lost [
	^ deck isEmpty
]

{ #category : #playing }
AOCCombatPlayer >> play [
	^ deck removeFirst
]

{ #category : #'as yet unclassified' }
AOCCombatPlayer >> recordPlay [
	previousPlays add: deck copy
]

{ #category : #'as yet unclassified' }
AOCCombatPlayer >> score [
	^ (deck reverse withIndexCollect: [ :card :index | card * index ]) sum
]

{ #category : #accessing }
AOCCombatPlayer >> sub: aNumber [
	"answers a new player with ta subset of cards.
	
	This player does not share the set of previousPlays"
	self assert: (self hasAtleastCards: aNumber).
	^ AOCCombatPlayer new deck: (deck copyFrom: 1 to: aNumber)
]

{ #category : #'as yet unclassified' }
AOCCombatPlayer >> winHand: anInteger other: anInteger2 [ 
	deck add: anInteger.
	deck add: anInteger2.
]
