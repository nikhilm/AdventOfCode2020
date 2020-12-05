Class {
	#name : #AOCPlaneSeat,
	#superclass : #Object,
	#instVars : [
		'row',
		'column'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCPlaneSeat class >> row: anInteger column: anInteger2 [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
AOCPlaneSeat >> column [
	^ column
]

{ #category : #'as yet unclassified' }
AOCPlaneSeat >> id [
	^ (self row * 8) + (self column).
]

{ #category : #'as yet unclassified' }
AOCPlaneSeat >> row [
	^ row
]

{ #category : #'as yet unclassified' }
AOCPlaneSeat >> row: anInteger column: anInteger2 [ 
	row := anInteger.
	column := anInteger2.
]
