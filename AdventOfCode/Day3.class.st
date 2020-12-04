"
Day 3 part 1
"
Class {
	#name : #Day3,
	#superclass : #Object,
	#category : #AdventOfCode
}

{ #category : #running }
Day3 class >> run [
	"run against the fixed input"

	| tc |
	tc := TreeCounter stepRight: 3 stepDown: 1.
	^ tc
		count:
			'/home/nikhil/aoc2020/input3.txt' asFileReference readStream upToEnd trim
]

{ #category : #running }
Day3 class >> run1 [
	"run against the fixed input"

	| tc |
	tc := TreeCounter stepRight: 3 stepDown: 1.
	^ tc
		count:
			'/home/nikhil/aoc2020/input3.txt' asFileReference readStream upToEnd trim
]

{ #category : #'as yet unclassified' }
Day3 class >> run2 [
	"run against the fixed input"

	| tc moves input trees |
	moves := {(1 @ 1).
	(3 @ 1).
	(5 @ 1).
	(7 @ 1).
	(1 @ 2)}.
	input := '/home/nikhil/aoc2020/input3.txt' asFileReference readStream
		upToEnd trim.
	trees := moves
		collect: [ :move | 
			tc := TreeCounter stepRight: move x stepDown: move y.
			tc count: input ].
	^ trees inject: 1 into: [ :x :y | x * y ] 
]
