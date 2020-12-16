Class {
	#name : #AOCTicketNotesParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'notes',
		'rules',
		'yourTicket',
		'nearbyTickets',
		'rule',
		'ruleName',
		'intervals',
		'interval',
		'number',
		'ticket',
		'tickets'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCTicketNotesParser >> interval [
	^ ( number, $- asPParser , number ) ==> [ :nodes | (nodes at: 1) to: (nodes at: 3) ]
]

{ #category : #'as yet unclassified' }
AOCTicketNotesParser >> intervals [
	^ (interval, ' or ' asPParser , interval) ==> [ :nodes | { nodes at: 1 . nodes at: 3 } ]
]

{ #category : #'as yet unclassified' }
AOCTicketNotesParser >> nearbyTickets [
	^ ('nearby tickets:' asPParser , #newline asPParser , tickets) ==> [  :nodes | nodes at: 3 ]
]

{ #category : #accessing }
AOCTicketNotesParser >> notes [
	"a notes is a rules, followed by a blank line, followed by a your ticket, another blank line and then nearby tickets"

	^ (rules , #newline asPParser , yourTicket , #newline asPParser
		, nearbyTickets)
		==> [ :nodes | 
			AOCTicketNotes new
				rules: (nodes at: 1)
				yourTicket: (nodes at: 3)
				nearbyTickets: (nodes at: 5) ]
]

{ #category : #'as yet unclassified' }
AOCTicketNotesParser >> number [
	^ (#digit asPParser plus flatten) ==> [ :x | x asNumber ]
]

{ #category : #accessing }
AOCTicketNotesParser >> rule [
	^ (ruleName , $: asPParser , #space asPParser , intervals
		, #newline asPParser)
		==> [ :nodes | Association key: (nodes at: 1) value: (nodes at: 4) ]
]

{ #category : #'as yet unclassified' }
AOCTicketNotesParser >> ruleName [
	^ (#letter asPParser / #space asPParser) plus flatten
]

{ #category : #'as yet unclassified' }
AOCTicketNotesParser >> rules [
	^ rule plus ==> [ :nodes | AOCTicketRules from: nodes ]
]

{ #category : #accessing }
AOCTicketNotesParser >> start [
	^ notes end.
]

{ #category : #'as yet unclassified' }
AOCTicketNotesParser >> ticket [
	| coll |
	^ (number, ($, asPParser , number) plus, #newline asPParser optional) ==> [ :nodes | 
			coll := OrderedCollection new.
			coll add: (nodes first).
			(nodes second) do: [ :node | coll add: (node second) ].
			coll
		 ]
]

{ #category : #'as yet unclassified' }
AOCTicketNotesParser >> tickets [
	^ ticket plus
]

{ #category : #'as yet unclassified' }
AOCTicketNotesParser >> yourTicket [
	^ ('your ticket:' asPParser, #newline asPParser, ticket) ==> [ :nodes | nodes at: 3 ]
]
