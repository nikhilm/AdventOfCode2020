Class {
	#name : #'Day3_1Test',
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
Day3_1Test >> testTreeCount [
	| input tc treesHit |
	input := '
......##....#...#..#.#....#....
.......#...#..#..#....##.......
#.#...#........###.#.##..#.....
.......#.....##.#..##...##.##..' trim.
	tc := TreeCounter stepRight: 3 stepDown: 1.
	treesHit := tc count: input.
	self assert: treesHit equals: 1
]

{ #category : #tests }
Day3_1Test >> testTreeCountModulo [
	| input tc treesHit |
	input := '..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#' trim.
	tc := TreeCounter stepRight: 3 stepDown: 1.
	treesHit := tc count: input.
	self assert: treesHit equals: 7
]
