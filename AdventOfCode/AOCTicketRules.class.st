Class {
	#name : #AOCTicketRules,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCTicketRules class >> from: aCollectionOfAssoc [
	^ AOCTicketRules new rules: aCollectionOfAssoc
]

{ #category : #'as yet unclassified' }
AOCTicketRules >> determineFields: validTickets [
	"ok, for every 'column' (field) in every ticket, find the rule that all of them satisfy. then that is the one. this is probably not a complete solution, but I suspect it will work for the input."

	| answer fieldsAtIndex rulesCopy satisfyingRules potential pos toRemove |
	rulesCopy := rules copy.
	answer := OrderedCollection new: (validTickets first size) withAll: nil.
	potential := OrderedCollection new.

					1 to: validTickets first size do: [ :fieldIndex | 
						fieldsAtIndex := validTickets
							collect: [ :ticket | ticket at: fieldIndex ].
							
								satisfyingRules := rulesCopy associations select: [ :ruleToCheck |
									(fieldsAtIndex allSatisfy: [ :field | (ruleToCheck value) anySatisfy: [ :interval | interval rangeIncludes: field ] ])
								].
							potential add: (satisfyingRules collect: [ :assoc | assoc key ] as: Set).
					].
		[ answer anySatisfy: [ :x | x isNil ] ] whileTrue: [ 
			pos := nil.
			potential withIndexDo: [ :set :index |
				(set size = 1) ifTrue: [
						pos := index.
					]
				 ].
			self assert: (pos isNotNil).
			toRemove := (potential at: pos) atRandom .
			answer at: pos put: toRemove.
			potential do: [ :set | set remove: toRemove ifAbsent: [  ] ]
		].
	
	^ answer.
]

{ #category : #'as yet unclassified' }
AOCTicketRules >> invalidFields: aCollectionOfTickets [
	"go through each ticket, returning a flattened sequence of numbers (fields) that are invalid for all field rules"

	| answer |
	answer := OrderedCollection new.
	aCollectionOfTickets
		do: [ :ticket | 
			"a ticket is a list of numbers"
			ticket
				do: [ :field | 
					"if the field fails all rules, add it to the answer."
					(rules
						select: [ :intervals | 
							"this block answers true if the field is in any of the intervals."
							intervals
								anySatisfy: [ :interval | interval rangeIncludes: field ].
						]) ifEmpty: [ answer add: field ]
					]
				].
	^ answer
]

{ #category : #'as yet unclassified' }
AOCTicketRules >> rules: aCollectionOfAssoc [
	rules := Dictionary new.
	aCollectionOfAssoc do: [ :assoc | rules add: assoc ].
]

{ #category : #'as yet unclassified' }
AOCTicketRules >> selectValid: aCollectionOfTickets [
	"return a sequence of valid tickets."
	^ aCollectionOfTickets
		select: [ :ticket | 
			"a ticket is a list of numbers"
			"if all fields match at least one rule, add the ticket to the answer"
			ticket
				allSatisfy: [ :field | 
					(rules
						select: [ :intervals | 
							"this block answers true if the field is in any of the intervals."
							intervals
								anySatisfy: [ :interval | interval rangeIncludes: field ].
						]) isNotEmpty "this returns true if the field matched at least one rule."
					]
				]
]
