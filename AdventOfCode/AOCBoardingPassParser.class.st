Class {
	#name : #AOCBoardingPassParser,
	#superclass : #Object,
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCBoardingPassParser class >> toSeat: aString [ 
	|interval s x row column |
	s := aString.
	interval := Interval from: 0 to: 127.
	7 timesRepeat: [ 
		interval := (s first = $F) ifTrue: [
			Interval from: (interval first) to: (interval at: (interval size / 2))
		] ifFalse: [ 
			Interval from: (interval at: (interval size / 2 + 1)) to: (interval last)
		].
		s := s allButFirst .
   ].
   row := interval first.

	interval := Interval from: 0 to: 7.
	3 timesRepeat: [ 
		interval := (s first = $L) ifTrue: [
			Interval from: (interval first) to: (interval at: (interval size / 2))
		] ifFalse: [ 
			Interval from: (interval at: (interval size / 2 + 1)) to: (interval last)
		].
		s := s allButFirst .
   ].
   column := interval first.
	^ AOCPlaneSeat new row: row column: column
   
]
