Class {
	#name : #AOCFerry,
	#superclass : #Object,
	#instVars : [
		'heading',
		'position',
		'waypoint'
	],
	#category : #AdventOfCode
}

{ #category : #initialization }
AOCFerry >> initialize [ 
	heading := 0. "right/east is 0 following smalltalk Point class convention. down/south is 90 and so on"
	position := 0@0.
	"way point starts at 10 east and 1 north"
	waypoint := 10@1.
]

{ #category : #'as yet unclassified' }
AOCFerry >> manhattanDistanceFromOrigin [
	^ (position x abs) + (position y abs)
]

{ #category : #'as yet unclassified' }
AOCFerry >> move: aString [
	| instructions opcode operand |
	instructions := Dictionary new.
	instructions at: $N put: [ :howMuch | position := position + (0@howMuch) ].
	instructions at: $S put: [ :howMuch | position := position + (0@(0-howMuch)) ].
	instructions at: $E put: [ :howMuch | position := position + (howMuch@0) ].
	instructions at: $W put: [ :howMuch | position := position + ((0-howMuch)@0) ].
	instructions at: $L put: [ :degrees | self rotate: (360-degrees) ].
	instructions at: $R put: [ :degrees | self rotate: degrees ].
	instructions at: $F put: [ :howMuch | self moveForward: howMuch ].
	
	opcode := aString first.
	operand := aString allButFirst asNumber.
	(instructions at: opcode) value: operand.
	^ self
]

{ #category : #'as yet unclassified' }
AOCFerry >> moveForward: howMuch [ 
	(heading = 0) ifTrue: [ position := position + (howMuch@0) ].
	(heading = 90) ifTrue: [ position := position + (0@(0-howMuch)) ].
	(heading = 180) ifTrue: [ position := position + ((0-howMuch)@0) ].
	(heading = 270) ifTrue: [ position := position + (0@howMuch) ].
]

{ #category : #'as yet unclassified' }
AOCFerry >> moveTowardWaypoint: howManyTimes [
	(1 to: howManyTimes) do: [ :ignore |
		position := position + waypoint
	]
]

{ #category : #'as yet unclassified' }
AOCFerry >> moveUsingWaypoint: aString [ 
	| instructions opcode operand |
	instructions := Dictionary new.
	instructions at: $N put: [ :howMuch | waypoint := waypoint + (0@howMuch) ].
	instructions at: $S put: [ :howMuch | waypoint := waypoint + (0@(0-howMuch)) ].
	instructions at: $E put: [ :howMuch | waypoint := waypoint + (howMuch@0) ].
	instructions at: $W put: [ :howMuch | waypoint := waypoint + ((0-howMuch)@0) ].
	instructions at: $L put: [ :degrees | self rotateWaypoint: (360-degrees) ].
	instructions at: $R put: [ :degrees | self rotateWaypoint: degrees ].
	instructions at: $F put: [ :howManyTimes | self moveTowardWaypoint: howManyTimes ].
	
	opcode := aString first.
	operand := aString allButFirst asNumber.
	(instructions at: opcode) value: operand.
	^ self
]

{ #category : #'as yet unclassified' }
AOCFerry >> rotate: degrees [ 
	heading := (heading + degrees) rem: 360.
]

{ #category : #'as yet unclassified' }
AOCFerry >> rotateWaypoint: degrees [ 
	"in the question, degrees rotate right by that much.
	Smalltalk's Point's leftRotated does what the AoC instructions mean in increments of 90"
	self assert: (degrees between: 0 and: 360).
	self assert: (degrees rem: 90) equals: 0.
	(degrees / 90) timesRepeat: [ waypoint := waypoint leftRotated ]
]
