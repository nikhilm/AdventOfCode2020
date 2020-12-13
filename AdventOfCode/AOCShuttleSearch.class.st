Class {
	#name : #AOCShuttleSearch,
	#superclass : #Object,
	#instVars : [
		'eta',
		'shuttles'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCShuttleSearch class >> fromInput: aString [ 
	| lines eta shuttles |
	lines := aString lines.
	eta := lines first asNumber.
	shuttles := (lines second splitOn: $,) collect: [:x |
		 [ x asNumber ] ifError: [ nil ]
	] . "we need to preserve nils (positions) and ordering for part 2."
	^ self new eta: eta shuttles: shuttles.
]

{ #category : #'as yet unclassified' }
AOCShuttleSearch >> eta: anInteger shuttles: aCollection [ 
	eta := anInteger.
	shuttles := aCollection.
]

{ #category : #'as yet unclassified' }
AOCShuttleSearch >> part1Answer [
	"for each shuttle, do integer division from eta, and then add itself to find out the nearest multiple after the eta."
	| preferredShuttle minWaitingTime arrivalTimeAfterEta waitingTime |
	preferredShuttle := nil.
	minWaitingTime := 2 ** 32 "just as a sort of max".
	shuttles select: [ :shuttle | shuttle isNotNil ] thenDo: [ :shuttle |
		arrivalTimeAfterEta := ((eta quo: shuttle) + 1) * shuttle.
		waitingTime := arrivalTimeAfterEta - eta.
		(waitingTime < minWaitingTime) ifTrue: [ 
			preferredShuttle := shuttle.
			minWaitingTime := waitingTime.
		]
	].
	self assert: (preferredShuttle isNotNil).
	^ minWaitingTime * preferredShuttle.
]

{ #category : #'as yet unclassified' }
AOCShuttleSearch >> part2Answer [
	"the time t should be a multiple of the first bus ID."
	"we go through the shuttles, keeping track of the minutes to change"
	
	"the requirement is:
	- t is a multiple of the first shuttle,
	- (t+1) is a multiple of the second shuttle,
	- (t+2) is a multiple of the third shuttle
	- (if 'x', then just go to the next one)
	- (t+4) is a multiple of the fourth shuttle.
	we have to find this t. brute forcing is probably not the way to go."
	"we rely on all inputs (shuttles) being primes (which they are for our input)"
	"looked on the AoC reddit. there is something called the chinese remainder theorem"
	"
	say we try to find a number x, such that
		x = 0 (mod shuttle1)
		x = 
	
	"
	
	"wolfram alpha for now"
	shuttles doWithIndex: [ :shuttle :i |
		shuttle isNotNil ifTrue: [ 
			Transcript show: ('(t+{1})%{2} = 0, ' format: { (i-1) . shuttle }).
		]
	]
]
