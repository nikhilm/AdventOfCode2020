Class {
	#name : #AOCDay25Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
AOCDay25Test >> testPart1 [
	| cipher rounds |
	cipher := AOCDoorCipher new subject: 7.
	rounds := cipher roundsFor: 17607508.
	self assert: rounds equals: 15630689.
	self assert: (AOCDoorCipher new subject: 15065270; performRounds: rounds) equals: 12285001.
]

{ #category : #tests }
AOCDay25Test >> testSample1 [
	| cipher |
	cipher := AOCDoorCipher new subject: 7.
	self assert: (AOCDoorCipher new subject: 17807724; performRounds: 8) equals: 14897079.
	self assert: (cipher roundsFor: 5764801) equals: 8.
	self assert: (cipher roundsFor: 17807724) equals: 11.
]
