"DUNGEON for
				  DEMO
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

;"This set replaced by following set from Planetfall"
;<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

;"REM OFFSETS 31  30  29  28   27  26  25  24 23  22  21  20  ,LOW-DIRECTION "
<DIRECTIONS NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<OBJECT SAILOR
	(IN GLOBAL-OBJECTS)
	(SYNONYM SAILOR FOOTPAD AVIATOR)
	(DESC "sailor")
	(FLAGS NDESCBIT)
	(ACTION SAILOR-FCN)>

<ROUTINE SAILOR-FCN ()
	  <COND (<VERB? HELLO>
		 <SETG HS <+ ,HS 1>>
		 <COND (<0? <MOD ,HS 20>>
			<TELL "You seem to be repeating yourself." CR>)
		       (<0? <MOD ,HS 10>>
			<TELL
"I think that phrase is getting a bit worn out." CR>)
		       (T
			<TELL "Nothing happens here." CR>)>)>>

<OBJECT ZORKMID
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZORKMID)
	(DESC "zorkmid")
	(ACTION ZORKMID-FUNCTION)>

<ROUTINE ZORKMID-FUNCTION ()
    <COND (<VERB? EXAMINE>
	   <TELL
"The zorkmid is the unit of currency of the Great Underground Empire." CR>)
	  (<VERB? FIND>
	   <TELL
"The best way to find zorkmids is to go out and look for them." CR>)>>

<OBJECT LUNGS
	(IN GLOBAL-OBJECTS)
	(SYNONYM LUNGS AIR MOUTH BREATH)
	(DESC "blast of air")
	(FLAGS NDESCBIT)>

<OBJECT BLESSINGS
	(IN GLOBAL-OBJECTS)
	(SYNONYM BLESSINGS GRACES)
	(DESC "blessings")
	(FLAGS NDESCBIT)>

<OBJECT BOARD
	(IN LOCAL-GLOBALS)
	(SYNONYM BOARDS BOARD)
	(DESC "board")
	(FLAGS NDESCBIT)
	(ACTION BOARD-F)>

<OBJECT TEETH
	(IN GLOBAL-OBJECTS)
	(SYNONYM OVERBOARD TEETH)
	(DESC "set of teeth")
	(FLAGS NDESCBIT)
	(ACTION TEETH-F)>

<OBJECT WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL WALLS)
	(ADJECTIVE SURROUNDING)
	(DESC "surrounding wall")>

<OBJECT SONGBIRD
	(IN LOCAL-GLOBALS)
	(SYNONYM BIRD SONGBIRD)
	(ADJECTIVE SONG)
	(DESC "songbird")
	(FLAGS NDESCBIT)
	(ACTION SONGBIRD-F)>

<OBJECT WHITE-HOUSE	
	(IN LOCAL-GLOBALS)
	(SYNONYM HOUSE)
	(ADJECTIVE WHITE BEAUTI COLONI)
	(DESC "white house")
	(FLAGS NDESCBIT)
	(ACTION WHITE-HOUSE-F)>

<OBJECT FOREST
	(IN LOCAL-GLOBALS)
	(SYNONYM FOREST TREES PINES HEMLOCKS)
	(DESC "forest")
	(FLAGS NDESCBIT)
	(ACTION FOREST-F)>

<OBJECT TREE
	(IN LOCAL-GLOBALS)
	(SYNONYM TREE BRANCH)
	(ADJECTIVE LARGE STORM)
	(DESC "tree")
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT MOUNTAIN-RANGE
	(IN MOUNTAINS)
	(DESC "mountain range")
	(SYNONYM MOUNTAIN RANGE)
	(ADJECTIVE IMPASSABLE FLATHEAD)
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION MOUNTAIN-RANGE-F)>

<OBJECT GLOBAL-WATER
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER QUANTITY)
	(DESC "water")
	(FLAGS DRINKBIT)
	(ACTION WATER-F)>

<OBJECT WATER
	(IN BOTTLE)
	(SYNONYM WATER QUANTITY LIQUID H2O)
	(DESC "quantity of water")
	(FLAGS TRYTAKEBIT TAKEBIT DRINKBIT)
	(ACTION WATER-F)
	(SIZE 4)>

<OBJECT	KITCHEN-WINDOW
	(IN LOCAL-GLOBALS)
	(SYNONYM WINDOW)
	(ADJECTIVE KITCHEN SMALL)
	(DESC "kitchen window")
	(FLAGS DOORBIT NDESCBIT)
	(ACTION KITCHEN-WINDOW-F)>

<OBJECT CHIMNEY
	(IN LOCAL-GLOBALS)
	(SYNONYM CHIMNEY)
	(ADJECTIVE DARK NARROW)
	(DESC "chimney")
	(ACTION CHIMNEY-F)
	(FLAGS CLIMBBIT NDESCBIT)>



<OBJECT LUNCH
	(IN SANDWICH-BAG)
	(SYNONYM FOOD SANDWICH LUNCH DINNER)
	(ADJECTIVE HOT PEPPER)
	(DESC "lunch")
	(FLAGS TAKEBIT FOODBIT)
	(LDESC "A hot pepper sandwich is here.")>

<OBJECT AXE
	(IN TROLL)
	(SYNONYM AXE AX)
	(ADJECTIVE BLOODY)
	(DESC "bloody axe")
	(FLAGS WEAPONBIT TRYTAKEBIT TAKEBIT NDESCBIT)
	(ACTION AXE-F)
	(SIZE 25)>

<OBJECT BROKEN-LAMP
	(SYNONYM LAMP LANTERN)
	(ADJECTIVE BROKEN)
	(DESC "broken lantern")
	(FLAGS TAKEBIT)>

<OBJECT	SLIDE
	(IN LOCAL-GLOBALS)
	(SYNONYM CHUTE RAMP SLIDE)
	(ADJECTIVE STEEP METAL TWISTING)
	(DESC "chute")
	(FLAGS CLIMBBIT)
	(ACTION SLIDE-FUNCTION)>

<OBJECT KITCHEN-TABLE
	(IN KITCHEN)
	(SYNONYM TABLE)
	(ADJECTIVE KITCHEN)
	(DESC "kitchen table")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(CAPACITY 50)>

<OBJECT ATTIC-TABLE
	(IN ATTIC)
	(SYNONYM TABLE)
	(DESC "table")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(CAPACITY 40)>

<OBJECT SANDWICH-BAG
	(IN KITCHEN-TABLE)
	(SYNONYM BAG SACK)
	(ADJECTIVE BROWN ELONGATED SMELLY)
	(DESC "brown sack")
	(FLAGS TAKEBIT CONTBIT BURNBIT)
	(FDESC
"On the table is an elongated brown sack, smelling of hot peppers.")
	(CAPACITY 15)
	(SIZE 3)
	(ACTION SANDWICH-BAG-FCN)>

<OBJECT TROPHY-CASE	;"first obj so L.R. desc looks right."
	(IN LIVING-ROOM)
	(SYNONYM CASE)
	(ADJECTIVE TROPHY)
	(DESC "trophy case")
	(FLAGS TRANSBIT CONTBIT NDESCBIT TRYTAKEBIT SEARCHBIT)
	(ACTION TROPHY-CASE-FCN)
	(CAPACITY 10000)>

<OBJECT RUG
	(IN LIVING-ROOM)
	(SYNONYM RUG CARPET)
	(ADJECTIVE LARGE ORIENTAL)
	(DESC "carpet")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION RUG-FCN)>

<OBJECT GARLIC
	(IN SANDWICH-BAG)
	(SYNONYM GARLIC CLOVE)
	(DESC "clove of garlic")
	(FLAGS TAKEBIT FOODBIT)
	(ACTION GARLIC-F)>

<OBJECT TRAP-DOOR
	(IN LIVING-ROOM)
	(SYNONYM DOOR TRAPDOOR TRAP-DOOR COVER)
	(ADJECTIVE TRAP DUSTY)
	(DESC "trap door")
	(FLAGS DOORBIT NDESCBIT INVISIBLE)
	(ACTION TRAP-DOOR-FCN)>

<OBJECT BOARDED-WINDOW
	(IN LOCAL-GLOBALS)
        (SYNONYM WINDOW)
	(ADJECTIVE BOARDED)
	(DESC "boarded window")
	(FLAGS NDESCBIT)
	(ACTION BOARDED-WINDOW-FCN)>

<OBJECT FRONT-DOOR
	(IN WEST-OF-HOUSE)
	(SYNONYM DOOR)
	(ADJECTIVE FRONT BOARDED)
	(DESC "door")
	(FLAGS DOORBIT NDESCBIT)
	(ACTION FRONT-DOOR-FCN)>

<OBJECT BOTTLE
	(IN KITCHEN-TABLE)
	(SYNONYM BOTTLE CONTAINER)
	(ADJECTIVE CLEAR GLASS)
	(DESC "glass bottle")
	(FLAGS TAKEBIT TRANSBIT CONTBIT)
	(ACTION BOTTLE-FUNCTION)
	(FDESC "A bottle is sitting on the table.")
	(CAPACITY 4)>

<OBJECT CRACK
	(IN LOCAL-GLOBALS)
	(SYNONYM CRACK)
	(ADJECTIVE NARROW)
	(DESC "crack")
	(FLAGS NDESCBIT)
	(ACTION CRACK-FCN)>

<OBJECT GRATE
	(IN LOCAL-GLOBALS)
	(SYNONYM GRATE GRATING)
	(DESC "grating")
	(FLAGS DOORBIT NDESCBIT INVISIBLE)
	(ACTION GRATE-FUNCTION)>

<OBJECT KNIFE
	(IN ATTIC-TABLE)
	(SYNONYM KNIVES KNIFE BLADE)
	(ADJECTIVE NASTY UNRUSTY)
	(DESC "nasty knife")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT)
	(FDESC "On a table is a nasty-looking knife.")
	(ACTION KNIFE-F)>

<OBJECT LAMP
	(IN LIVING-ROOM)
	(SYNONYM LAMP LANTERN LIGHT)
	(ADJECTIVE BRASS)
	(DESC "brass lantern")
	(FLAGS TAKEBIT LIGHTBIT)
	(ACTION LANTERN)
	(FDESC "A battery-powered brass lantern is on the trophy case.")
	(LDESC "There is a brass lantern (battery-powered) here.")
	(SIZE 15)>

<OBJECT ADVERTISEMENT
	(IN MAILBOX)
	(SYNONYM ADVERTISEMENT LEAFLET BOOKLET MAIL)
	(ADJECTIVE SMALL)
	(DESC "leaflet")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(LDESC "A small leaflet is on the ground.")
	(TEXT
"\"WELCOME TO ZORK!|
|
ZORK is a game of adventure, danger, and low cunning. In it you
will explore some of the most amazing territory ever seen by mortals.
No computer should be without one!\"|
")
	(SIZE 2)>

<OBJECT MAILBOX
	(IN WEST-OF-HOUSE)
	(SYNONYM MAILBOX BOX)
	(ADJECTIVE SMALL)
	(DESC "small mailbox")
	(FLAGS CONTBIT TRYTAKEBIT)
	(CAPACITY 10)
	(ACTION MAILBOX-F)>



<OBJECT PAINTING
	(IN GALLERY)
	(SYNONYM PAINTING ART CANVAS TREASURE)
	(ADJECTIVE BEAUTI)
	(DESC "painting")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION PAINTING-FCN)
	(FDESC
"Fortunately, there is still one chance for you to be a vandal, for on
the far wall is a painting of unparalleled beauty.")
	(LDESC "A painting by a neglected genius is here.")
	(SIZE 15)
	(VALUE 4)
	(TVALUE 6)>

<OBJECT LEAVES
	(IN GRATING-CLEARING)
	(SYNONYM LEAVES LEAF PILE)
	(DESC "pile of leaves")
	(FLAGS TAKEBIT BURNBIT TRYTAKEBIT)
	(ACTION LEAF-PILE)
	(LDESC "On the ground is a pile of leaves.")
	(SIZE 25)>

<OBJECT RAINBOW
	(IN LOCAL-GLOBALS)
	(SYNONYM RAINBOW)
	(DESC "rainbow")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION RAINBOW-FCN)>

<OBJECT RIVER
	(IN LOCAL-GLOBALS)
	(DESC "river")
	(SYNONYM RIVER)
	(ADJECTIVE FRIGID)
	(ACTION RIVER-FUNCTION)
	(FLAGS NDESCBIT)>

<OBJECT ZORK-ROPE
	(IN ATTIC)
	(SYNONYM ROPE HEMP COIL)
	(ADJECTIVE LARGE)
	(DESC "rope")
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION ROPE-FUNCTION)
	(FDESC "A large coil of rope is lying in the corner.")
	(SIZE 10)>

<OBJECT WOODEN-DOOR
	(IN LIVING-ROOM)
	(SYNONYM DOOR LETTER WRITING)
	(ADJECTIVE WOODEN GOTHIC STRANGE WEST)
	(DESC "wooden door")
	(FLAGS READBIT DOORBIT NDESCBIT TRANSBIT)
	(ACTION FRONT-DOOR-FCN)
	(TEXT
"The engravings translate to \"This space intentionally left blank.\"")>

<OBJECT SWORD
	(IN LIVING-ROOM)
	(SYNONYM SWORD ORCRIST GLAMDRING BLADE)
	(ADJECTIVE ELVISH OLD ANTIQUE)
	(DESC "sword")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT)
	(ACTION SWORD-FCN)
	(FDESC
"Above the trophy case hangs an elvish sword of great antiquity.")
	(SIZE 30)
	(TVALUE 0)>

<OBJECT TROLL
	(IN TROLL-ROOM)
	(SYNONYM TROLL)
	(ADJECTIVE NASTY)
	(DESC "troll")
	(FLAGS ACTORBIT OPENBIT TRYTAKEBIT)
	(ACTION TROLL-FCN)
	(LDESC
"A nasty-looking troll, brandishing a bloody axe, blocks all passages
out of the room.")
	(STRENGTH 2)>

<OBJECT OWNERS-MANUAL
	(IN STUDIO)
	(SYNONYM MANUAL PIECE PAPER)
	(ADJECTIVE ZORK OWNERS SMALL)
	(DESC "ZORK owner's manual")
	(FLAGS READBIT TAKEBIT)
	(FDESC "Loosely attached to a wall is a small piece of paper.")
	(TEXT
"|
Congratulations!|
|
You are the privileged owner of ZORK I: The Great Underground Empire,
a self-contained and self-maintaining universe. If used and maintained
in accordance with normal operating practices for small universes, ZORK
will provide many months of trouble-free operation.")>

<OBJECT NEST
	(IN UP-A-TREE)
	(SYNONYM NEST)
	(ADJECTIVE BIRDS)
	(DESC "bird's nest")
	(FLAGS TAKEBIT BURNBIT CONTBIT OPENBIT SEARCHBIT)
	(FDESC "Beside you on the branch is a small bird's nest.")
	(CAPACITY 20)>

<OBJECT EGG
	(IN NEST)
	(SYNONYM EGG TREASURE)
	(ADJECTIVE BIRDS ENCRUSTED JEWELED)
	(DESC "jewel-encrusted egg")
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION EGG-OBJECT)
	(VALUE 5)
	(TVALUE 5)
	(CAPACITY 6)
	(FDESC
"In the bird's nest is a large egg encrusted with precious jewels,
apparently scavenged by a childless songbird. The egg is covered with
fine gold inlay, and ornamented in lapis lazuli and mother-of-pearl.
Unlike most eggs, this one is hinged and closed with a delicate looking
clasp. The egg appears extremely fragile.")>

<OBJECT BROKEN-EGG
	(SYNONYM EGG TREASURE)
	(ADJECTIVE BROKEN BIRDS ENCRUSTED JEWEL)
	(DESC "broken jewel-encrusted egg")
	(FLAGS TAKEBIT CONTBIT OPENBIT)
	(CAPACITY 6)
	(TVALUE 2)
	(LDESC "There is a somewhat ruined egg here.")>



<OBJECT CANARY
	(IN EGG)
	(SYNONYM CANARY TREASURE)
	(ADJECTIVE CLOCKWORK GOLD GOLDEN)
	(DESC "golden clockwork canary")
	(FLAGS TAKEBIT SEARCHBIT)
	(ACTION CANARY-OBJECT)
	(VALUE 6)
	(TVALUE 4)
	(FDESC
"There is a golden clockwork canary nestled in the egg. It has ruby
eyes and a silver beak. Through a crystal window below its left
wing you can see intricate machinery inside. It appears to have
wound down.")>

<OBJECT BROKEN-CANARY
	(IN BROKEN-EGG)
	(SYNONYM CANARY TREASURE)
	(ADJECTIVE BROKEN CLOCKWORK GOLD GOLDEN)
	(DESC "broken clockwork canary")
	(FLAGS TAKEBIT)
	(ACTION CANARY-OBJECT)
	(TVALUE 1)
	(FDESC
"There is a golden clockwork canary nestled in the egg. It seems to
have recently had a bad experience. The mountings for its jewel-like
eyes are empty, and its silver beak is crumpled. Through a cracked
crystal window below its left wing you can see the remains of
intricate machinery. It is not clear what result winding it would
have, as the mainspring seems sprung.")>

<GLOBAL TROLL-FLAG <>>

<ROOM WEST-OF-HOUSE
      (IN ROOMS)
      (DESC "West of House")
      (LDESC
"You are standing in an open field west of a white house, with a boarded
front door.")
      (NORTH TO NORTH-OF-HOUSE)
      (SOUTH TO SOUTH-OF-HOUSE)
      (NE TO NORTH-OF-HOUSE)
      (SE TO SOUTH-OF-HOUSE)
      (WEST TO FOREST-1)
      (EAST "The door is boarded and you can't remove the boards.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WHITE-HOUSE BOARD)>

<ROOM NORTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"You are facing the north side of a white house. There is no door here,
and all the windows are boarded up. To the north a narrow path winds through
the trees.")
      (DESC "North of House")
      (SW TO WEST-OF-HOUSE)
      (SE TO EAST-OF-HOUSE)
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NORTH TO PATH)
      (SOUTH "The windows are all boarded.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE)>

<ROOM SOUTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"You are facing the south side of a white house. There is no door here,
and all the windows are boarded.")
      (DESC "South of House")
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NE TO EAST-OF-HOUSE)
      (NW TO WEST-OF-HOUSE)
      (SOUTH TO FOREST-3)
      (NORTH "The windows are all boarded.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE)>

<ROOM EAST-OF-HOUSE
      (IN ROOMS)
      (DESC "Behind House")
      (NORTH TO NORTH-OF-HOUSE)
      (SOUTH TO SOUTH-OF-HOUSE)
      (SW TO SOUTH-OF-HOUSE)
      (NW TO NORTH-OF-HOUSE)
      (EAST TO CLEARING)
      (WEST TO KITCHEN IF KITCHEN-WINDOW IS OPEN)
      (IN TO KITCHEN IF KITCHEN-WINDOW IS OPEN)
      (ACTION EAST-HOUSE)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WHITE-HOUSE KITCHEN-WINDOW)>

<ROOM FOREST-1
      (IN ROOMS)
      (LDESC
"This is a forest, with trees in all directions. To the east,
there appears to be sunlight.")
      (DESC "Forest")
      (UP "There is no tree here suitable for climbing.")
      (NORTH TO GRATING-CLEARING)
      (EAST TO PATH)
      (SOUTH TO FOREST-3)
      (WEST "You would need a machete to go further west.")
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM FOREST-2
      (IN ROOMS)
      (LDESC "This is a dimly lit forest, with large trees all around.")
      (DESC "Forest")
      (UP "There is no tree here suitable for climbing.")
      (NORTH "The forest becomes impenetrable to the north.")
      (EAST TO MOUNTAINS)
      (SOUTH TO CLEARING)
      (WEST TO PATH)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM MOUNTAINS
      (IN ROOMS)
      (LDESC "The forest thins out, revealing impassable mountains.")
      (DESC "Forest")
      (UP "The mountains are impassable.")
      (NORTH TO FOREST-2)
      (EAST "The mountains are impassable.")
      (SOUTH TO FOREST-2)
      (WEST TO FOREST-2)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE WHITE-HOUSE)
      (ACTION MOUNTAINS-ROOM)>

<ROOM FOREST-3
      (IN ROOMS)
      (LDESC "This is a dimly lit forest, with large trees all around.")
      (DESC "Forest")
      (UP "There is no tree here suitable for climbing.")
      (NORTH TO CLEARING)
      (EAST "The rank undergrowth prevents eastward movement.")
      (SOUTH "Storm-tossed trees block your way.")
      (WEST TO FOREST-1)
      (NW TO SOUTH-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM PATH
      (IN ROOMS)
      (LDESC
"This is a path winding through a dimly lit forest. The path heads
north-south here. One particularly large tree with some low branches
stands at the edge of the path.")
      (DESC "Forest Path")
      (UP TO UP-A-TREE)
      (NORTH TO GRATING-CLEARING)
      (EAST TO FOREST-2)
      (SOUTH TO NORTH-OF-HOUSE)
      (WEST TO FOREST-1)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM UP-A-TREE
      (IN ROOMS)
      (DESC "Up a Tree")
      (DOWN TO PATH)
      (UP "You cannot climb any higher.")
      (ACTION TREE-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE FOREST SONGBIRD WHITE-HOUSE)>

<ROOM GRATING-CLEARING
      (IN ROOMS)
      (DESC "Clearing")
      (NORTH "The forest becomes impenetrable to the north.")
      (EAST TO FOREST-2)
      (WEST TO FOREST-1)
      (SOUTH TO PATH)
      (DOWN PER GRATING-EXIT)
      (ACTION CLEARING-FCN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WHITE-HOUSE GRATE)>

<ROUTINE GRATING-EXIT ()
	 <COND (,GRATE-REVEALED
		<TELL "The grating is closed!" CR>
		<THIS-IS-IT ,GRATE>
		<RFALSE>)
	       (T
		<TELL ,CANT-GO CR>
		<RFALSE>)>>

<ROOM CLEARING
      (IN ROOMS)
      (LDESC
"You are in a small clearing in a well marked forest path that
extends to the east and west.")
      (DESC "Clearing")
      (UP "There is no tree here suitable for climbing.")
      (EAST TO CANYON-VIEW)
      (NORTH TO FOREST-2)
      (SOUTH TO FOREST-3)
      (WEST TO EAST-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<GLOBAL FALSE-FLAG <>>

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Kitchen")
      (EAST TO EAST-OF-HOUSE IF KITCHEN-WINDOW IS OPEN)
      (WEST TO LIVING-ROOM)
      (OUT TO EAST-OF-HOUSE IF KITCHEN-WINDOW IS OPEN)
      (UP TO ATTIC)
      (DOWN TO STUDIO IF FALSE-FLAG ELSE
 	 "Only Santa Claus climbs down chimneys.")
      (ACTION KITCHEN-FCN)
      (FLAGS RLANDBIT ONBIT)
      (VALUE 10)
      (GLOBAL KITCHEN-WINDOW CHIMNEY STAIRS)>

<ROOM ATTIC
      (IN ROOMS)
      (LDESC "This is the attic. The only exit is a staircase leading down.")
      (DESC "Attic")
      (DOWN TO KITCHEN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM LIVING-ROOM
      (IN ROOMS)
      (DESC "Living Room")
      (EAST TO KITCHEN)
      (WEST "The door is nailed shut.")
      (DOWN PER TRAP-DOOR-EXIT)
      (ACTION LIVING-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL STAIRS)
      (PSEUDO "NAILS" NAILS-PSEUDO "NAIL" NAILS-PSEUDO)>

<ROOM CELLAR
      (IN ROOMS)
      (DESC "Cellar")
      (NORTH TO TROLL-ROOM)
      (SOUTH TO EAST-OF-CHASM)
      (UP TO LIVING-ROOM IF TRAP-DOOR IS OPEN)
      (WEST
"You try to ascend the ramp, but it is impossible, and you slide back down.")
      (ACTION CELLAR-FCN)
      (FLAGS RLANDBIT)
      (VALUE 25)
      (GLOBAL TRAP-DOOR SLIDE STAIRS)>

<ROOM TROLL-ROOM
      (IN ROOMS)
      (LDESC
"This is a small room with passages to the east and south and a
forbidding hole leading west. Bloodstains and deep scratches
(perhaps made by an axe) mar the walls.")
      (DESC "The Troll Room")
      (SOUTH TO CELLAR)
      (EAST "The troll fends you off with a menacing gesture.")
      (WEST "The troll fends you off with a menacing gesture.")
      (FLAGS RLANDBIT)
      (ACTION TROLL-ROOM-F)>

<ROOM EAST-OF-CHASM
      (IN ROOMS)
      (LDESC
"You are on the east edge of a chasm, the bottom of which cannot be
seen. A narrow passage goes north, and the path you are on continues
to the east.")
      (DESC "East of Chasm")
      (NORTH TO CELLAR)
      (EAST TO GALLERY)
      (DOWN "The chasm probably leads straight to the infernal regions.")
      (FLAGS RLANDBIT)
      (PSEUDO "CHASM" CHASM-PSEUDO)>

<ROOM GALLERY
      (IN ROOMS)
      (LDESC
"This is an art gallery. Most of the paintings have been stolen by
vandals with exceptional taste. The vandals left through either the
north or west exits.")
      (DESC "Gallery")
      (WEST TO EAST-OF-CHASM)
      (NORTH TO STUDIO)
      (FLAGS RLANDBIT ONBIT)>

<ROOM STUDIO
      (IN ROOMS)
      (LDESC
"This appears to have been an artist's studio. The walls and floors are
splattered with paints of 69 different colors. Strangely enough, nothing
of value is hanging here. At the south end of the room is an open door
(also covered with paint). A dark and narrow chimney leads up from a
fireplace; although you might be able to get up it, it seems unlikely
you could get back down.")
      (DESC "Studio")
      (SOUTH TO GALLERY)
      (UP PER UP-CHIMNEY-FUNCTION)
      (FLAGS RLANDBIT)
      (GLOBAL CHIMNEY)
      (PSEUDO "DOOR" DOOR-PSEUDO "PAINT" PAINT-PSEUDO)>

<ROOM END-OF-RAINBOW	;"was POG"
      (IN ROOMS)
      (LDESC
"You are on a small, rocky beach on the continuation of the Frigid
River past the Falls. The beach is narrow due to the presence of the
White Cliffs. The river canyon opens here and sunlight shines in
from above. A rainbow crosses over the falls to the east and a narrow
path continues to the southwest.")
      (DESC "End of Rainbow")
      (SW TO CANYON-BOTTOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RAINBOW RIVER)>

<ROOM CANYON-BOTTOM	;"was CLBOT"
      (IN ROOMS)
      (LDESC
"You are beneath the walls of the river canyon which may be climbable
here. The lesser part of the runoff of Aragain Falls flows by below.
To the north is a narrow path.")
      (DESC "Canyon Bottom")
      (UP TO CLIFF-MIDDLE)
      (NORTH TO END-OF-RAINBOW)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER CLIMBABLE-CLIFF RIVER)>

<OBJECT CLIMBABLE-CLIFF
	(IN LOCAL-GLOBALS)
	(SYNONYM WALL CLIFF WALLS LEDGE)
	(ADJECTIVE ROCKY SHEER)
	(DESC "cliff")
	(ACTION CLIFF-OBJECT)
	(FLAGS NDESCBIT CLIMBBIT)>

<ROOM CLIFF-MIDDLE	;"was CLMID"
      (IN ROOMS)
      (LDESC
"You are on a ledge about halfway up the wall of the river canyon.
You can see from here that the main flow from Aragain Falls twists
along a passage which it is impossible to enter. Below you is the
canyon bottom. Above you is more cliff, which appears
climbable.")
      (DESC "Rocky Ledge")
      (UP TO CANYON-VIEW)
      (DOWN TO CANYON-BOTTOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CLIMBABLE-CLIFF RIVER)>

<ROOM CANYON-VIEW	;"was CLTOP"
      (IN ROOMS)
      (LDESC
"You are at the top of the Great Canyon on its west wall. From here
there is a marvelous view of the canyon and parts of the Frigid River
upstream. Across the canyon, the walls of the White Cliffs join the
mighty ramparts of the Flathead Mountains to the east. Following the
Canyon upstream to the north, Aragain Falls may be seen, complete with
rainbow. The mighty Frigid River flows out from a great dark cavern. To
the west and south can be seen an immense forest, stretching for miles
around. A path leads northwest. It is possible to climb down into
the canyon from here.")
      (DESC "Canyon View")
      (EAST TO CLIFF-MIDDLE)
      (DOWN TO CLIFF-MIDDLE)
      (NW TO CLEARING)
      (WEST TO FOREST-3)
      (SOUTH "Storm-tossed trees block your way.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CLIMBABLE-CLIFF RIVER ;RAINBOW)
      (ACTION CANYON-VIEW-F)>

<ROUTINE CANYON-VIEW-F (RARG)
	 <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? LEAP>
		     <NOT ,PRSO>>
		<JIGS-UP "Nice view, lousy place to jump.">
		<RTRUE>)>>
	       
<GLOBAL HOUSE-AROUND
  <LTABLE WEST-OF-HOUSE NORTH-OF-HOUSE EAST-OF-HOUSE SOUTH-OF-HOUSE
	  WEST-OF-HOUSE>>

<GLOBAL FOREST-AROUND
  <LTABLE FOREST-1 FOREST-2 FOREST-3 PATH CLEARING FOREST-1>>

<GLOBAL IN-HOUSE-AROUND
  <LTABLE LIVING-ROOM KITCHEN ATTIC KITCHEN>>

<GLOBAL ABOVE-GROUND
  <LTABLE WEST-OF-HOUSE NORTH-OF-HOUSE EAST-OF-HOUSE SOUTH-OF-HOUSE
	  FOREST-1 FOREST-2 FOREST-3 PATH CLEARING GRATING-CLEARING
	  CANYON-VIEW>>

;"The GO routine must live here."

<ROUTINE GO ()
	<ENABLE <QUEUE I-FIGHT -1>>
	<QUEUE I-SWORD -1>
	<QUEUE I-LANTERN 200>
	<PUT ,DEF1-RES 1 <REST ,DEF1 2>>
	<PUT ,DEF1-RES 2 <REST ,DEF1 4>>
	<PUT ,DEF2-RES 2 <REST ,DEF2B 2>>
	<PUT ,DEF2-RES 3 <REST ,DEF2B 4>>
	<PUT ,DEF3-RES 1 <REST ,DEF3A 2>>
	<PUT ,DEF3-RES 3 <REST ,DEF3B 2>>
	<SETG LIT T>
	<SETG WINNER ,ADVENTURER>
	<SETG PLAYER ,WINNER>
	<MOVE ,WINNER ,WELCOME-MAT>
	<SETG HERE ,WELCOME-MAT>
	<COND (<WANTS-TUTORIAL?>
	       <SETG HERE ,T-LIVING-ROOM>
	       <MOVE ,WINNER ,HERE>
	       <SETG TUTORIAL-MODE T>
	       <CRLF> <CRLF> <CRLF> <CRLF> <CRLF> <CRLF> <CRLF> <CRLF> <CRLF>
	       <INTRO>)
	      (T
	       <CRLF> <CRLF> <CRLF> <CRLF> <CRLF> <CRLF> <CRLF> <CRLF> <CRLF>
	       <SETG TUTORIAL-MODE <>>
	       <COND (<EQUAL? ,GAME-FLAG 1>
		      <TELL ,ZORK-INSTRUCTIONS CR>
		      <TELL ,LUCK-STR CR CR>
		      <SETG HERE ,WEST-OF-HOUSE>
		      <MOVE ,WINNER ,HERE>
		      <THIS-IS-IT ,MAILBOX>
		      <MOVE ,WATER ,BOTTLE>
		      <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		             <V-VERSION>
		             <CRLF>)>)
		     (<EQUAL? ,GAME-FLAG 2>
		      <TELL ,PLANETFALL-INSTRUCTIONS CR>
		      <TELL ,LUCK-STR CR CR>
		      <SETG HERE ,CORRIDOR-JUNCTION>
		      <ENABLE <QUEUE I-SLEEP-WARNINGS 1500>>
		      <ENABLE <QUEUE I-HUNGER-WARNINGS 1680>>
		      <MOVE ,WINNER ,HERE>
		      <SETG INTERNAL-MOVES <+ 6450 <RANDOM 180>>>
		      <SETG MOVES ,INTERNAL-MOVES>
		      <SETG SCORE 6>
		      <SETG LIT T>
		      <MOVE ,CHRONOMETER ,WINNER>
		      <MOVE ,PATROL-UNIFORM ,WINNER>
		      <MOVE ,FOOD-KIT ,WINNER>
		      <MOVE ,DUST ,ADMIN-CORRIDOR-S>
		      <SETG P-IT-LOC ,CORRIDOR-JUNCTION>
		      <SETG P-IT-OBJECT <>>
		      <SETG SPOUT-PLACED ,GROUND>
		      <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		             <V-VERSION>
		             <CRLF>)>)
		     (<EQUAL? ,GAME-FLAG 3>
		      <TELL ,INFIDEL-INSTRUCTIONS CR>
		      <TELL ,LUCK-STR CR CR>
		      <RANDOMIZE-HOLES>
		      <ENABLE <QUEUE I-GINANDTONIC -1>>
		      <ENABLE <QUEUE I-PARACHUTE -1>>
		      <ENABLE <QUEUE I-GROWL -1>>
		      <REMOVE ,WATER>
		      <REMOVE ,GLOBAL-DOORWAY>
		      <SETG LIT T>
		      <SETG HERE ,TENT>
		      <SETG P-IT-LOC ,HERE>
		      <SETG P-IT-OBJECT <>>
		      <THIS-IS-IT ,COT>
		      <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
			     <TELL ,INFI-INTRO CR>
			     <CRLF>
			     <V-VERSION>
			     <CRLF>)>
		      <MOVE ,WINNER ,COT>)
		     (T
		      <MOVE ,WINNER ,WITNESS-ROOM>
		      <SETG HERE ,WITNESS-ROOM>
		      <USL>
		      <WITNESS>
		      <FINISH <>>)>
	       <V-LOOK>)>
	<MAIN-LOOP>
	<AGAIN>>

<GLOBAL INFI-INTRO
"You wake slowly, sit up in your bunk, look around the tent, and try to ignore
the pounding in your head, the cottony taste in your mouth, and the ache in
your stomach. The droning of a plane's engine breaks the stillness and you
realize that things outside are quiet -- too quiet. You know that this can
mean only one thing: your workmen have deserted you. They complained over the
last few weeks, grumbling about the small pay and lack of food, and your
inability to locate the pyramid. And after what you stupidly did yesterday,
trying to make them work on a holy day, their leaving is understandable.|
|
The Professor's map was just an ancient map -- as worthless as an ice cube in
the Arctic without an instrument fine enough to accurately measure longitude
and latitude. You knew that the site was nearby. You dug, and you ordered the
workers to dig, even without the box. As you listen to the plane and rub your
aching eyes, you pray they left you supplies enough to find the pyramid and to
survive, and that the plane's carrying the long-overdue box.">

<ROUTINE WITNESS ()
	<TELL
"In The Witness, you are chief police detective in the suburb of Cabeza Plana.
You just received a telegram from a Mr. Linder, saying that his life
is in danger and asking for your help. His name \"rang a bell,\" and you
consulted a police file on the case of his wife's recent suicide.
Now you are ready to meet him for the first time. The Witness is so
richly interwoven that we were unable to pull out a
small portion to use as an interactive part of this Sampler. Therefore,
we'll show you one possible transcript for a section of the story. The
lines in capital letters (like RING THE DOORBELL) are those typed in by
our hypothetical player. The following lines show what happened as a
result. Here, then, is one possible opening to The Witness ...|
|
Somewhere near Los Angeles. A cold Friday evening in February 1938.
In this climate, cold is anywhere below about fifty degrees. Storm
clouds are swimming across the sky, their bottoms glowing faintly from
the city lights in the distance. A search light pans slowly under the
clouds, heralding another film premiere. The air seems expectant, waiting
for the rain to begin, like a cat waiting for the ineffable moment
to ambush.|
">
	<TELL "|
The taxi has just dropped you off at the entrance to the Linders' driveway.
The driver didn't seem to like venturing into this maze of twisty streets
any more than you did. But the house windows are full of light, and
radio music drifts toward you. Your favorite pistol, a snub-nosed Colt
.32, is snug in its holster. The long week is finished, except
for this appointment. But why does an ominous feeling grip you?|
|
The WITNESS: an interactive fiction mystery|
Copyright (c) 1983 Infocom, Inc. All rights reserved.|
WITNESS is a trademark of Infocom, Inc.|
|
What next?|
|
>RING THE DOORBELL|
|
Someone turns off the radio. You hear footsteps inside the house. Then
the door swings open.
\"Good evening,\" says a smiling face, \"I am Phong. Please come in.\"
He leads you into the house and closes the door behind you.|
">
	<TELL "|
You are now in the entry.|
Here in the entry is a small Shinto shrine, with a hanging scroll and
an arrangement of flowers, as well as a coat closet and a platform
for storing shoes. You can see a hallway to the east.|
Phong's straight black hair and folded eyelids make him obviously Asian,
but no definite nationality. His open, almost gentle face holds a quick
smile and eyes that seem to miss nothing. He carries his stout body
lightly, but you can see great strength under his light shirt and dark
trousers. You guess his age at about fifty, but who knows how many
lifetimes of experience he carries?|
|
>HELLO MR. PHONG|
|
Mr. Phong nods at you.|
Phong says, \"I believe the Linders are in the living room. Please follow
me.\" He leads you into a hallway and turns left. This hallway seems
to run the length of the house, from the garage at the south end to
the living room at the north. There is enough warm yellow light flooding
from the living room for you to see a few doors on each side of the
hall. As you get near the living room, you hear voices talking, half-loud
and fast.|
">
	<TELL "|
You are now in the living room.|
A huge fieldstone fireplace on the south wall holds a blazing fire,
filling the living room with warmth and light. Grouped in front of
the fire are a glass-topped coffee table and a rattan davenport and
club chair, with cushions covered in a print showing bamboo plants
in the style of Japanese brush-painting. A lamp with a printed shade
and a telephone sit on the table.
On the north wall are a console radio and a liquor cabinet made of
light-colored wood.|
|
\"Excuse me, sir,\" says Phong, \"but the detective has arrived.\"|
|
Monica stops talking and looks at you sharply. She is a woman in her
mid-twenties. Her grey eyes flash, emphasizing her dark waved hair
and light but effective make-up. She wears a navy Rayon blouse, tan
slacks, and tan pumps with Cuban heels. She acts as though you were
a masher who just gave her a whistle.|
Linder stands at least six foot, with a powerful frame but quick actions,
like a cat. His eyeglasses sit on top of his head, where thin strands
of long black hair go here and there, mostly combed backward. His wide-set
hazel eyes size you up quickly from within their pouches in his ruddy
face. He wears a silk peach-colored Mandarin shirt and chocolate trousers,
impeccably tailored and laundered, but sweat gleams on his high forehead,
and he looks as though he hasn't slept much lately." CR>
	<TELL CR "Linder turns to you and says, \"Detective, am I glad to see you! This
is my daughter, Monica, and of course you've met Phong already.\" He
looks at a wrist watch with a gleaming silver bracelet. \"I see you're
right on time. I'll be with you as soon as I finish my drink.\"
Mr. Phong heads off to the south.|
|
What next?|
|
>ASK MONICA FOR A DRINK|
|
\"So you want to dip your beak? Go ahead.\"|
|
>LISTEN TO THE RADIO|
|
You turn on the radio, spin the dial and find an Amos 'n Andy serial.|
Suddenly, a clap of thunder rolls across the hills outside.|
|
>WAIT|
|
Without warning, lightning flashes outside, and a few seconds later
thunder rattles the house.|
|
Rain begins to fall outside in a sprinkle.|
|
Linder gulps down the rest of his drink. \"Well, Detective,\" he says,
\"I'm anxious to get on with our business. Let's you and I go to my
office so we can talk undisturbed.\" He takes you by the arm and leads
you through the hallway. Just south of the entry, he opens a door to
the east and leads you through it.|">
	<TELL "|
(office)|
This is obviously the office of Mr. Linder's company, Pacific Trade
Associates. At the west end of the office, a massive desk of teak and
mahogany faces toward the window. It has no drawers, but the top is
covered with piles of letters, some newspapers, a telephone, and various
souvenirs from the Far East.|
Behind it is a large ornately-carved chair, like a cruiser escorting
a battle ship. A simple wooden chair, polished smooth by visitors,
flanks the desk on the other side. On the north wall is a lounge, upholstered
in green velvet and a bit lumpy, with a framed wood-block picture hanging
over it. On the outside wall, next to a door and window, stands a grandfather
clock, ticking relentlessly. A file cabinet stands in the corner.|
A cat is sleeping in the corner.|
Linder sits down in the carved chair.|
It's now 8:13 p.m.|
|
>SIT ON WOODEN CHAIR|
|
You are now sitting on the wooden chair.|
Linder begins his story. \"My late wife, may she rest in peace, got
involved with a young man named Stiles. Naturally I tried to stop this
affair, but without much success. Since my wife passed away, this Stiles
fellow has gone off the deep end, I'm afraid, and blamed me for her
death. I tried my best to ignore him, but he seems to have lost his
senses. This morning I received this note and decided to ask your help.\"
He hands the note to you.|
">
	<TELL "|
The rain outside is falling heavily now.|
|
>READ THE THREATENING NOTE|
|
The note is written in a spidery hand on fine rag paper. It says:|
\"Linder --|
Since Virginia died, I've lost too much sleep because of you and
your harrassments. The time has come to put this matter to rest
once and for all. I'll be seeing you sooner than you imagine.|
              -- Stiles\"|
|
>LINDER, TELL ME ABOUT STILES|
|
\"All I know about Stiles is that he's a writer of some kind, and
sometimes he plays bit parts in films. I've never really met the man.\"|
|
>WAKE UP THE CAT|
|
The cat yawns, licks its lips, and settles down again.|
|
>WAIT|
|
Time passes...|
|
The rain outside begins to taper off.|
|
The rain storm outside has passed now.|
|
The clock chimes once to mark the half hour.|
|
Monica bursts into the office, wearing a felt hat and wool coat, and
struggling to get her driving gloves on. She glances icily in your
direction and then back to her father. \"I'm off to the pictures with
Terry, Dad. Good-bye.\" She hugs him briefly but firmly, burying her
head in his shoulder.|
He pushes her away and says, \"You're leaving
now?! I thought you'd be talking to the detective here. What about
the threat on my life?\" He has the hurt look of an orphan pup.|
She
answers, \"You don't need me here. I need to get away now and then.
I'm not like Mother, you know.\" Tears well up in her eyes but she brushes
them away before they drop. She turns to leave.|
">
	<TELL "|
It's now 8:36 p.m.|
|
>WAIT|
|
Time passes...|
|
Monica heads off to the west.|
|
Outside somewhere, a car roars to life and speeds away.|
|
The clock chimes 9 times to mark the hour.|
|
You hear the door bell ring.|
|
Linder looks toward the window and says, \"I don't think Phong has answered
the door bell yet.\" He reaches toward the butler's button and at the
same instant shouts \"Stiles!\" You turn around and dimly see a figure
outside. Suddenly there is a flash of light and an explosion, and the
window falls into dozens of shiny shards. The cat bolts and disappears
somewhere. The figure outside turns and runs before you can see the
face. When you turn back around, you see Linder slumping down in his
chair, with a bloody stain spreading across his silk shirt. He teeters
on the edge of the seat, then falls onto the floor, quite dead.|
It's now 9:03 p.m.|
|
(Now you have a murder to investigate. In the complete story, you'll
have to search for evidence, make analyses, question suspects, and arrest
your suspect before 8:00 a.m. when your time runs out!)">>

<GLOBAL ZORK-INSTRUCTIONS
"Briefly, here are the instructions for Zork I: The Great Underground
Empire. You, a treasure hunter, have heard of a nearby underground labyrinth
that contains vast amounts of treasure. Naturally, you wish to obtain as much
as possible. To measure your success in this treasure hunt, a score is kept.
You get points both for finding treasures and for placing them in the trophy
case that you will find during the story. Obstacles will lie in your way, but
you can overcome them by observation and clear thinking.|
|
You start the story in front of a large white house, with the entrance to
the underground hidden nearby. In this sample of Zork I, your
goal is to find your way underground and get past a rather nasty obstacle to
reach the main underground chambers.">

<GLOBAL PLANETFALL-INSTRUCTIONS
"Briefly, here are the instructions for Planetfall. You are a lowly Ensign
Seventh Class in the Stellar Patrol of the Third Galactic Union, and after
the mysterious destruction of your ship, the SPS Feinstein, you were stranded
in an island complex on a deserted world.|
|
In this excerpt, your goal will be to find a way to cross the gaping rift
that you'll come across in one of the corridors. Time, which is shown at
the right-hand side of your status line, is in millichrons. Ten thousand
millichrons make up a day.|
|
You may also meet a character that you might want to talk to. To do this,
type the character's name (or description) followed by a comma followed
by what you want to say. For example:|
|
ROBOT, GO NORTH|">

<GLOBAL INFIDEL-INSTRUCTIONS
"Briefly, here are the instructions for Infidel. You are an
explorer, out in search of an ancient, lost pyramid. Your workers have
deserted you due to the way you've treated them, and have taken most
of your supplies along with them. As you wander about your encampment,
try to gather materials you think may be helpful in finding the lost pyramid,
buried deep beneath the sands. Once you've found it, however, your real
exploration and challenge begins as you try to unravel the mysteries of the
pyramid.|
|
In this sample, your goal will be to survive the rigors
of the desert and to locate the hidden pyramid.">
   
<GLOBAL LUCK-STR
;"If you have not seen the Tutorial and have difficulty in this scenario,
type TUTORIAL at the prompt, \">\". Good luck!"
"If you have difficulty with this excerpt, you may wish to review the Tutorial.
Type RESTART at the prompt, \">\", to return to the menu.">

<ROUTINE WANTS-TUTORIAL? ("AUX" WRD)
	 <TELL "|
Welcome to the world of Infocom's interactive fiction! This Sampler
contains an interactive fiction Tutorial and excerpts from four Infocom
titles: Zork I, Planetfall, Infidel, and The Witness.|
|
The Tutorial introduces you to the concept of interactive fiction. In
it, you'll be taken through a brief sample scenario. You'll learn how
to communicate with the story and pick up tips for solving the types of
puzzles you'll encounter in the excerpts.|
|
The excerpt from Zork I, Infocom's classic fantasy story, includes your
discovery of the ancient caverns of the Great Underground Empire. In
the sample of Planetfall, a science fiction comedy, you'll find yourself
stranded on a deserted alien planet. In Infidel, a challenging Tale of
Adventure, you'll be taken to the heart of the Egyptian desert, where
you'll search for a great lost pyramid. A sample transcript from The
Witness will give you a glimpse of the action in this 30's-style
detective thriller.|
|
Now, press the RETURN (or ENTER) key to see a list of the things you can
do next.">
	 <READ ,P-INBUF ,P-LEXV>
	 <TELL
"|
WHAT DO YOU WANT TO SEE?|
|
If you haven't had any experience with interactive fiction, we suggest
you try the Tutorial first. The Tutorial is designed to provide you
with whatever help you might need as you explore its sample scenario.
In the story excerpts, you'll be on your own.|
|
T - The Tutorial|
|
I - Infidel excerpt -- a Tale of Adventure|
P - Planetfall excerpt -- science fiction|
W - Sample transcript from The Witness -- a mystery|
Z - Zork I excerpt -- a fantasy|
|
B - Blatantly self-serving propaganda|
|
N - Nothing; I'm done with this Sampler for now|
|
Whenever you want to start the Sampler over from the beginning, just type
RESTART and press the RETURN (or ENTER) key. If you want to leave the
Sampler, type QUIT.|
|
(Please type in the appropriate letter and press the RETURN or ENTER key.)>">
	 <REPEAT ()
	  <READ ,P-INBUF ,P-LEXV>
	  <COND (<EQUAL? <SET WRD <GET ,P-LEXV 1>> ,W?TUTORIAL ,W?T>
		 <RTRUE>)
		(<EQUAL? .WRD ,W?ZORK ,W?Z>
		 <SETG GAME-FLAG 1>
		 <RFALSE>)
		(<EQUAL? .WRD ,W?PLANET ,W?P>
		 <SETG GAME-FLAG 2>
		 <RFALSE>)
		(<EQUAL? .WRD ,W?INFIDE ,W?I>
		 <MOVE ,CRATE ,GLOBAL-OBJECTS>
		 <SETG GAME-FLAG 3>
		 <RFALSE>)
		(<EQUAL? .WRD ,W?WITNES ,W?W>
		 <SETG GAME-FLAG 4>
		 <RFALSE>)
		(<EQUAL? .WRD ,W?PROPAG ,W?B ,W?BLATAN>
		 <SELF-PROMOTE>
		 <CRLF>
		 <CRLF>
		 <DO-RESTART>
	       ; <FINISH <>>)
		(<OR <EQUAL? .WRD ,W?QUIT ,W?Q ,W?N>
		     <EQUAL? .WRD ,W?NOTHIN>>
		 <TELL
"Thanks for playing!" CR CR>
		 <QUIT>)
	        (T
		 <TELL
"(Please type in the appropriate letter and press the RETURN or ENTER key.)>">
		 <AGAIN>)>>>

<GLOBAL TUTORIAL-MODE <>>

<GLOBAL GAME-FLAG 0>

<ROUTINE SELF-PROMOTE ()
	 <SETG HERE ,BULLSHIT-LAND>
	 <USL>
	 <CRLF>
	 <TELL
"HAVE WE GOT A STORY FOR YOU!|
|
Here at Infocom, we make stories for everyone, from the first-time
adventurer to the experienced sleuth. Our four levels of difficulty,
listed below, make it easy for you to decide which stories are right for
you.|
|
INTRODUCTORY: Best introduction to interactive fiction, with some
built-in hints. Written for everyone from age 9 up.|
|
STANDARD: This is Infocom's most popular level of interactive fiction,
enjoyed by both first-time and experienced players.|
|
ADVANCED: A greater level of challenge. Recommended for those who've
already experienced Infocom's interactive fiction.|
|
EXPERT: The ultimate in interactive fiction.|
|
You choose not only the level of difficulty that's right for you, but
also the kind of story that interests you most. Whether you like
mysteries, adventures, fantasies, or science fiction, Infocom has a
challenging story for you.|
|
In our Fantasy line, you can pick from our classic Zork trilogy -- Zork
I (standard level), Zork II (advanced level), or Zork III (advanced level) --
and explore the puzzling caverns of the Great Underground Empire, collecting
long-lost treasures and battling trolls and wizards. In Enchanter (standard
level) and Sorcerer (advanced level) you use magic spells and potions
to fight wickedness and evil. Or play Wishbringer (introductory level), where
you can use the Magick Stone of Dreams to rescue your little village from
the skewed reign of the Evil One.|
|
If Tales of Adventure turn you on, try Seastalker (introductory level)
and save the Aquadome, an underwater research lab, from perils of
terrifying dimensions. Or plunge into Cutthroats (standard level), in
which you're a deep-sea diver attempting to loot a couple of shipwrecks.
Or brave the Egyptian desert in Infidel (advanced level), and discover
(if you can!) an ancient buried pyramid, laden with priceless treasures.|
|
Ever think you'd make a pretty good detective? If so, then our mystery
stories are for you. In The Witness (standard level), blackmail leads to
murder in 1938 Los Angeles, and you have 12 hours to solve the crime. In
Suspect (advanced level), the hostess at an elegant costume ball is
found strangled, and you're the prime suspect. In Deadline (expert
level), you investigate the suspicious suicide of a wealthy businessman.|
|
Fans of science fiction have plenty to choose from. There's the hilarious
best-seller called The Hitchhiker's Guide to the Galaxy (standard level),
our most mind-boggling story, co-authored by the equally mind-boggling
Douglas Adams. Planetfall (standard level) teleports you 120 centuries
into the future and maroons you on a deserted planet with a friendly
little robot named Floyd. In Starcross (expert level), you encounter a
gargantuan alien spaceship and come face-to-face with bizarre
intelligent creatures from all corners of the galaxy. And in Suspended
(expert level), while in a deep-freeze you manipulate six highly
specialized robots, who are as different from each other as they are
from you.|
|
We're constantly writing new stories of different genres and varying
difficulty levels. So there's always something new to try from Infocom!"
 CR CR CR>
	 <TELL
"YOU MAKE THE PICTURES|
|
You might be wondering why there are no pictures in our stories. The
reason is simple: we know we can't compete with your imagination.
Computer graphics can't match the image your mind will create when you
first encounter the nasty troll in Zork I. Or gaze out upon the vast
Egyptian desert in Infidel. Or walk into Linder's souvenir-filled
office in The Witness. Besides, graphics require a large amount of disk
space, so there is little room left for detailed text descriptions or
for a wide variety of choices at each move.|
|
Infocom stories give you rich, detailed descriptions of characters and
locations and the maximum amount of interaction, right from the start.
You'll become engrossed in your role as the main character. And your
imagination will create the pictures, just as it does when you read any
good book." CR CR CR>
	 <TELL
"YOU INFLUENCE THE PLOT|
|
Traditional fiction introduces you to another world. Interactive
fiction puts you right into that world, making you the main character
and letting you shape the course of events. You influence the story by
responding to it in the form of conversational English commands typed
into your computer. As in real life, what happens later on will depend
upon the decisions you make along the way.|
|
Infocom's sophisticated technology makes it easy for you to lose
yourself in our stories. The stories recognize nouns, verbs,
prepositions, adjectives and adverbs, thus allowing you to use
full-sentence commands. Less sophisticated games recognize only nouns
and verbs, requiring you to use two-word, noun/verb (\"LOOK BOOK\")
commands. Some other programs CLAIM to understand full sentences but
actually only pull out one or two words and discard the rest of the
command.|
|
For example, suppose you wanted to know how much money you had in a
certain story. You might type COUNT THE MONEY and you'd be told \"You
have $15 in your pocket.\" Great. But what if you wanted to count
something else, like the money in a piggy bank? You might type COUNT
THE MONEY IN THE PIGGY BANK; in a less sophisticated game, you'd be
told \"You have $15 in your pocket.\" Worse yet, if you typed COUNT THE
COOKIES IN THE COOKIE JAR, you'd be told \"You have $15 in your pocket.\"|
|
Infocom stories are smart. Your whole sentence is understood, not just
one or two words. So you can count your pennies in the piggy bank, you
can count your ice cubes, count your pink rubber duckies, count the dodo
birds under the sink ... and we won't tell you that you've got $15 in
your pocket." CR CR CR>
	 <TELL
"WE PUT YOU IN THE MOOD|
|
With Infocom stories, you explore bizarre new worlds, encounter
treacherous characters, and experience untold dangers. But we make sure
you're well taken care of before you go.|
|
We want you to know where you're going and how to get there. That's why
we bind a wealth of information into every Infocom package. For
example, the Nat'l Detective Gazette included with The Witness provides
tips for greenhorn detectives as well as a guide to the best watering
holes in L.A. Planetfall contains a Stellar Patrol recruitment
brochure. And Enchanter gives you a brief history of magic. Along with
these handy items comes a detailed down-to-earth instruction manual.|
|
A special recessed insert in the back of each package contains other
items to accompany you on your interactive journey. For example,
Planetfall includes a copy of your diary on the Stellar Patrol Ship
Feinstein, a plastic Stellar Patrol I.D. card, and three souvenir
postcards from outer space. Infidel contains a map of the Nile River
Valley, a hieroglyphic stone rubbing, and a two-page letter with an
envelope bearing an authentic Egyptian stamp." CR CR CR>
	 <TELL
"WE'LL HELP YOU OUT|
|
There's a solution to every Infocom problem and a way through every
Infocom maze. But sometimes even the most brilliant adventurer gets
stumped. That's when InvisiClues Hint Books and Maps come in handy.
They're the only hints written by the same people who write our
interactive stories, so you know they're complete, accurate, witty and
fun. And they're the only ones with the amazing InvisiClues invisible
ink process that gives you only as much of a hint as you need, when you
need it -- without revealing anything that might spoil your enjoyment of
the story.|
|
InvisiClues Hint Books and Maps are also a great source of fun for those
who have successfully completed our interactive stories. After all,
it's virtually impossible to experience everything that can happen in an
Infocom story the first time you venture through it. But with our
hints, and particularly with the \"For Your Amusement\" section of the
hint books, you'll be able to extract full enjoyment from each story.|
|
There's an InvisiClues Hint Book for every Infocom story, each
containing hundreds of valuable hints. And each hint book comes with a
handsomely illustrated, informative map (except Seastalker and Suspended
for which maps are included in the story package).|
|
The greatest pleasure to be gained from an Infocom story is in solving
the puzzles and problems all on your own. So please don't turn to any
hints until you've exhausted all other alternatives. But when you do
need help, we recommend the hint books written by the people who write
the stories. Infocom InvisiClues Hint Books are available for $7.95 at
your local software store. You can also order InvisiClues by writing to
Infocom Fulfillment, P.O. Box 478, Cresskill, NJ 07626, or by calling
1-800-262-6868.|
|
Here's another number to remember: 617-576-3190. It's a direct line to
our dedicated Infocom Customer Support representatives, who will help
you solve technical problems." CR CR CR>
	 <TELL
"HERE'S HOW TO GET A FREE SUBSCRIPTION TO THE NEW ZORK TIMES|
|
Now that you've discovered our interactive fiction, wouldn't you like
to become an Infocom Insider? To learn of our latest breakthroughs? To
find out how an interactive story is made? To get first chance at
special offers and try your hand at fiendish puzzles?|
|
You can also read about our strange birthday parties! Why an army of
Infocom employees spent endless weekends in a dusty warehouse! Whether
wild yaks are an endangered species!|
|
You'll find such juicy tidbits of gossip and information in every issue
of The New Zork Times. And a subscription is yours -- absolutely free! --
when you mail in the completed warranty/registration card from any
full-length Infocom title.">>

<ROOM BULLSHIT-LAND
      (IN ROOMS)
      (DESC "You Asked for It")>