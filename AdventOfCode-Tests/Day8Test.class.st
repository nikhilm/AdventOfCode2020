Class {
	#name : #Day8Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
Day8Test >> testPart1 [
	| input gc |
	input := '/home/nikhil/aoc2020/input8.txt' asFileReference readStream upToEnd lines.
	gc := AOCGameConsole new.
	gc executeNoRepeat: input.
	self assert: gc accumulator equals: 2025.
	^ gc accumulator
]

{ #category : #tests }
Day8Test >> testPart2 [
	| input gpp acc |
	input := '/home/nikhil/aoc2020/input8.txt' asFileReference readStream upToEnd lines.
	gpp := AOCGameProgramPerturbator new.
	acc := gpp executeWithPerturbations: input.
	self assert: acc equals: 2001.
	^ acc
]

{ #category : #tests }
Day8Test >> testSamplePart1 [
	|input gc|
	input := 'nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6' lines.
	gc := AOCGameConsole new.
	gc executeNoRepeat: input.
	self assert: (gc accumulator) equals: 5.
	^ gc accumulator
]

{ #category : #tests }
Day8Test >> testSamplePart2 [
	|input gpp acc|
	input := 'nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6' lines.
	gpp := AOCGameProgramPerturbator new.
	acc := gpp executeWithPerturbations: input.
	self assert: acc equals: 8.
	^ acc
]
