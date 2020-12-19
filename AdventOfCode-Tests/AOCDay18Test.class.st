Class {
	#name : #AOCDay18Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
AOCDay18Test >> testPart1 [
	|parser input|
	parser := AOCMathParser new.
	input := '/home/nsmnikhil/AdventOfCode2020/input18.txt' asFileReference 
		readStream upToEnd lines.
	self assert: (input sum: [ :expr | parser parse: expr ]) equals: 21993583522852
]

{ #category : #tests }
AOCDay18Test >> testPart2 [
	|parser input|
	parser := AOCMathParser2 new.
	input := '/home/nsmnikhil/AdventOfCode2020/input18.txt' asFileReference 
		readStream upToEnd lines.
	self assert: (input sum: [ :expr | parser parse: expr ]) equals: 122438593522757
]

{ #category : #tests }
AOCDay18Test >> testSamplePart1 [
	|parser cases|
	parser := AOCMathParser new.
	cases := #(
		#('1 + (2 * 3) + (4 * (5 + 6))' 51)
		#('2 * 3 + (4 * 5)' 26)
		#('5 + (8 * 3 + 9 + 3 * 4 * 3)' 437)
		#('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))' 12240)
		#('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2' 13632)
	).
	cases do: [ :case |
		self assert: (parser parse: (case first)) equals: (case second).
	].
	
]

{ #category : #tests }
AOCDay18Test >> testSamplePart2 [
	|parser cases|
	parser := AOCMathParser2 new.
	cases := #(
		#('1 + (2 * 3) + (4 * (5 + 6))' 51)
		#('2 * 3 + (4 * 5)' 46)
		#('5 + (8 * 3 + 9 + 3 * 4 * 3)' 1445)
		#('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))' 669060)
		#('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2' 23340)
	).
	cases do: [ :case |
		self assert: (parser parse: (case first)) equals: (case second).
	].
	
]
