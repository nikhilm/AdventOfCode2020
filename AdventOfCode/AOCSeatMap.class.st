Class {
	#name : #AOCSeatMap,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCSeatMap class >> fromDescription: aCollectionOfStrings [
	|state row translate |
	"Creates a representation of a seatmap from a set of strings.
	'.' represents a floor. 'L' represents an empty seat. '#' is an occupied seat.
	Each string should have the same length! This is not verified."
	
	"0 -> floor, 1 -> empty, 2 -> occupied"
	translate := Dictionary new.
	translate at: $. put: 0.
	translate at: $L put: 1.
	translate at: $# put: 2.
	state := Array2D rows:(aCollectionOfStrings size) columns: (aCollectionOfStrings first size).
	row := 0.
	aCollectionOfStrings do: [ :aString |
		state atRow: (row := row + 1) put: (aString collect: [:x |
			translate at: x
		] as:OrderedCollection )
	 ].
	^ AOCSeatMap new state: state
]

{ #category : #comparing }
AOCSeatMap >> = aOther [
	^ (self state) = (aOther state)
]

{ #category : #'as yet unclassified' }
AOCSeatMap >> firstVisibleSeatAtRow: aRow column: aColumn direction: aDirection [
	"move right away so we don't consider the current seat itself"
	| row col considering |
	row := aRow + (aDirection first).
	col := aColumn + (aDirection second).
	[ true ] whileTrue: [ 
		considering := self state at:row at:col ifInvalid:nil.
		"we ran out of things to see"
		considering ifNil: [ ^ nil ].
		"found a seat"
		(considering = 1 or: [ considering = 2]) ifTrue: [ ^ considering ].
		
		"this is a floor, keep looking."
		row := row + (aDirection first).
		col := col + (aDirection second).
	]
]

{ #category : #comparing }
AOCSeatMap >> hash [
	^ self state hash
]

{ #category : #'as yet unclassified' }
AOCSeatMap >> neighborsForRow: aRow Column: aColumn [ 
	"answer a collection of adjacent neighbors. Upto 8 element collection"
	^ (
	#(#(-1 -1) #(-1 0) #(-1 1)
	  #(0 -1)          #(0 1)
	  #(1 -1)  #(1 0)  #(1 1)) collect: [ :offset |
		 self state at: (aRow + offset first) at: (aColumn + offset second) ifInvalid: nil "treat invalid as nil then filter".
	]) select: [ :x | x isNotNil ]
]

{ #category : #'as yet unclassified' }
AOCSeatMap >> occupiedCount [
	"answers the number of occupied seats in the current map"
	^ self state count: [ :seat | seat = 2 ]
]

{ #category : #'as yet unclassified' }
AOCSeatMap >> settle [
	|next counter current|
	"steps this state until the state no longer changes.
	Answers the settled state."
	current := self.
	next := current step.
	"cap at a million just to be safe, particularly while iterating."
	counter := 1.
	[ next = current ] whileFalse: [ 
		current := next.
		next := next step.
		counter := counter + 1.
		(counter >= 1000000) ifTrue: [ ^ nil ]
	 ].
	^ next
]

{ #category : #'as yet unclassified' }
AOCSeatMap >> settleByVisibility [
	|next counter current|
	"steps this state until the state no longer changes.
	Answers the settled state."
	current := self.
	next := current stepByVisibility.
	"cap at a million just to be safe, particularly while iterating."
	counter := 1.
	[ next = current ] whileFalse: [ 
		current := next.
		next := next stepByVisibility.
		counter := counter + 1.
		(counter >= 1000000) ifTrue: [ ^ nil ]
	 ].
	^ next
]

{ #category : #'as yet unclassified' }
AOCSeatMap >> state [
	^ state
]

{ #category : #'as yet unclassified' }
AOCSeatMap >> state: aCollection [ 
	state := aCollection.
]

{ #category : #'as yet unclassified' }
AOCSeatMap >> step [
	"answers a new AOCSeatMap after applying the rules."

	| newState seat neighbors newSeat |
	newState := Array2D
		rows: self state numberOfRows
		columns: self state numberOfColumns.
	self state
		indicesDo: [ :row :column | 
			seat := self state at: row at: column.
			newSeat := nil.
			newSeat := seat = 0
				ifTrue: [ "floors do not change" 0 ]
				ifFalse: [ neighbors := self neighborsForRow: row Column: column.
					"if a seat is empty, and there are no occupied seats adjacent to it, it becomes occupied"
					(seat = 1 and: [ (neighbors count: [ :n | n = 2 ]) = 0 ])
						ifTrue: [ 2 ]
						ifFalse:
							[ "seat is occupied and four or more seats adjacent to it are also occupied, the seat becomes empty"
							(neighbors count: [ :n | n = 2 ]) >= 4
								ifTrue: [ 1 ]
								ifFalse: [ "otherwise the seat's state does not change" seat ] ] ].
			self assert: [ newSeat isNotNil ].
			newState at: row at: column put: newSeat ].
	^ self class new state: newState
]

{ #category : #stepping }
AOCSeatMap >> stepByVisibility [
	"answers a new AOCSeatMap after applying the rules."

	| newState seat visibleSeats newSeat |
	newState := Array2D
		rows: self state numberOfRows
		columns: self state numberOfColumns.
	self state
		indicesDo: [ :row :column | 
			seat := self state at: row at: column.
			newSeat := nil.
			newSeat := seat = 0
				ifTrue: [ "floors do not change" 0 ]
				ifFalse: [ visibleSeats := self visibleSeatsForRow: row Column: column.
					"if a seat is empty, and there are no occupied seats it can see, it becomes occupied"
					(seat = 1 and: [ (visibleSeats count: [ :n | n = 2 ]) = 0 ])
						ifTrue: [ 2 ]
						ifFalse:
							[ "seat is occupied and can see five or more visible occupied seats, the seat becomes empty"
							(visibleSeats count: [ :n | n = 2 ]) >= 5
								ifTrue: [ 1 ]
								ifFalse: [ "otherwise the seat's state does not change" seat ] ] ].
			self assert: [ newSeat isNotNil ].
			newState at: row at: column put: newSeat ].
	^ self class new state: newState
]

{ #category : #querying }
AOCSeatMap >> visibleSeatsForRow: aRow Column: aColumn [
	"answer a collection of visible seats."
	|deltas|
	deltas := 
	#(#(-1 -1) #(-1 0) #(-1 1)
	  #(0 -1)          #(0 1)
	  #(1 -1)  #(1 0)  #(1 1)).
	
	"for each direction, we want to keep moving in that direction until we hit the edge and find the first non-floor thing, at which point we stop"
	^ (deltas collect: [ :offset | self firstVisibleSeatAtRow: aRow column: aColumn direction: offset ]) select: [ :x | x isNotNil ].
]
