Class {
	#name : #Day9Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
Day9Test >> testPart1 [
	|input xmas nc |
	input := '/home/nikhil/aoc2020/input9.txt' asFileReference readStream upToEnd lines collect: [ :x | x asNumber ].
	xmas := AOCXMAS new preambleLength: 25 stream: input.
	nc := xmas firstNonCompliant .
	self assert: nc equals: 70639851.
]

{ #category : #tests }
Day9Test >> testPart2 [
	|input xmas nc range ans |
	input := '/home/nikhil/aoc2020/input9.txt' asFileReference readStream upToEnd lines collect: [ :x | x asNumber ].
	xmas := AOCXMAS new preambleLength: 25 stream: input.
	nc := xmas firstNonCompliant .
	self assert: nc equals: 70639851.
	
	range := xmas sequenceThatSumsTo: nc.
	ans := (range max) + (range min).
	self assert: ans equals: 8249240.
	^ ans
]

{ #category : #tests }
Day9Test >> testSamplePart1 [
	|input xmas|
	input := '35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576' lines collect: [ :x | x asNumber ].
	xmas := AOCXMAS new preambleLength: 5 stream: input.
	self assert: (xmas firstNonCompliant) equals: 127.
]

{ #category : #tests }
Day9Test >> testSamplePart2 [
	|input xmas nc range ans |
	input := '35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576' lines collect: [ :x | x asNumber ].
	xmas := AOCXMAS new preambleLength: 5 stream: input.
	nc := xmas firstNonCompliant .
	self assert: nc equals: 127.
	range := xmas sequenceThatSumsTo: nc.
	self assert: range equals: #(15 25 47 40).
	ans := (range max) + (range min).
	self assert: ans equals: 62.
	^ ans
]
