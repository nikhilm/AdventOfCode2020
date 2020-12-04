Class {
	#name : #TreeCounter,
	#superclass : #Object,
	#instVars : [
		'stepRight',
		'stepDown'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
TreeCounter class >> stepRight: anInteger stepDown: anInteger2 [ 
	^ self new stepRight: anInteger; stepDown: anInteger2; yourself .
]

{ #category : #'as yet unclassified' }
TreeCounter >> count: aString [
	| lines width position char trees x rem |
	lines := aString lines.
	width := (lines at: 1) size.
	position := 1 @ 1 translateBy: stepRight @ stepDown.
	trees := 0.
	[ position y <= lines size ]
		whileTrue: [ "one indexing really throws this off."
			"position x == width ifTrue: [ Halt now ]."
			rem := position x rem: width.
			x := rem == 0
				ifTrue: [ width ]
				ifFalse: [ rem ].
			position := x@(position y).
			char := (lines at: position y) at: x.
			char == $#
				ifTrue: [ trees := trees + 1 ].
			position := position translateBy: stepRight @ stepDown ].
	^ trees
]

{ #category : #'as yet unclassified' }
TreeCounter >> stepDown: anInteger [
	stepDown := anInteger.
]

{ #category : #'as yet unclassified' }
TreeCounter >> stepRight: anInteger [ 
	stepRight := anInteger.
]
