Class {
	#name : #AOCDay23Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
AOCDay23Test >> testPart1 [
	|cups|
	cups := AOCCrabCups from: #(3 6 8 1 9 5 7 4 2).
	100 timesRepeat: [ cups move ].
	self assert: (cups labels) equals: '95648732'
]

{ #category : #tests }
AOCDay23Test >> testPart2 [
	|cups answer |
	self timeLimit: 2 minutes .
	cups := AOCCrabCups millionFrom: #(3 6 8 1 9 5 7 4 2).
	10000000 timesRepeat: [ cups move ].
	answer := cups twoAfter1.
	self assert: answer first equals: 712484.
	self assert: answer second equals: 270203.
]

{ #category : #tests }
AOCDay23Test >> testSamplePart1 [
	|cups|
	cups := AOCCrabCups from: #(3 8 9 1 2 5 4 6 7).
	cups move.
	self assert: (cups asArray) equals: #(3 2 8 9 1 5 4 6 7).
	cups move.
	self assert: (cups asArray) equals: #(3 2 5 4 6 7 8 9 1).
	cups move.
	self assert: (cups asArray) equals: #(3 4 6 7 2 5 8 9 1).
	cups move.
	self assert: (cups asArray) equals: #(4 6 7 9 1 3 2 5 8).
	96 timesRepeat: [ cups move ].
	self assert: (cups labels) equals: '67384529'
]

{ #category : #tests }
AOCDay23Test >> testSamplePart2 [
	|cups answer |
	self timeLimit: 2 minutes .
	cups := AOCCrabCups millionFrom: #(3 8 9 1 2 5 4 6 7).
	10000000 timesRepeat: [ cups move ].
	answer := cups twoAfter1.
	self assert: answer first equals: 934001.
	self assert: answer second equals: 159792.
]
