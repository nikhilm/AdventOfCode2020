Class {
	#name : #AOCDay12Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
AOCDay12Test >> testPart1 [
	|input ferry |
	input := '/home/nikhil/aoc2020/input12.txt' asFileReference readStream upToEnd lines.
	ferry := AOCFerry new.
	input do: [ :x | ferry move: x ].
	self assert: (ferry manhattanDistanceFromOrigin) equals: 1133.
]

{ #category : #tests }
AOCDay12Test >> testPart2 [
	|input ferry |
	input := '/home/nikhil/aoc2020/input12.txt' asFileReference readStream upToEnd lines.
	ferry := AOCFerry new.
	input do: [ :x | ferry moveUsingWaypoint: x ].
	self assert: (ferry manhattanDistanceFromOrigin) equals: 61053.
]

{ #category : #tests }
AOCDay12Test >> testSamplePart1 [
	|input ferry |
	input := 'F10
N3
F7
R90
F11' lines.
	ferry := AOCFerry new.
	input do: [ :x | ferry move: x ].
	self assert: (ferry manhattanDistanceFromOrigin) equals: 25.
]

{ #category : #tests }
AOCDay12Test >> testSamplePart2 [
	| input ferry |
	input := 'F10
N3
F7
R90
F11' lines.
	ferry := AOCFerry new.
	input do: [ :x | ferry moveUsingWaypoint: x ].
	self assert: ferry manhattanDistanceFromOrigin equals: 286
]
