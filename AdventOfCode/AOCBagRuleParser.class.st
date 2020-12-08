Class {
	#name : #AOCBagRuleParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'bagRule',
		'container',
		'contents',
		'color',
		'word',
		'empty',
		'someContents',
		'aContent',
		'moreContents'
	],
	#category : #AdventOfCode
}

{ #category : #accessing }
AOCBagRuleParser >> aContent [
	^ (#digit asPParser plus flatten ==> [ :num | num asNumber]), #space asPParser, color, #space asPParser, (('bags' asPParser) / ('bag' asPParser)) ==> [ :nodes | { nodes first . nodes at: 3 }]
]

{ #category : #accessing }
AOCBagRuleParser >> bagRule [
	^ (container, #space asPParser, 'contain' asPParser, #space asPParser, contents, $. asPParser) ==> [:nodes | { nodes first . nodes at: 5 }]
]

{ #category : #accessing }
AOCBagRuleParser >> color [
	^ (word , #space asPParser, word) flatten
]

{ #category : #accessing }
AOCBagRuleParser >> container [
	^ (color, #space asPParser, 'bags' asPParser) ==> [ :nodes | nodes first ]
]

{ #category : #accessing }
AOCBagRuleParser >> contents [
	^ empty / someContents 
]

{ #category : #accessing }
AOCBagRuleParser >> empty [
	^ 'no other bags' asPParser ==> [ :x | OrderedCollection new.]
]

{ #category : #accessing }
AOCBagRuleParser >> moreContents [
	^ ($, asPParser, #space asPParser, aContent) star ==> [ :nodes | nodes collect: [ :node | node at: 3 ] ]
]

{ #category : #accessing }
AOCBagRuleParser >> someContents [
    "put aContent into moreContents to get a nice list."
	| l |
	^ (aContent, moreContents) ==> [ :nodes | l := nodes second. l add: (nodes first). l.]
]

{ #category : #accessing }
AOCBagRuleParser >> start [
	^ bagRule end.
]

{ #category : #accessing }
AOCBagRuleParser >> word [
	^ #letter asPParser star
]
