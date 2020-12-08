Class {
	#name : #Day7Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #accessing }
Day7Test >> testPart1 [
<gtExample>
"AOCBagRuleParser new parse: 'muted chartreuse bags contain 3 dim silver bags, 1 dim chartreuse bag, 3 striped green bags, 3 dim magenta bags.'"
"we want to create a graph where there is an edge from node A -> node B if node A can fit inside node B. Then, to find the answer to Day 7, we need to do a BFS/DFS from 'shiny gold' to all the reachable nodes and then count the number of uniques."
"the number of items in the result set is the answer."
| rules graph |
	rules := '/home/nikhil/aoc2020/input7.txt' asFileReference readStream upToEnd lines collect: [:line | AOCBagRuleParser new parse: line].
graph := AOCBagRules new rulesToContainingAssocGraph: rules.
^ AOCBagRules new reachable: graph from: 'shiny gold'.


]

{ #category : #accessing }
Day7Test >> testPart2 [
<gtExample>
| rules graph |
	rules := '/home/nikhil/aoc2020/input7.txt' asFileReference readStream upToEnd lines collect: [:line | AOCBagRuleParser new parse: line].
graph := AOCBagRules new rulesToContainerAssocGraph: rules.
graph at: 'dim crimson'.
^ AOCBagRules new countRecursive:graph startingAt:'shiny gold'.
]
