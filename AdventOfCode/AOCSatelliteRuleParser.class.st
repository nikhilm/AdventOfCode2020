Class {
	#name : #AOCSatelliteRuleParser,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#category : #AdventOfCode
}

{ #category : #parsing }
AOCSatelliteRuleParser >> parse: text [ 
	| dict colonIndex ruleNumber ruleDesc |
	dict := Dictionary new. "rule number (as Number) to a string description"
	text lines do: [ :line |
		colonIndex := line indexOf: $:.
		ruleNumber := (line copyFrom: 1 to: (colonIndex-1)) asNumber.
		ruleDesc := (line allButFirst: colonIndex) trim.
		dict at: ruleNumber put: ruleDesc.
	].
	^ AOCSatelliteRuleBuilder fromRuleDescription: dict
]
