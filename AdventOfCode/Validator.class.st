Class {
	#name : #Validator,
	#superclass : #Object,
	#instVars : [
		'min',
		'max',
		'char'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
Validator class >> fromRule: aString [ 
	| tokens bounds |
	tokens := Character space split: aString.
	bounds := $- split: (tokens at: 1).
	^ self min: ((bounds at: 1) asInteger) max: ((bounds at: 2) asInteger ) char: ((tokens at: 2) at: 1 )
]

{ #category : #'as yet unclassified' }
Validator class >> min: aMin max: aMax char: aChar [ 
	| v |
	v := self new.
	v min: aMin;
	max: aMax;
	char: aChar.
	^ v
]

{ #category : #'as yet unclassified' }
Validator >> char: aChar [ 
	char := aChar.
]

{ #category : #'as yet unclassified' }
Validator >> isValid: aString [ 
	| found |
	found := aString count: [ :ch | 
		ch == char ].
	^ (found <= max) and: (found >= min)
]

{ #category : #'as yet unclassified' }
Validator >> max: aNum [ 
	max := aNum.
]

{ #category : #'as yet unclassified' }
Validator >> min: aNum [ 
	min := aNum.
]
