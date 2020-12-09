Class {
	#name : #AOCGameProgramPerturbator,
	#superclass : #Object,
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCGameProgramPerturbator >> executeWithPerturbations: instructions [
	| copied perturbStartingAt gc perturbIndex toPerturb opcode operand newIns |
	"runs the program aString. if it encounters an infinite loop, changes the first nop/jmp to jmp/nop and tries again. repeats until a terminating program is found.
	assumes that at least one perturbation will find a terminating program"
	perturbStartingAt := 1.
	copied := instructions copy.
	[ true ]
		whileTrue: [ 
			gc := AOCGameConsole new.
			"this is the terminating program"
			(gc executeNoRepeat: copied)
				ifTrue: [ ^ gc accumulator ].

			"otherwise we need to try another perturbation."
			copied := instructions copy.
			perturbIndex := (perturbStartingAt to: copied size - 1)
				detect: [ :i | 
					((copied at: i) beginsWith: 'nop')
						or: ((copied at: i) beginsWith: 'jmp') ].
			"perturb"
			toPerturb := copied at: perturbIndex.
			opcode := toPerturb substrings first.
			operand := toPerturb substrings last.
			newIns := opcode = 'nop'
				ifTrue: [ 'jmp ' , operand ]
				ifFalse: [ 'nop ' , operand ].
			copied at: perturbIndex put: newIns.

			"next time try perturbing something later in the stream."
			perturbStartingAt := perturbIndex + 1 ]
]
