"
Here is the general idea this implements (still validating if it actually works).

## This is for part 1

We assume that there is a unique orientation of tiles that forms the complete image.
Next, a corner tile shares edges with 2 tiles, an edge tile with 3 tiles, an interior tile with 4 tiles.

Any number of rotations and flips will cause a border to only take on the original orientation or a flipped orientation. We identify a border with a unique binary number (. is 0, # is 1). This means a border like '.##...#' has the number { 0110001, 1000110 }. This means each tile has 8 possible border numbers. 

To check if tiles t1 and t2 share _an_ edge, we take a set intersection and if it is non-empty, they can be put next to each other. The uniqueness thing requires that they _have_ to share this edge. We could NC2 of these operations to see how many tiles each tile shares at least an edge with. Then we would end up with exactly 4 tiles which share edges with exactly 2 tiles. This is O(N*N) (right?).

There exists a potential optimization. First, create a map from Border ID -> [ list of tile IDs that have this Border ID as one of the Borders ]. This is O(N), because there are a fixed number of calculations per tile. Now, the max length of any of these lists is 2 because we assume uniqueness, and any tile shows up in 8 of these mappings. Any way, we now go through each of these lists. For example, say tile t1 has border IDs { a, b, c, d, a', b', c', d' } and t2 has border IDs { a, ...  } such that only 'a' is common. Similarly t3 has Border IDs { b, ...}. Say t1 _is_ a corner tile, such that c and d are not shared. Note that when a tile shares a with another tile, it by definition shares a', because we have to flip the entire ""picture"" over.""

then the mapping has a -> { t1, t2 }, b -> { t1, t3 }, c -> { t1 }, d -> { t1 }, a' -> { t1, t2 }, b' -> { t1, t3 }, c' { t1 }, d' -> { t1 }. Now we go through these lists. Create another mapping where the key is the tile ID and the values are the Border IDs where that tile was the _only_ entry in the list. So for a -> { t1, t2 } nothing is done. Same for b. For c, we create an entry from t1 -> { c } and then for d we add to it, so t1 -> { c, d, c', d' }. Conceptually, this is the list of tile IDs with the Border IDs they DO NOT SHARE with any other tiles. For interior tiles, this will have 0 entries. For edge tiles, this will be length 2, and for corner tiles these will be 4. So we find the ones with 4 items. There should be exactly 4 of these. Multiply them.
"
Class {
	#name : #AOCJurassicJigsaw,
	#superclass : #Object,
	#instVars : [
		'tileDescriptions'
	],
	#category : #AdventOfCode
}

{ #category : #'as yet unclassified' }
AOCJurassicJigsaw class >> from: aString [ 
	"does some basic parsing to create an instance with a dict from tile ID to the tile itself"
	| tileDescriptions lines currentTileId currentTile beginningOfTile rowNum |
	tileDescriptions := Dictionary new.
	"itilee entries are separated by blank lines"
	lines := aString lines.
	"add a blank line so that the final tile is added to the dictionary"
	(lines last isEmpty) ifFalse: [ 
		lines := lines asOrderedCollection. lines add: ''. ].
	"assumption: tiles are square, and they all have the same dimensions"
	"use to discriminate looking for the 'Tile XXXX:' form."
	beginningOfTile := true.
	rowNum := 1.
	lines do: [ :line |
		line isEmpty ifTrue: [ 
			"add the current tile to the dictionary"
			tileDescriptions at: currentTileId put: currentTile.
			"reset state"
			beginningOfTile := true.
			currentTileId := currentTile := nil.
			rowNum := 1.
		] ifFalse: [ 
		beginningOfTile ifTrue: [ 
			self assert: currentTileId isNil.
			self assert: currentTile isNil.
			self assert: rowNum = 1.
			"discard the Tile part and the terminating colon"
			currentTileId := (line copyFrom: 6 to: (line size - 1)) asNumber.
			currentTile := Array2D rows: (lines second size) columns: (lines second size) . "Array2D allows easy row/column based asplicing for calculating borders later".
			beginningOfTile := false.
		] ifFalse: [
			self assert: currentTileId isNotNil. 
			self assert: currentTile isNotNil.
			currentTile atRow: rowNum put: (line collect: [ :char | (char = $#) ifTrue: [ $1 ] ifFalse: [ $0 ] ]).
			rowNum := rowNum + 1.
		]
		]
  ].
	^ self new tileDescriptions: tileDescriptions
]

{ #category : #'as yet unclassified' }
AOCJurassicJigsaw >> borderIds [
	| answer borderIds |
	answer := Dictionary new.
	tileDescriptions
		keysAndValuesDo: [ :tileId :tileDesc | 
			borderIds := {(tileDesc atRow: 1).
			(tileDesc atRow: 1) reverse.
			(tileDesc atRow: tileDesc numberOfRows).
			(tileDesc atRow: tileDesc numberOfRows) reverse.
			(tileDesc atColumn: 1).
			(tileDesc atColumn: 1) reverse.
			(tileDesc atColumn: tileDesc numberOfColumns).
			(tileDesc atColumn: tileDesc numberOfColumns) reverse}
				collect:
					[ :borderDesc |
					 ('2r' , (String newFrom: borderDesc)) asNumber ].
			answer at: tileId put: borderIds asSet. ].
	^ answer
]

{ #category : #'as yet unclassified' }
AOCJurassicJigsaw >> corners [
	"answers the tile IDs forming the corners"
	| byBorderId tiles tilesToBordersThatAreNotShared borders |
	byBorderId := Dictionary new.
	self borderIds keysAndValuesDo: [ :tileId :borderIds | 
		borderIds do: [ :borderId |
			tiles := byBorderId at: borderId ifAbsentPut: [ Set new ].
			tiles add: tileId.
		]
	].
	tilesToBordersThatAreNotShared := Dictionary new.
	byBorderId keysAndValuesDo: [ :borderId :tileIds |
		(tileIds size = 1) ifTrue: [ 
			borders := tilesToBordersThatAreNotShared at: (tileIds anyOne) ifAbsentPut: [ Set new ].
			borders add: borderId.
		]
	].
	^ (tilesToBordersThatAreNotShared select: [ :notShared | notShared size = 4 ]) keys asSet
]

{ #category : #'as yet unclassified' }
AOCJurassicJigsaw >> tileDescriptions: aCollection [ 
	tileDescriptions := aCollection.
]
