Class {
	#name : #AOCDay13Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
AOCDay13Test >> testPart1 [
	|ss|
	ss := AOCShuttleSearch fromInput: ('/home/nikhil/aoc2020/input13.txt' asFileReference readStream upToEnd).
	self assert: (ss part1Answer) equals: 296.
]

{ #category : #tests }
AOCDay13Test >> testPart2 [
	|ss|
	ss := AOCShuttleSearch fromInput: ('/home/nikhil/aoc2020/input13.txt' asFileReference readStream upToEnd).
	self assert: (ss part2Answer) equals: 296.
	"the answer is 535296695251210 btw from wolfram alpha"
]

{ #category : #tests }
AOCDay13Test >> testSamplePart1 [
	|ss|
	ss := AOCShuttleSearch fromInput: '939
7,13,x,x,59,x,31,19'.
	self assert: (ss part1Answer) equals: 295.
]

{ #category : #tests }
AOCDay13Test >> testSamplePart2 [
	|ss|
	ss := AOCShuttleSearch fromInput: '939
7,13,x,x,59,x,31,19'.
	self assert: (ss part2Answer) equals: 1068788.
]
