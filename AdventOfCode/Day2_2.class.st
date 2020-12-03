"
Day 2, part 2
"
Class {
	#name : #'Day2_2',
	#superclass : #Object,
	#category : #AdventOfCode
}

{ #category : #running }
Day2_2 class >> run [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| lines tokens v |
	lines := '/home/nikhil/aoc2020/input2' asFileReference readStream
		upToEnd lines.
	^ lines
		count: [ :line | 
			tokens := $: split: line.
			v := Validator2 fromRule: (tokens at: 1).
			v isValid: (tokens at: 2) trim ]
]
