Class {
	#name : #AOCCrabCups,
	#superclass : #Object,
	#instVars : [
		'cups',
		'currentCup',
		'startMax',
		'labelToLinks'
	],
	#category : #AdventOfCode
}

{ #category : #'instance creation' }
AOCCrabCups class >> from: anArray [
	| max |
	max := anArray max.
	^ self new cups: (LinkedList withAll: anArray); startMax: max
]

{ #category : #'as yet unclassified' }
AOCCrabCups class >> millionFrom: anArray [
	|len startFrom seq |
	len := anArray size.
	startFrom := anArray max + 1.
	seq := OrderedCollection withAll: anArray.
	startFrom to: 1000000 do: [ :label | seq add: label ].
	^ self from: seq
]

{ #category : #converting }
AOCCrabCups >> asArray [ 
	^ cups asArray
]

{ #category : #'as yet unclassified' }
AOCCrabCups >> cups: aLinkedList [
	| destinationLabel |
	cups := aLinkedList.
	currentCup := cups firstLink.
	"create a mapping from a label to a link so we can quickly find the new destination link"
	labelToLinks := Array new: aLinkedList size.
	cups linksDo: [ :link |
		labelToLinks at: link value put: link ]
]

{ #category : #'as yet unclassified' }
AOCCrabCups >> labels [
	"find the link after label 1"
	| beginLink str |
	beginLink := nil.
	cups linksDo: [ :link | link value = 1 ifTrue: [ 
			beginLink := link nextLink.
			beginLink isNil ifTrue: [ beginLink := cups firstLink ].
		]
	].
	str := ''.
	[ beginLink value = 1 ] whileFalse: [ 
		str := str, beginLink value asString.
		beginLink := beginLink nextLink.
		beginLink isNil ifTrue: [ beginLink := cups firstLink ].
	].
	^ str
]

{ #category : #accessing }
AOCCrabCups >> move [
	| removedLabels destinationLabel destinationLink min max removed |
	"at this point our list  has all N (1 million) elements"
	"the other assumption we have is that labels are  strictly within 1..10e6"
	min := 1.
	"instead of paying the cost of iteration for size every time, we  pay it once."
	max := startMax.
	destinationLabel := currentCup value - 1.
	removedLabels := OrderedCollection new.
	3 timesRepeat: [ 
		removed := self removeNextCup.
		removedLabels add: removed.
		
		[ removedLabels includes: min ] whileTrue: [
			min := min + 1
		].
		[ removedLabels includes: max ] whileTrue: [
			max := max - 1
		].
		[ removedLabels includes: destinationLabel ] whileTrue: [
			destinationLabel := destinationLabel - 1.
		].
	].
	destinationLabel < min ifTrue: [ destinationLabel := max ].
	destinationLink := labelToLinks at: destinationLabel.
	removedLabels do: [ :label |
		destinationLink := cups add: label afterLink: destinationLink.
		"update the dictionary"
		labelToLinks at: label put: destinationLink.
	].
	currentCup := currentCup nextLink.
	currentCup isNil ifTrue: [ currentCup := cups firstLink ].
]

{ #category : #'as yet unclassified' }
AOCCrabCups >> removeNextCup [
	| oldLink |
	currentCup nextLink isNil ifTrue: [ ^ cups removeFirst ] ifFalse: [ 
		oldLink := currentCup nextLink.
		currentCup nextLink: (oldLink nextLink).
		oldLink nextLink: nil.
		^ oldLink value
	]
]

{ #category : #'as yet unclassified' }
AOCCrabCups >> startMax: anInteger [ 
	startMax := anInteger
]

{ #category : #'as yet unclassified' }
AOCCrabCups >> twoAfter1 [
	|beginLink answer |
	beginLink := nil.
	cups linksDo: [ :link | link value = 1 ifTrue: [ 
			beginLink := link nextLink.
			beginLink isNil ifTrue: [ beginLink := cups firstLink ].
		]
	].
	answer := OrderedCollection new.
	answer add: beginLink value.
	beginLink := beginLink nextLink.
	beginLink isNil ifTrue: [ beginLink := cups firstLink ].
	answer add: beginLink value.
	^ answer.
]
