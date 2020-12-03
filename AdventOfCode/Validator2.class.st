Class {
	#name : #Validator2,
	#superclass : #Object,
	#instVars : [
		'min',
		'max',
		'char',
		'one',
		'two'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
Validator2 class >> fromRule: aString [ 
	| tokens bounds |
	tokens := Character space split: aString.
	bounds := $- split: (tokens at: 1).
	^ self one: ((bounds at: 1) asInteger) two: ((bounds at: 2) asInteger ) char: ((tokens at: 2) at: 1 )
]

{ #category : #'as yet unclassified' }
Validator2 class >> one: aMin two: aMax char: aChar [ 
	| v |
	v := self new.
	v one: aMin;
	two: aMax;
	char: aChar.
	^ v
]

{ #category : #'as yet unclassified' }
Validator2 >> char: aChar [ 
	char := aChar.
]

{ #category : #'as yet unclassified' }
Validator2 >> isValid: aString [ 
	^ ((aString at: one) == char) xor: [ (aString at: two) == char ]
]

{ #category : #'as yet unclassified' }
Validator2 >> one: anInteger [ 
	one := anInteger.
]

{ #category : #'as yet unclassified' }
Validator2 >> two: anInteger [ 
	two := anInteger.
]
