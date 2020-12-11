Class {
	#name : #AOCJoltageCalculator,
	#superclass : #Object,
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCJoltageCalculator class >> countAdapterSequences: adapters [ 
  |reversed dict |
	reversed := adapters sort reversed.
	"add a 0 to tie to the lower end"
	reversed add: 0.
	dict := Dictionary new.
	Transcript clear.
	^ AOCJoltageCalculator countAdapterSequences: reversed start: 1 indent: '  ' memo: dict.
]

{ #category : #'as yet unclassified' }
AOCJoltageCalculator class >> countAdapterSequences: aCollection start: start indent: aIndent memo: aDict [
	| count nextIndex |
	count := 0.
	
	"last index in the collection, so we found a valid sequence"
	(start = aCollection size) ifTrue: [ ^ 1 ].
	"Transcript show: ('{1} start {2} item {3}' format: { aIndent . start . (aCollection at: start) }); cr."
	aDict at: start ifPresent: [ :v | ^ v ].
	
	nextIndex  := start + 1.
	(nextIndex <= aCollection size) ifTrue: [ 
		((aCollection at: start) - (aCollection at: nextIndex) <= 3) ifTrue: [ 
				"Transcript show: ('Trying {1} with index {2}' format: {(aCollection at: start) . nextIndex }); cr. "
				count := count + (self countAdapterSequences: aCollection start: nextIndex indent: (aIndent , '  ') memo: aDict)
		 ]
	 ].

	nextIndex := start + 2.
	(nextIndex <= aCollection size) ifTrue: [ 
		((aCollection at: start) - (aCollection at: nextIndex) <= 3) ifTrue: [ 
				"Transcript show: ('Trying {1} with index {2}' format: {(aCollection at: start) . nextIndex }); cr." 
				count := count + (self countAdapterSequences: aCollection start: nextIndex indent: (aIndent, '  ') memo: aDict)
		 ]
	 ].

	nextIndex := start + 3.
	(nextIndex <= aCollection size) ifTrue: [ 
		((aCollection at: start) - (aCollection at: nextIndex) <= 3) ifTrue: [ 
				"Transcript show: ('Trying {1} with index {2}' format: {(aCollection at: start) . nextIndex }); cr."
				count := count + (self countAdapterSequences: aCollection start: nextIndex indent: (aIndent, '  ') memo: aDict)
		 ]
	 ].

	"Transcript show: ('{1} end {2} item {3} count {4}' format: { aIndent . start . (aCollection at: start) . count }); cr."
	aDict at: start put: count.
	^ count
]

{ #category : #'as yet unclassified' }
AOCJoltageCalculator class >> determineAdapterSequence: adapters [ 
	|sorted current|
	sorted := adapters sort.
current := 0.
^ sorted select: [ :adapter | 
	((adapter - current) <= 3) ifTrue: [ current := adapter. true ] ifFalse: [ false ]
 ]
]

{ #category : #'as yet unclassified' }
AOCJoltageCalculator class >> differencesOf1And3: adapterSeq [ 
	|ones threes diff|
	ones := 0.
	threes := 0.
	"fold will get two elements at a time, and we use the difference to decide which one to increment"
	"then, the next time, the block will be called with the answer of the last one, and the next element"
	"so we will just answer with the second element so that the block is always called with 2 elements of the collection"
	adapterSeq fold: [ :first :second |
		diff := second - first.
		(diff = 1) ifTrue: [ ones := ones + 1 ].
		(diff = 3) ifTrue: [ threes := threes + 1 ].
		second
	 ].
	"one for the power outlet"
		diff := (adapterSeq first).
		(diff = 1) ifTrue: [ ones := ones + 1 ].
		(diff = 3) ifTrue: [ threes := threes + 1 ].
	"and our output is always plus 3."
	threes := threes + 1.
	
	^ { ones . threes }
]
