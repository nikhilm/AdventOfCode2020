Class {
	#name : #AOCDay11Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
AOCDay11Test >> testPart1 [
	|input state|
	input := '/home/nikhil/aoc2020/input11.txt' asFileReference readStream upToEnd lines.
	state := AOCSeatMap fromDescription: input.
	state := state settle.
	self assert: (state occupiedCount) equals: 2261.
	
]

{ #category : #tests }
AOCDay11Test >> testPart2 [
	|input state|
	input := '/home/nikhil/aoc2020/input11.txt' asFileReference readStream upToEnd lines.
	state := AOCSeatMap fromDescription: input.
	state := state settleByVisibility.
	self assert: (state occupiedCount) equals: 2039.
	
]

{ #category : #tests }
AOCDay11Test >> testSamplePart1 [
	|input state|
	input := 'L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL' lines.
	state := AOCSeatMap fromDescription: input.
	state := state settle.
	self assert: (state occupiedCount) equals: 37.
	
]

{ #category : #tests }
AOCDay11Test >> testSamplePart2 [
	|input state|
	input := 'L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL' lines.
	state := AOCSeatMap fromDescription: input.
	state := state settleByVisibility.
	self assert: (state occupiedCount) equals: 26.
	
]

{ #category : #tests }
AOCDay11Test >> testVisibility [
	|input state visible |
	input := '.......#.
...#.....
.#.......
.........
..#L....#
....#....
.........
#........
...#.....' lines.
	state := AOCSeatMap fromDescription: input.
	self assert: ((state visibleSeatsForRow: 5 Column: 4) count: [ :x | x = 2 ]) equals: 8.
	
	input := '.............
.L.L.#.#.#.#.
.............' lines.
	state := AOCSeatMap fromDescription: input.
	visible := state visibleSeatsForRow: 2 Column: 2.
	self assert: (visible count: [:x | x = 1]) equals: 1.
	self assert: (visible count: [:x | x = 2]) equals: 0.
]
