Class {
	#name : #AOCSatelliteRuleBuilder,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'choice',
		'ruleDescriptions',
		'sequence',
		'terminal',
		'ruleNumber',
		'ruleCache',
		'depth',
		'allowLoops'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder class >> fromRuleDescription: aDict [
	| inst |
	inst := self new ruleDescriptions: aDict.
	^ inst build
]

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder class >> fromRuleDescription: aDict allowLoops: allow [
	| inst |
	inst := self new ruleDescriptions: aDict; allowLoops: allow.
	^ inst build
]

{ #category : #accessing }
AOCSatelliteRuleBuilder class >> ignoredNames [
	| ext |
	ext := super ignoredNames asOrderedCollection .
	ext add: #ruleDescriptions; add: #ruleCache; add: #depth; add: #allowLoops.
	^ ext asArray.
]

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder >> allowLoops: aFalse [ 
	allowLoops := aFalse
]

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder >> build [
	"start parsing at rule 0"
	^ (self parserAt: 0) end.
]

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder >> choice [
	^ (sequence , #space asPParser optional, $| asPParser , #space asPParser optional , choice ==> [ :nodes | 
			(nodes first) / (nodes last)
		] ) / sequence
]

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder >> depth: anInteger [ 
	depth := anInteger
]

{ #category : #initialization }
AOCSatelliteRuleBuilder >> initialize [ 
	super initialize.
	ruleCache := Dictionary new. "icached pparser if navaialble"
	depth := 0.
	allowLoops := false.
]

{ #category : #accessing }
AOCSatelliteRuleBuilder >> parserAt: aNumber [
	| sub sub42 sub31 sub11 |
	^ ruleCache at: aNumber ifAbsentPut: [
		(aNumber = 8 and: [ allowLoops ]) ifTrue: [ 
			"for these 2 rules we are going to return custom parsers"
			(self parserAt: 42) plus
		] ifFalse: [ 
			(aNumber = 99999 and: [ allowLoops ]) ifTrue: [ 
				"first construct the base case of 42  31"
				
				sub42 := self parserAt: 42.
				sub31 := self parserAt: 31.		
				"now this is 42 11? 31"
				
				sub := self class new ruleDescriptions: ruleDescriptions ; ruleCache: ruleCache; depth: (depth + 1); allowLoops: allowLoops.
				(depth > 100) ifTrue: [ sub42 , sub31 ] ifFalse: [ sub42, (sub parserAt: 11) optional, sub31 ]
			]
			ifFalse: [
				sub := self class new ruleDescriptions: ruleDescriptions ; ruleCache: ruleCache; depth: (depth + 1); allowLoops: allowLoops.
				sub parse: ((ruleDescriptions at: aNumber) trim)
			]
		] 
	]
]

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder >> ruleCache: aCollection [ 
	ruleCache := aCollection
]

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder >> ruleDescriptions: aDict [
	ruleDescriptions := aDict
]

{ #category : #accessing }
AOCSatelliteRuleBuilder >> ruleNumber [
"this accepts a slightly larger rule set since it allows `terminals in the same line as a rule number..."
	^ (#digit asPParser plus token ==> [ :token | self parserAt: (token value asNumber) ]) / terminal
]

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder >> sequence [
	^ (ruleNumber, #space asPParser , sequence ==> [ :nodes |
			(nodes first) , (nodes last)
		]) / ruleNumber
]

{ #category : #accessing }
AOCSatelliteRuleBuilder >> start [
	^ choice .
]

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder >> terminal [
	^ $" asPParser, #any asPParser, $" asPParser ==> [ :nodes | nodes second asPParser ].
]
