Class {
	#name : #AOCDay22Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
AOCDay22Test >> testPart1 [
	|combat winner|

	combat := AOCCrabCombat from: ('/home/nsmnikhil/AdventOfCode2020/input22.txt' asFileReference readStream upToEnd).
	winner := combat playToWin.
	self assert: winner score equals: 33010.
]

{ #category : #tests }
AOCDay22Test >> testPart2 [
	|combat winner|

	combat := AOCCrabCombat from: ('/home/nsmnikhil/AdventOfCode2020/input22.txt' asFileReference readStream upToEnd).
	winner := combat playToWinRecursiveStart.
	self assert: winner score equals: 32769.
]

{ #category : #tests }
AOCDay22Test >> testSamplePart1 [
	|combat winner |
	combat := AOCCrabCombat from: 'Player 1:
9
2
6
3
1', Character lf asString, Character lf asString, 'Player 2:
5
8
4
7
10'.
	winner := combat playToWin.
	self assert: winner score equals: 306.
]

{ #category : #tests }
AOCDay22Test >> testSamplePart2 [
	|combat winner |
	combat := AOCCrabCombat from: 'Player 1:
9
2
6
3
1', Character lf asString, Character lf asString, 'Player 2:
5
8
4
7
10'.
	winner := combat playToWinRecursiveStart.
	self assert: winner score equals: 291.
]
