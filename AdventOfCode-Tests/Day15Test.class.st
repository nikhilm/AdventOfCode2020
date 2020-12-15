Class {
	#name : #Day15Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
Day15Test >> testPart1 [
	|game spoken|
	game := AOCMemoryGame seedWith: #(9 6 0 10 18 2 1).
	"we already recorded 7 turns, so 2020th -> 2013th"
	2013 timesRepeat: [ spoken := game turn. ].
	self assert: spoken equals: 1238.
]

{ #category : #tests }
Day15Test >> testPart2 [
	|game spoken seq want|
	self timeLimit: 8 minutes .
	seq := #(9 6 0 10 18 2 1).
	game := AOCMemoryGame seedWith: seq.
	want := 30000000.
	(want - seq size) timesRepeat: [ spoken := game turn. ].
	self assert: spoken equals: 3745954.
]

{ #category : #tests }
Day15Test >> testSamplePart1 [
	|game spoken|
	game := AOCMemoryGame seedWith: #(0 3 6).
	"we already recorded 3 turns, so 2020th -> 2017th"
	2017 timesRepeat: [ spoken := game turn. ].
	self assert: spoken equals: 436.
]

{ #category : #tests }
Day15Test >> testSamplePart2 [
	|game spoken seq want|
	self timeLimit: 5 minutes .
	seq := #(0 3 6).
	want := 30000000.
	game := AOCMemoryGame seedWith: seq.
	(want - seq size) timesRepeat: [ spoken := game turn. ].
	self assert: spoken equals: 175594.
]
