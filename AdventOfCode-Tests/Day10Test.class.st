Class {
	#name : #Day10Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
Day10Test >> testPart1 [
	| adapters adapterSeq diffs |
	adapters := '/home/nikhil/aoc2020/input10.txt' asFileReference readStream upToEnd lines collect: [ :x | x asNumber ].
	adapterSeq := AOCJoltageCalculator determineAdapterSequence: adapters.
	diffs := AOCJoltageCalculator differencesOf1And3: adapterSeq.
	^ (diffs first) * (diffs second)
	
]

{ #category : #tests }
Day10Test >> testPart2 [
	| adapters |
	"made trivial by a dict"
	adapters := ('/home/nikhil/aoc2020/input10.txt' asFileReference readStream upToEnd lines collect: [ :x | x asNumber ]) asOrderedCollection  .
	self assert: (AOCJoltageCalculator countAdapterSequences: adapters) equals: 1973822685184.

]

{ #category : #tests }
Day10Test >> testSample2Part1 [
	| adapters adapterSeq diffs |
	adapters := '28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3' lines collect: [ :x | x asNumber ].
	adapterSeq := AOCJoltageCalculator determineAdapterSequence: adapters.
	diffs := AOCJoltageCalculator differencesOf1And3: adapterSeq.
	self assert: diffs first equals: 22.
	self assert: diffs second equals: 10.
	
]

{ #category : #tests }
Day10Test >> testSample2Part2 [
|adapters|
adapters := ('28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3' lines collect: [ :x | x asNumber ]) asOrderedCollection  .
	self assert: (AOCJoltageCalculator countAdapterSequences: adapters) equals: 19208.
	
]

{ #category : #tests }
Day10Test >> testSamplePart1 [
	| adapters adapterSeq diffs |
	adapters := '16
10
15
5
1
11
7
19
6
12
4' lines collect: [ :x | x asNumber ].
	adapterSeq := AOCJoltageCalculator determineAdapterSequence: adapters.
	self assert: adapterSeq equals: #(1 4 5 6 7 10 11 12 15 16 19).
	diffs := AOCJoltageCalculator differencesOf1And3: adapterSeq.
	self assert: diffs first equals: 7.
	self assert: diffs second equals: 5.
	
]

{ #category : #tests }
Day10Test >> testSamplePart2 [
	| adapters |
	adapters := ('16
10
15
5
1
11
7
19
6
12
4' lines collect: [ :x | x asNumber ]) asOrderedCollection  .
	self assert: (AOCJoltageCalculator countAdapterSequences: adapters) equals: 8.
	
]

{ #category : #tests }
Day10Test >> testSampleSimplePart2 [
	| adapters |
	adapters := ('3
2
1' lines collect: [ :x | x asNumber ]) asOrderedCollection  .
	self assert: (AOCJoltageCalculator countAdapterSequences: adapters) equals: 4.
	
]
