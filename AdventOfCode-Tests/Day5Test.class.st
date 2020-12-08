Class {
	#name : #Day5Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
Day5Test >> testBoardingPassToSeat [
	
	| seat |
	seat := AOCBoardingPassParser toSeat: 'FBFBBFFRLR'.
	self assert: (seat row) equals: 44.
	self assert: (seat column) equals: 5.
	self assert: (seat id) equals: 357.
	
	seat := AOCBoardingPassParser toSeat: 'BFFFBBFRRR'.
	self assert: (seat row) equals: 70.
	self assert: (seat column) equals: 7.
	self assert: (seat id) equals: 567.
	
	seat := AOCBoardingPassParser toSeat: 'FFFBBBFRRR'.
	self assert: (seat row) equals: 14.
	self assert: (seat column) equals: 7.
	self assert: (seat id) equals: 119.

	seat := AOCBoardingPassParser toSeat: 'BBFFBBFRLL'.
	self assert: (seat row) equals: 102.
	self assert: (seat column) equals: 4.
	self assert: (seat id) equals: 820.

]

{ #category : #tests }
Day5Test >> testPart1 [
	"Answers part 1"
	|input seats |
	input := '/home/nikhil/aoc2020/input5.txt' asFileReference readStream upToEnd.
	seats := input lines collect: [ :line | AOCBoardingPassParser toSeat: line ].
	^ (seats collect: [ :seat | seat id ]) max
]

{ #category : #tests }
Day5Test >> testPart2 [
	"Answers part 2"
	|input seats sorted prev|
	input := '/home/nikhil/aoc2020/input5.txt' asFileReference readStream upToEnd.
	seats := input lines collect: [ :line | AOCBoardingPassParser toSeat: line ].
	sorted := (seats collect: [ :seat | seat id ]) sort.
	"there are probably more succinct ways to express this in Pharo, but I don't know them."
	prev := sorted first.
	sorted allButFirst do: [ :id | (id - prev = 1) ifFalse: [ ^ prev + 1 ]. prev := id ]
]
