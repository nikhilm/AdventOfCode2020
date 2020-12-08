Class {
	#name : #'Day4_Test',
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
Day4_Test >> testBatch [
  | input results |
input := 'ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in'.
  results := AOCBatchValidator validate: input.
  self assert: (results count: [:e | e == true]) equals: 2.
]

{ #category : #tests }
Day4_Test >> testPassportInvalid [
	| passport |
	passport := 'hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in'.
   self assert: (AOCPassportValidator isValid: passport) equals: false.

   passport := 'iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929'.
   self assert: (AOCPassportValidator isValid: passport) equals: false.
]

{ #category : #tests }
Day4_Test >> testPassportValid [
	| passport |
	passport := 'ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm'.
   self assert: (AOCPassportValidator isValid: passport).

   passport := 'hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm'.
   self assert: (AOCPassportValidator isValid: passport).
]
