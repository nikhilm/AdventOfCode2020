Class {
	#name : #AOCGameConsole,
	#superclass : #Object,
	#instVars : [
		'accumulator',
		'ip'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCGameConsole >> acc: anInteger [ 
	accumulator := accumulator + anInteger.
]

{ #category : #'as yet unclassified' }
AOCGameConsole >> accumulator [
	^ accumulator
]

{ #category : #'as yet unclassified' }
AOCGameConsole >> execute: aString with: anInteger [ 
	(self operations at: aString) value: anInteger.
]

{ #category : #'as yet unclassified' }
AOCGameConsole >> executeNoRepeat: instructions [ 
   "returns true if exited with no duplicates being hit.
	returns false if a duplicate was hit."
	| executed ins |
	executed := Set new.
	[ true ] whileTrue: [ 
		(executed includes: self ip) ifTrue: [ ^ false ].
		"retire the instruction"
		executed add: self ip.
		[ ins := instructions at: self ip ] on: SubscriptOutOfBounds do: [ ^ true ].
		self ip: (self ip + 1).
		self executeOne: ins.
	].
^ true.
]

{ #category : #'as yet unclassified' }
AOCGameConsole >> executeOne: anInstruction [ 
	| words opcode operand |
	words := anInstruction substrings.
	opcode := words first.
	operand := words second.
	"sigh! pharo doesn't allow leading + when parsing numbers."
	(operand first = $+) ifTrue: [ operand := operand allButFirst  ].
	operand := operand asNumber.
	self execute: opcode with: operand.
	
	
]

{ #category : #initialization }
AOCGameConsole >> initialize [
	accumulator := 0.
	ip := 1.
]

{ #category : #'as yet unclassified' }
AOCGameConsole >> ip [
	^ ip
]

{ #category : #'as yet unclassified' }
AOCGameConsole >> ip: anInteger [ 
	ip := anInteger
]

{ #category : #'as yet unclassified' }
AOCGameConsole >> jmp: anInteger [ 
	ip := ip + anInteger - 1.
]

{ #category : #'as yet unclassified' }
AOCGameConsole >> operations [
	|d|
	d := Dictionary new.
	d at: 'acc' put: [ :n | self acc: n ].
	d at: 'nop' put: [ :n |  ].
	d at: 'jmp' put: [ :n | self jmp: n ].
	^ d
]
