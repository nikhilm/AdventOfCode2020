Class {
	#name : #AOCPassportValidator,
	#superclass : #Object,
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCPassportValidator class >> entry: aString [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
AOCPassportValidator class >> isValid: aString [ 
	| tuples fields byr iyr eyr hgt hcl ecl pid ht |
	tuples := aString substrings collect: [ :field | field substrings: #($:) ].
	fields := (tuples collect: [ :tuple | Association new key: (tuple at: 1) value: (tuple at: 2) ] ) asDictionary.
	"Part 1"
	(#('byr' 'iyr' 'eyr' 'hgt' 'hcl' 'ecl' 'pid') allSatisfy: [ :key | fields includesKey: key ]) ifFalse: [ ^ false ].
	"Part 2 validations"
	byr := fields at: 'byr'.
	((byr asNumber >= 1920) and: (byr asNumber <= 2002)) ifFalse: [ ^ false ].
	
	iyr := fields at: 'iyr'.
	((iyr asNumber >= 2010) and: (iyr asNumber <= 2020)) ifFalse: [ ^ false ].
	
	eyr := fields at: 'eyr'.
	((eyr asNumber >= 2020) and: (eyr asNumber <= 2030)) ifFalse: [  ^ false ].
	
	hgt := fields at: 'hgt'.
	(hgt endsWith: 'cm') ifTrue: [ 
		ht := hgt copyFrom: 1 to: (hgt size - 2).
		ht := ht asNumber.
		((ht >= 150) and: (ht <= 193)) ifFalse: [  ^ false ].
	] ifFalse: [ 
		(hgt endsWith: 'in') ifTrue: [ 
			
		ht := hgt copyFrom: 1 to: (hgt size - 2).
		ht := ht asNumber.
		((ht >= 59) and: (ht <= 76)) ifFalse: [  ^ false ].
		 ] ifFalse: [ ^ false ]
	].
	
   hcl := fields at: 'hcl'.
   (hcl matchesRegex: '^#[0123456789abcdef]{6}$') ifFalse: [ ^ false ].

   ecl := fields at: 'ecl'.
	({'amb'. 'blu'. 'brn'. 'gry'. 'grn'. 'hzl'. 'oth'} includes: ecl) ifFalse: [ ^ false ].
	
   pid := fields at: 'pid'.
   ((pid size == 9) and: (pid isAllDigits)) ifFalse: [ ^ false ].

	 ^ true
]
