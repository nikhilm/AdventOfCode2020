Class {
	#name : #AOCDay16Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
AOCDay16Test >> testPart1 [
	|notes rules input|
	input := '/home/nsmnikhil/AdventOfCode2020/input16.txt' asFileReference readStream upToEnd.
	notes := AOCTicketNotesParser new parse: input.
	rules := notes rules.
	self assert: ((rules invalidFields: (notes nearbyTickets)) sum) equals: 27850.
	
]

{ #category : #tests }
AOCDay16Test >> testPart2 [
	|notes rules input validTickets fields fieldsStartingWithDeparture yourTicket yourFields answer |
	input := '/home/nsmnikhil/AdventOfCode2020/input16.txt' asFileReference readStream upToEnd.
	notes := AOCTicketNotesParser new parse: input.
	rules := notes rules.
	validTickets := rules selectValid: (notes nearbyTickets ).
	fields := rules determineFields: validTickets.
	fieldsStartingWithDeparture := OrderedCollection new.
	fields withIndexDo: [ :field :index | 
		(field beginsWith: 'departure') ifTrue: [ fieldsStartingWithDeparture add: index ]
	].
	yourTicket := notes yourTicket.
	yourFields := OrderedCollection new.
	fieldsStartingWithDeparture do: [ :index | yourFields add: (yourTicket at: index) ].
	answer := yourFields reduce: [ :a :b | a * b ].
	
self assert: answer equals: 491924517533.
]

{ #category : #tests }
AOCDay16Test >> testSamplePart1 [
	|notes rules|
	notes := AOCTicketNotesParser new parse: 'class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12'.
	rules := notes rules.
	self assert: ((rules invalidFields: (notes nearbyTickets)) sum) equals: 71.
	
]

{ #category : #tests }
AOCDay16Test >> testSamplePart2 [
	|notes rules validTickets fields |
	notes := AOCTicketNotesParser new parse: 'class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9'.
	rules := notes rules.
	validTickets := rules selectValid: (notes nearbyTickets ).
	"we need some kind of sequence returned where each entry is a string identifying the rule at that position"
	"then we can iterate over that, check if it starts with departure, and then pick that from our tickets."
	fields := rules determineFields: validTickets.
	self assert: fields equals: (#('row' 'class' 'seat') asOrderedCollection ).
]
