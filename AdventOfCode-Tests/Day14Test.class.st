Class {
	#name : #Day14Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
Day14Test >> testFloatingGeneration [
	|computer|
	computer := AOCDockingComputerModel2 new.
	self assert: (computer runMaskInstruction: 'mask = 00000000000000000000000000000000000X').
	self assert: ((computer allLocations: 42) asSet) equals: (#(42 43) asSet).
	self assert: (computer runMaskInstruction: 'mask = 000000000000000000000000000000X1001X').
	self assert: ((computer allLocations: 42) asSet) equals: (#(26 27 58 59) asSet).
]

{ #category : #tests }
Day14Test >> testPart1 [
	|computer|
	computer := AOCDockingComputer new.
	computer runProgram: ('/home/nikhil/aoc2020/input14.txt' asFileReference readStream upToEnd).
	self assert: (computer memory sum) equals: 17934269678453.
]

{ #category : #tests }
Day14Test >> testPart2 [
	|computer|
	computer := AOCDockingComputerModel2 new.
	computer runProgram: ('/home/nikhil/aoc2020/input14.txt' asFileReference readStream upToEnd).
	self assert: (computer memory sum) equals: 3440662844064.
]

{ #category : #tests }
Day14Test >> testSamplePart1 [
	|computer|
	computer := AOCDockingComputer new.
	computer runProgram: 'mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0'.
	self assert: (computer memory sum) equals: 165.
]

{ #category : #tests }
Day14Test >> testSamplePart2 [
	|computer|
	computer := AOCDockingComputerModel2 new.
	computer runProgram: 'mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1'.
	self assert: (computer memory sum) equals: 208.
]
