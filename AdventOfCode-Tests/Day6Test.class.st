Class {
	#name : #Day6Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
Day6Test >> testPart1 [
	"the solution is simple enough to not need new classes"

	| sets curSet input |
	sets := OrderedCollection new.
	curSet := Set new.
	input := '/home/nikhil/aoc2020/input6.txt' asFileReference readStream
		upToEnd.
	input
		linesDo: [ :line | 
			line isEmpty
				ifTrue: [ "finish current set"
					sets add: curSet.
					curSet := Set new ]
				ifFalse:
					[ "union set with set of this line." curSet := curSet | line asSet ] ].
	"deal with the last one if any"
	sets add: curSet.
	^ sets sum: [ :set | set size ]
]

{ #category : #tests }
Day6Test >> testPart2 [
	"the solution is simple enough to not need new classes"

	"since we are doing intersections, we can't start with an empty set. Instead use a-z."

	| sets curSet input |
	sets := OrderedCollection new.
	curSet := 'abcdefghijklmnopqrstuvwxyz' asSet.
	input := '/home/nikhil/aoc2020/input6.txt' asFileReference readStream
		upToEnd.
	input
		linesDo: [ :line | 
			line isEmpty
				ifTrue: [ "finish current set"
					sets add: curSet.
					curSet := 'abcdefghijklmnopqrstuvwxyz' asSet ]
				ifFalse:
					[ "intersection set with set of this line to find the common one." curSet := curSet & line asSet ] ].
	"deal with the last one if any"
	sets add: curSet.
	^ sets sum: [ :set | set size ]
]
