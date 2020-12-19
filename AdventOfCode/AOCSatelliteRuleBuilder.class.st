Class {
	#name : #AOCSatelliteRuleBuilder,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'choice',
		'ruleDescriptions',
		'sequence',
		'terminal',
		'ruleNumber',
		'ruleCache'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCSatelliteRuleBuilder class >> fromRuleDescription: aDict [
	| inst |
	inst := self new ruleDescriptions: aDict.
	^ inst build
]

{ #category : #accessing }
AOCSatelliteRuleBuilder class >> ignoredNames [
	| ext |
	ext := super ignoredNames asOrderedCollection .
	ext add: #ruleDescriptions; add: #ruleCache.
	^ ext asArray.
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

{ #category : #initialization }
AOCSatelliteRuleBuilder >> initialize [ 
	super initialize.
	ruleCache := Dictionary new. "icached pparser if navaialble"
]

{ #category : #accessing }
AOCSatelliteRuleBuilder >> parserAt: aNumber [
	| sub |
	^ ruleCache at: aNumber ifAbsentPut: [
		sub := self class new ruleDescriptions: ruleDescriptions ; ruleCache: ruleCache.
		sub parse: ((ruleDescriptions at: aNumber) trim) 
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
