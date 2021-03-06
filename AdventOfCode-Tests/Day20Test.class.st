Class {
	#name : #Day20Test,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
Day20Test >> testImageGeneration [
	|jigsaw expected |
	jigsaw := AOCJurassicJigsaw from: 'Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###...'.
	expected := Array2D rows: 3 columns: 3.
	expected atRow: 1 put: #(1951 2311 3079).
	expected atRow: 2 put: #(2729 1427 2473).
	expected atRow: 3 put: #(2971 1489 1171).
	"but it could also be reotated or flipped versions of these."
	self assert: (jigsaw assembleTiles) equals: expected.
	^ jigsaw
]

{ #category : #tests }
Day20Test >> testPart1 [
	|jigsaw corners |
	jigsaw := AOCJurassicJigsaw from: ('/home/nsmnikhil/AdventOfCode2020/input20.txt' asFileReference readStream upToEnd).
	corners := jigsaw corners.
	"self assert: corners equals: #() asSet."
	self assert: (corners inject: 1 into: [:x :y | x * y ]) equals: 29125888761511.
]

{ #category : #tests }
Day20Test >> testSamplePart1 [
	|jigsaw|
	jigsaw := AOCJurassicJigsaw from: 'Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###...'.
	self assert: (jigsaw corners) equals: #(1951 3079 2971 1171) asSet.
	^ jigsaw
]

{ #category : #tests }
Day20Test >> testTileBorderIDGeneration [
	"try this out"
	| jigsaw tilesToBorderIds |
	jigsaw := AOCJurassicJigsaw from: 'Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..'.
	tilesToBorderIds := jigsaw borderIds.
	self assert: (tilesToBorderIds at: 2311) equals: #(
		2r0011010010
		2r0100101100
		2r0001011001
		2r1001101000
		2r1110011100
		2r0011100111
		2r0100111110
		2r0111110010
	) asSet.
	self assert: (tilesToBorderIds at: 1951) equals: #(
		2r1011000110
		2r0110001101
		2r0111110010
		2r0100111110
		2r0010110001
		2r1000110100
		2r1001001011
		2r1101001001
	) asSet.
]
