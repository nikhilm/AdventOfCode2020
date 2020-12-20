Class {
	#name : #AOCDay19Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
AOCDay19Test >> testBasics [
	| parser cases |
	parser := AOCSatelliteRuleParser new parse: '0: "a"'.
	cases := 'a
bababa
abbbab
b
aaaabbb' lines.
	self assert: (cases collect: [:case | parser matches: case ]) equals: #(true false false false false).
	
	parser := AOCSatelliteRuleParser new parse: '1: "a"
2: "b"
0: 1 2'.
	cases := 'a
bababa
abbbab
ab
aaaabbb' lines.
	self assert: (cases collect: [:case | parser matches: case ]) equals: #(false false false true false).
	
	parser := AOCSatelliteRuleParser new parse: '1: "a"
2: "b"
0: 1 1 | 2 2'.
	cases := 'aa
bb
ab
baba' lines.
	self assert: (cases collect: [:case | parser matches: case ]) equals: #(true true false false).
]

{ #category : #tests }
AOCDay19Test >> testPart1 [
	| parser input splitIndex cases|
	"AOCRuleParser returns a parser cappable of cheecking the rules!"
  input := '/home/nsmnikhil/AdventOfCode2020/input19.txt' asFileReference readStream upToEnd.
	splitIndex := input findString: (Character lf asString, Character lf asString).
	parser := AOCSatelliteRuleParser new parse: (input first: splitIndex).
	cases := (input allButFirst: splitIndex + 1) lines.
	self assert: (cases count: [:case | parser matches: case ]) equals: 190
]

{ #category : #tests }
AOCDay19Test >> testSamplePart1 [
	| parser cases |
	"AOCRuleParser returns a parser cappable of cheecking the rules!"
	parser := AOCSatelliteRuleParser new parse: '0: 4 1 5
1: 2 3 | 3 2
2: 4 4 | 5 5
3: 4 5 | 5 4
4: "a"
5: "b"'.
	cases := 'ababbb
bababa
abbbab
aaabbb
aaaabbb' lines.
	self assert: (cases collect: [:case | parser matches: case ]) equals: #(true false true false false).
]

{ #category : #tests }
AOCDay19Test >> testSamplePart2 [
	|parser cases|
	parser := AOCSatelliteRuleParser new allowLoops: true; parse: '42: 9 14 | 10 1
9: 14 27 | 1 26
10: 23 14 | 28 1
1: "a"
11: 42 31 | 42 11 31
5: 1 14 | 15 1
19: 14 1 | 14 14
12: 24 14 | 19 1
16: 15 1 | 14 14
31: 14 17 | 1 13
6: 14 14 | 1 14
2: 1 24 | 14 4
0: 8 11
13: 14 3 | 1 12
15: 1 | 14
17: 14 2 | 1 7
23: 25 1 | 22 14
28: 16 1
4: 1 1
20: 14 14 | 1 15
3: 5 14 | 16 1
27: 1 6 | 14 18
14: "b"
21: 14 1 | 1 14
25: 1 1 | 1 14
22: 14 14
8: 42 | 42 8
26: 14 22 | 1 20
18: 15 15
7: 14 5 | 1 21
24: 14 1'.
	cases := 'abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
bbabbbbaabaabba
babbbbaabbbbbabbbbbbaabaaabaaa
aaabbbbbbaaaabaababaabababbabaaabbababababaaa
bbbbbbbaaaabbbbaaabbabaaa
bbbababbbbaaaaaaaabbababaaababaabab
ababaaaaaabaaab
ababaaaaabbbaba
baabbaaaabbaaaababbaababb
abbbbabbbbaaaababbbbbbaaaababb
aaaaabbaabaaaaababaa
aaaabbaaaabbaaa
aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
babaaabbbaaabaababbaabababaaab
aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba' lines.
	self assert: (cases count: [:case | parser matches: case ]) equals: 12
]

{ #category : #tests }
AOCDay19Test >> testSamplePart2NoSubst [
	|parser cases|
	parser := AOCSatelliteRuleParser new parse: '42: 9 14 | 10 1
9: 14 27 | 1 26
10: 23 14 | 28 1
1: "a"
11: 42 31
5: 1 14 | 15 1
19: 14 1 | 14 14
12: 24 14 | 19 1
16: 15 1 | 14 14
31: 14 17 | 1 13
6: 14 14 | 1 14
2: 1 24 | 14 4
0: 8 11
13: 14 3 | 1 12
15: 1 | 14
17: 14 2 | 1 7
23: 25 1 | 22 14
28: 16 1
4: 1 1
20: 14 14 | 1 15
3: 5 14 | 16 1
27: 1 6 | 14 18
14: "b"
21: 14 1 | 1 14
25: 1 1 | 1 14
22: 14 14
8: 42
26: 14 22 | 1 20
18: 15 15
7: 14 5 | 1 21
24: 14 1'.
	cases := 'abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
bbabbbbaabaabba
babbbbaabbbbbabbbbbbaabaaabaaa
aaabbbbbbaaaabaababaabababbabaaabbababababaaa
bbbbbbbaaaabbbbaaabbabaaa
bbbababbbbaaaaaaaabbababaaababaabab
ababaaaaaabaaab
ababaaaaabbbaba
baabbaaaabbaaaababbaababb
abbbbabbbbaaaababbbbbbaaaababb
aaaaabbaabaaaaababaa
aaaabbaaaabbaaa
aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
babaaabbbaaabaababbaabababaaab
aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba' lines.
	self assert: (cases count: [:case | parser matches: case ]) equals: 3
]
