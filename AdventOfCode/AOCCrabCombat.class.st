Class {
	#name : #AOCCrabCombat,
	#superclass : #Object,
	#instVars : [
		'player1',
		'player2'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCCrabCombat class >> from: aString [ 
	| index p1 p2 |
	index := aString findString: (Character lf asString, Character lf asString).
	self assert: index > 0.
	p1 := AOCCombatPlayer from: (aString first: index).
	p2 := AOCCombatPlayer from: (aString allButFirst: index + 1).
	^ AOCCrabCombat new player: p1 player: p2
]

{ #category : #'as yet unclassified' }
AOCCrabCombat >> play [
	"single step. "
	| p1card p2card |
	p1card := [ player1 play ] on: CollectionIsEmpty do: [ ^ self ].
	p2card := [ player2 play ] on: CollectionIsEmpty do: [ ^ self ].
	self assert: p1card ~= p2card.
	p1card < p2card ifTrue: [ 
		"remember to put the players card on top"
		player2 winHand: p2card other: p1card.
	] ifFalse: [ 
		player1 winHand: p1card other: p2card.
	]
	
]

{ #category : #'as yet unclassified' }
AOCCrabCombat >> playRecursive [
	"single step. plays recursive combat and takes that into consideration"
	| p1card p2card subgame |
	(player1 isRepeating and: [ player2 isRepeating ]) ifTrue: [ ^ #player1 ].
	player1 recordPlay.
	player2 recordPlay.
	player1 lost ifTrue: [ ^ #player2 ].
	player2 lost ifTrue: [ ^ #player1 ].
	
	p1card := player1 play.
	p2card := player2 play.
	((player1 hasAtleastCards: p1card) and: [ player2 hasAtleastCards: p2card ]) ifTrue: [ 
		"winner is determined by playing aa new game"
		subgame := AOCCrabCombat new
			 player: (player1 sub: p1card) player: (player2 sub: p2card).
		subgame playToWinRecursive = #player1 ifTrue: [ 
			player1 winHand: p1card other: p2card.
		] ifFalse: [
			player2 winHand: p2card other: p1card. 
		]
	] ifFalse: [ 
		self assert: p1card ~= p2card.
		p1card < p2card ifTrue: [ 
			"remember to put the players card on top"
			player2 winHand: p2card other: p1card.
		] ifFalse: [ 
			player1 winHand: p1card other: p2card.
		].
	].
	^ #keepPlaying
	
]

{ #category : #'as yet unclassified' }
AOCCrabCombat >> playToWin [
	"answers the player who won"
	[ player1 lost or: [ player2 lost ] ] whileFalse: [ 
		self play
	].
	^ player1 lost ifTrue: [ player2 ] ifFalse: [ player1 ]
]

{ #category : #'as yet unclassified' }
AOCCrabCombat >> playToWinRecursive [
	"aunlike playToWin, answers a symbol incdicating the player, since that is useful for playing recursively."
	|result|
	result := self playRecursive.
	[ result = #keepPlaying ] whileTrue: [ 
		result := self playRecursive
	].
	self assert: (result = #player1 or: [ result = #player2 ]).
	^ result
]

{ #category : #'as yet unclassified' }
AOCCrabCombat >> playToWinRecursiveStart [
	"answers the player who won"
	^ self playToWinRecursive = #player1 ifTrue: [ player1 ] ifFalse: [ player2 ]
]

{ #category : #'as yet unclassified' }
AOCCrabCombat >> player: anAOCCombatPlayer player: anAOCCombatPlayer2 [ 
	player1 := anAOCCombatPlayer .
	player2 := anAOCCombatPlayer2 .
]
