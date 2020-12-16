Class {
	#name : #AOCTicketNotes,
	#superclass : #Object,
	#instVars : [
		'rules',
		'yourTicket',
		'nearbyTickets'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCTicketNotes >> nearbyTickets [
	^ nearbyTickets
]

{ #category : #'as yet unclassified' }
AOCTicketNotes >> rules [ 
	^ rules
]

{ #category : #'as yet unclassified' }
AOCTicketNotes >> rules: anAOCTicketRules yourTicket: aCollection nearbyTickets: aCollection3 [ 
	rules := anAOCTicketRules .
	yourTicket := aCollection.
	nearbyTickets := aCollection3.
]

{ #category : #'as yet unclassified' }
AOCTicketNotes >> yourTicket [
	^ yourTicket
]
