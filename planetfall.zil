"PLANETFALL for
				SAMPLER
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<OBJECT LIGHTS
	(IN LOCAL-GLOBALS)
	(SYNONYM LIGHT LIGHTS)
	(ADJECTIVE RED DAZZLI GLOWIN BLINKI WARNIN BRIGHT COLORE FLASHI)
	(DESC "light")
	(FLAGS NDESCBIT)>

<OBJECT GLOBAL-DOORWAY
	(IN GLOBAL-OBJECTS)
	(SYNONYM DOORWA PORTAL OPENIN)
	(ADJECTIVE NORTH SOUTH EAST WEST NE SE NW SW)
	(DESC "doorway")
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-DOORWAY-F)>

<ROUTINE GLOBAL-DOORWAY-F ()
	 <COND (<VERB? THROUGH>
		<USE-DIRECTIONS>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Can't see much from here. Try going there." CR>)>>

<ROUTINE HANDS-F ()
	 <COND (<VERB? SHAKE> ;"add this clause to HANDS-F"
		<TELL "There's no one to shake hands with." CR>)
	       (<VERB? PUT>
		<PERFORM ,V?RUB ,PRSI>
		<RTRUE>)
	       (<VERB? WAVE>
		<TELL "If you want to wave at something, say so." CR>)>>

<OBJECT TABLES
	(IN LOCAL-GLOBALS)
	(DESC "table")
	(SYNONYM TABLE TABLES)
	(FLAGS NDESCBIT)
	(ADJECTIVE ROUND CONFERENCE SMALL WIDE LONG)
	(ACTION TABLES-F)>

<ROUTINE TABLES-F ()
	 <COND (<AND <VERB? LOOK-UNDER>
		     <EQUAL? ,HERE ,MESS-HALL>>
		<TELL
"Wow!!! Under the table are three keys, a sack of food, a reactor elevator
access pass, one hundred gold pieces ... Just kidding. Actually, there's
nothing there." CR>)
	       (<AND <VERB? PUT-ON>
		     <EQUAL? ,PRSI ,TABLES>>
		<TELL "That would accomplish nothing useful." CR>)>> 

<OBJECT SHELVES
	(IN LOCAL-GLOBALS)
	(SYNONYM SHELF SHELVES)
	(DESC "shelf")
	(FLAGS NDESCBIT)
	(ACTION SHELVES-F)>

<ROUTINE SHELVES-F ()
	 <COND (<VERB? EXAMINE LOOK-ON>
		<TELL "The shelves are pretty dusty." CR>)
	       (<AND <VERB? PUT-ON>
		     <EQUAL? ,PRSI ,SHELVES>>
		<TELL "That would be a waste of time." CR>)>>

<OBJECT CONTROLS
	(IN LOCAL-GLOBALS)
	(SYNONYM CONTRO PANEL DIALS GAUGES)
	(ADJECTIVE CONTRO COMPLEX)
	(DESC "set of controls")
	(FLAGS NDESCBIT)
	(ACTION CONTROLS-F)>

<ROUTINE CONTROLS-F ()
	<COND (<EQUAL? ,HERE ,REACTOR-ELEVATOR>
	       <COND (<VERB? EXAMINE>
		      <TELL
"The control panel is a simple one, as described. Just a small slot
and two buttons." CR>)>)
	      (<VERB? RUB MOVE TURN ;SET TAKE EXAMINE PUSH ;PULL>
	       <TELL
"The controls are incredibly complicated and you shouldn't even
be thinking about touching them." CR>)>>

<OBJECT GLOBAL-GAMES
	(IN GLOBAL-OBJECTS)
	(DESC "game")
	(SYNONYM BOCCI CHESS HIDER HUCKA)
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-GAMES-F)>

<ROUTINE GLOBAL-GAMES-F ()
	 <COND (<VERB? PLAY>
		<COND (<IN? ,FLOYD ,HERE>
		       <PERFORM ,V?PLAY-WITH ,FLOYD>
		       <RTRUE>)
		      (T
		       <TELL "Okay. Gee, that was fun." CR>)>)>>

<OBJECT SLEEP
	(IN GLOBAL-OBJECTS)
	(DESC "sacred act of sleeping")
	(SYNONYM SLEEP)
	(FLAGS NDESCBIT)
	(ACTION SLEEP-F)>

<ROUTINE SLEEP-F ()
	 <COND (<VERB? WALK-TO>
		<V-SLEEP>)>>

<GLOBAL INTERNAL-MOVES 0>

<OBJECT CHRONOMETER
	(IN LOCAL-GLOBALS)
	(DESC "chronometer")
	(SYNONYM CHRONOMETER WRISTWATCH WATCH)
	(ADJECTIVE WRIST)
	(SIZE 10)
	(FLAGS TAKEBIT WEARBIT WORNBIT)
	(ACTION CHRONOMETER-F)>

<ROUTINE CHRONOMETER-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"It is a standard wrist chronometer with a digital display. ">
		<TELL-TIME>
		<TELL " The back is engraved with
the message \"Good luck in the Patrol! Love, Mom and Dad.\"" CR>)>>

<ROUTINE TELL-TIME ()
	 <TELL "According to the chronometer, the current time is ">
	 <COND (<FSET? ,CHRONOMETER ,RMUNGBIT>
		<TELL N ,MUNGED-TIME>)
	       (T
		<TELL N ,INTERNAL-MOVES>)>
	 <TELL ".">>

<GLOBAL MUNGED-TIME 0>

<OBJECT ID-CARD
	(IN PATROL-UNIFORM)
	(DESC "Patrol ID card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE PATROL ID IDENTIFICATION)
	(FLAGS TAKEBIT READBIT)
	(SIZE 3)
	(TEXT
"\"STELLAR PATROL|
Special Assignment Task Force|
ID Number:  6172-531-541\"")>  

<OBJECT PATROL-UNIFORM
	;(IN ADVENTURER)
	(DESC "Patrol uniform")
	(LDESC
"A slightly wrinkled Patrol uniform is lying here.")
	(SYNONYM UNIFORM POCKET SUIT)
	(ADJECTIVE PATROL WRINKLED)
        (FLAGS TAKEBIT WORNBIT WEARBIT CONTBIT SEARCHBIT OPENBIT)
	(CAPACITY 9 ;10) ;"so box won't fit -JW 3/11/85"
	(ACTION PATROL-UNIFORM-F)>

<ROUTINE PATROL-UNIFORM-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It is a standard-issue one-pocket Stellar Patrol uniform, a miracle of modern
technology. It will keep its owner warm in cold climates and cool in warm
locales. It provides protection against mild radiation, repels all insects,
absorbs sweat, promotes healthy skin tone, and on top of everything else,
it is super-comfy. There are definitely worse things to find yourself wearing
when stranded on a strange planet." CR>)
	       (<AND <VERB? TAKE-OFF>
		     <FSET? ,PATROL-UNIFORM ,WORNBIT>>
		<FCLEAR ,PATROL-UNIFORM ,WORNBIT>
		<TELL
"You have removed your Patrol uniform. You suddenly realize how warm it is.
You also feel naked and vulnerable." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"There's no way to open or close the pocket of the " D ,PRSO "." CR>)>>

<OBJECT FOOD-KIT
	(DESC "survival kit")
	(SYNONYM PROVISIONS KIT)
	(ADJECTIVE SURVIVAL EMERGENCY)
	(SIZE 10)
	(CAPACITY 25)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)>

<OBJECT RED-GOO
	(IN FOOD-KIT)
	(DESC "blob of red goo")
	(SYNONYM GOO BLOB FOOD PIE)
	(ADJECTIVE RED CHERRY)
	(FLAGS FOODBIT)
	(ACTION GOO-F)>

<OBJECT BROWN-GOO
	(IN FOOD-KIT)
	(DESC "blob of brown goo")
	(SYNONYM GOO BLOB FOOD PUDDIN)
	(ADJECTIVE BROWN NEBULA FUNGUS)
	(FLAGS FOODBIT)
	(ACTION GOO-F)>

<OBJECT GREEN-GOO
	(IN FOOD-KIT)
	(DESC "blob of green goo")
	(SYNONYM GOO BLOB FOOD BEANS)
	(ADJECTIVE GREEN LIMA)
	(FLAGS FOODBIT)
	(ACTION GOO-F)>

<ROUTINE GOO-F ()
	<COND (<VERB? EAT>
	       <COND (<EQUAL? ,HUNGER-LEVEL 0>
		      <TELL ,NOT-HUNGRY CR>) 
		     (<AND <NOT <IN? ,FOOD-KIT ,ADVENTURER>>
			   <NOT <IN? <LOC ,FOOD-KIT> ,ADVENTURER>>>
		      <SETG PRSO ,FOOD-KIT>
		      <NOT-HOLDING ,FOOD-KIT>
		      <THIS-IS-IT ,FOOD-KIT>)
		     (T
		      <REMOVE ,PRSO>
		      <SETG C-ELAPSED 15>
		      <SETG HUNGER-LEVEL 0>
		      <ENABLE <QUEUE I-HUNGER-WARNINGS 1450>>
		      <TELL "Mmmm...that tasted just like ">
		      <COND (<EQUAL? ,PRSO ,BROWN-GOO>
			     <TELL "delicious Nebulan fungus pudding">)
			    (<EQUAL? ,PRSO ,RED-GOO>
			     <TELL "scrumptious cherry pie">)
			    (T
			     <TELL "yummy lima beans">)>
		      <TELL "." CR>)>)
	      (<VERB? DROP PUT>
	       <TELL
"The goo, being gooey, sticks to the inside of the kit. You would probably
have to shake the kit to get the goo out." CR>)
	      (<VERB? TAKE>
	       <TELL
"It would ooze through your fingers. You'll have to eat it right
from the survival kit." CR>)>>

;"COMPONE stuff"

<ROOM DORM-C
      (IN ROOMS)
      (DESC "Dorm C")
      (LDESC
"This is a very long room lined with multi-tiered bunks. Flimsy partitions
between the tiers may have provided a modicum of privacy. These spartan
living quarters could have once housed many hundreds, but it seems quite
deserted now. There are openings at the north and south ends of the room.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO DORM-CORRIDOR)
      (SOUTH TO SANFAC-C)
      (FLAGS ONBIT FLOYDBIT RLANDBIT)
      (GLOBAL BED)
      (PSEUDO "PARTITION" PARTITION-PSEUDO)>

<ROOM SANFAC-C
      (IN ROOMS)
      (DESC "SanFac C")
      (LDESC
"This must be the sanitary facility for the adjacent dormitory. The fixtures
are dry and dusty, the room dead and deserted. You marvel at how little the
millenia and cultural gulfs have changed toilet bowl design. The only exit is
north.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO DORM-C)
      (FLAGS FLOYDBIT ONBIT RLANDBIT)
      (PSEUDO "FIXTURES" TOILET-PSEUDO "TOILET" TOILET-PSEUDO)>

<ROOM DORM-D
      (IN ROOMS)
      (DESC "Dorm D")
      (LDESC
"This is a very long room lined with multi-tiered bunks. Flimsy partitions
between the tiers may have provided a modicum of privacy. These spartan
living quarters could have once housed many hundreds, but it seems quite
deserted now. There are openings at the north and south ends of the room.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH TO DORM-CORRIDOR)
      (NORTH TO SANFAC-D)
      (FLAGS FLOYDBIT ONBIT RLANDBIT)
      (GLOBAL BED)
      (PSEUDO "PARTITION" PARTITION-PSEUDO)>

<ROOM SANFAC-D
      (IN ROOMS)
      (DESC "SanFac D")
      (LDESC
"This must be the sanitary facility for the adjacent dormitory. The fixtures
are dry and dusty, the room dead and deserted. You marvel at how little the
millenia and cultural gulfs have changed toilet bowl design. The only exit is
south.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH TO DORM-D)
      (FLAGS ONBIT FLOYDBIT RLANDBIT)
      (PSEUDO "FIXTURES" TOILET-PSEUDO "TOILET" TOILET-PSEUDO)>

<ROOM MESS-CORRIDOR
      (IN ROOMS)
      (DESC "Mess Corridor")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH TO MESS-HALL)
      (NORTH TO STORAGE-WEST IF STORAGE-WEST-DOOR IS OPEN)
      (EAST TO DORM-CORRIDOR)
      (WEST "In the real Planetfall, there's more in that direction, but it's
not included in this excerpt.")
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL STORAGE-WEST-DOOR)
      (ACTION MESS-CORRIDOR-F)>

<ROUTINE MESS-CORRIDOR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a wide, east-west hallway with a large portal to the south. A
small door to the north is ">
		<DDESC ,STORAGE-WEST-DOOR>
		<COND (<NOT ,PADLOCK-REMOVED>
		       <TELL " and hooked with a simple steel padlock">
		       <COND (<FSET? ,PADLOCK ,OPENBIT>
			      <TELL " which hangs unlocked">)
			     (T
			      <TELL " which is also closed">)>)>
		<TELL "." CR>)>>

<OBJECT STORAGE-WEST-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "door")
	(SYNONYM DOOR)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION STORAGE-WEST-DOOR-F)>

<ROUTINE STORAGE-WEST-DOOR-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,STORAGE-WEST-DOOR ,OPENBIT>
		       <ALREADY-OPEN>)
		      (,PADLOCK-REMOVED
		       <FSET ,STORAGE-WEST-DOOR ,OPENBIT>
		       <TELL "Opened." CR>)
		      (T
		       <TELL 
"The door cannot be opened until the padlock is removed." CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,STORAGE-WEST-DOOR ,OPENBIT>
		       <FCLEAR ,STORAGE-WEST-DOOR ,OPENBIT>
		       <TELL "The door is now closed." CR>)
		      (T
		       <IS-CLOSED>)>)
	       (<VERB? UNLOCK>
		<TELL "The door itself isn't locked.">
		<COND (<NOT <FSET? ,PADLOCK ,OPENBIT>>
		       <TELL
" It is the padlock on the door which is locked.">)>
		<TELL CR>)>>

<OBJECT PADLOCK
	(IN MESS-CORRIDOR)
	(DESC "padlock")
	(SYNONYM PADLOC PAD LOCK)
	(ADJECTIVE SIMPLE STEEL METAL)
	(SIZE 10)
	(FLAGS NDESCBIT TAKEBIT TRYTAKEBIT)
	(ACTION PADLOCK-F)>

<GLOBAL PADLOCK-REMOVED <>> ;"is the padlock still on the door?"

<ROUTINE PADLOCK-F ()
	 <COND (<AND <VERB? UNLOCK>
		     <EQUAL? ,PADLOCK ,PRSO>
		     <NOT ,PRSI>>
		<PERFORM ,V?UNLOCK ,PADLOCK ,HANDS>
		<RTRUE>)
	       (<VERB? UNLOCK OPEN>
		<COND (<NOT <FSET? ,PADLOCK ,OPENBIT>>
		       <COND (<NOT ,PRSI>
			      <TELL "You can't open it with your hands." CR>)
			     (<EQUAL? ,PRSI ,PF-KEY>
			      <COND (<FSET? ,PADLOCK ,RMUNGBIT>
			             <TELL
"Tsk, tsk ... the padlock seems to be fused shut." CR>)
				    (T
				     <FSET ,PADLOCK ,OPENBIT>
				     <TELL "The padlock springs open." CR>)>)
			     (T
			      <TELL "That doesn't work." CR>)>)
		      (T
		       <TELL "The padlock is already unlocked." CR>)>)
	       (<VERB? CLOSE LOCK>
		<COND (<EQUAL? ,PRSI ,PADLOCK>
		       <TELL "One step at a time." CR>)
		      (<FSET? ,PADLOCK ,OPENBIT>
		       <FCLEAR ,PADLOCK ,OPENBIT>
		       <TELL "The padlock closes with a sharp click." CR>)
		      (T
		       <TELL "The padlock is already locked." CR>)>)
	       (<VERB? UNTIE>
		<PERFORM ,V?TAKE ,PADLOCK>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT ,PADLOCK-REMOVED>>
		<COND (<FSET? ,PADLOCK ,OPENBIT>
		       <SETG PADLOCK-REMOVED T>
		       <FCLEAR ,PADLOCK ,TRYTAKEBIT>
		       <FCLEAR ,PADLOCK ,NDESCBIT>
		       <RFALSE>)
		      (<NOT <FSET? ,PADLOCK ,OPENBIT>>
		       <TELL "The padlock is locked to the door." CR>)>)
	       (<VERB? MUNG>
		<TELL
"And, as we go into the next round, it's Padlock 1, Adventurer 0..." CR>)>>

<ROOM STORAGE-WEST
      (IN ROOMS)
      (DESC "Storage West")
      (LDESC
"This is a small room obviously intended as a storage area.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH TO MESS-CORRIDOR IF STORAGE-WEST-DOOR IS OPEN)
      (OUT TO MESS-CORRIDOR IF STORAGE-WEST-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (VALUE 4)
      (GLOBAL SHELVES STORAGE-WEST-DOOR)>

<OBJECT CAN
	(IN STORAGE-WEST)
	(DESC "tin can")
	(LDESC 
"There is a large tin can, labelled \"Spam and Egz,\" sitting here.")
	(FDESC
"On a small shelf is a large, unopened tin can. It has a plain white
label which reads \"Spam and Egz.\"")
	(SIZE 15)
	(SYNONYM CAN)
	(ADJECTIVE LARGE TIN UNOPENED)
	(FLAGS TAKEBIT)
	(ACTION CAN-F)>

<ROUTINE CAN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a rather normal tin can. It is large and is labelled \"Spam
and Egz.\"" CR>)
	       (<VERB? OPEN>
		<TELL
"You certainly can't open it with your hands, and you don't seem to have
found a can opener yet." CR>)>> 

<OBJECT LADDER
	(IN STORAGE-WEST)
	(DESC "ladder")
	(FDESC
"A heavy-duty extendable ladder is leaning against the rear wall.")
	(LDESC
"There is a large aluminum ladder here.")
	(SYNONYM LADDER)
	(ADJECTIVE HEAVY DUTY ALUMINUM LARGE)
	(SIZE 80)
	(FLAGS TAKEBIT)
	(ACTION LADDER-F)>

<GLOBAL LADDER-EXTENDED <>> ;"is the ladder extended?"

<GLOBAL LADDER-FLAG <>> ;"is the ladder spanning the rift?"

<ROUTINE LADDER-F ()
	 <COND (<VERB? TAKE>
		<COND (,LADDER-EXTENDED
		       <TELL
"You can't possibly carry the ladder while it's extended." CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"It is a heavy-duty ladder built of sturdy aluminum tubing. It is currently ">
		<COND (,LADDER-EXTENDED
		       <TELL
"extended to its full length of about 8 meters, but could be collapsed to
a shorter length for easier carrying." CR>)
		      (T
		       <TELL
"collapsed and is around two-and-a-half meters long, but if extended would
obviously be much longer." CR>)>)
	       (<VERB? OPEN UNFOLD>
		<COND (,LADDER-EXTENDED
		       <TELL "The ladder is already extended." CR>)
		      (T
		       <COND (<IN? ,LADDER ,ADVENTURER>
			      <LADDER-LOSE "you're">)
			     (<IN? ,LADDER ,FLOYD>
			      <LADDER-LOSE "Floyd is">)
			     (T
			      <FSET ,LADDER ,TRYTAKEBIT>
			      <SETG LADDER-EXTENDED T>
			      <SETG C-ELAPSED 36>
			      <TELL
"The ladder extends to a length of around eight meters." CR>)>)>)
	       (<VERB? CLOSE>
		<COND (,LADDER-EXTENDED
		       <SETG C-ELAPSED 21>
		       <COND (,LADDER-FLAG
			      <SETG LADDER-FLAG <>>
			      <REMOVE ,LADDER>
			      <TELL
"As the ladder shortens it plunges into the rift." CR>)
			     (T
			      <SETG LADDER-EXTENDED <>>
			      <FCLEAR ,LADDER ,TRYTAKEBIT>
			      <TELL
"The ladder collapses to a length of around two-and-a-half meters." CR>)>)
		      (T
		       <TELL
"The ladder is already in its collapsed state." CR>)>)
	       (<AND <VERB? SPAN ATTRACT>
		     <EQUAL? ,PRSI ,RIFT>>
		<COND (,LADDER-FLAG
		       <TELL "The ladder already spans the rift." CR>)
		      (T
		       <COND (,LADDER-EXTENDED
			      <SETG LADDER-FLAG T>
			      <FSET ,LADDER ,NDESCBIT>
			      <TELL
"The ladder swings out across the rift and comes to rest on the far edge,
spanning the precipice." CR>)
			     (T
			      <REMOVE ,LADDER>
			      <TELL
"The ladder, far too short to reach the other edge of the rift, plunges into
the rift and is lost forever." CR>)>)>)
	       (<VERB? CLIMB-UP CLIMB-FOO>
		<COND (,LADDER-FLAG
		       <TELL "You can't climb a horizontal ladder!" CR>)
		      (<IN? ,LADDER ,ADVENTURER>
		       <TELL
"That would be a neat trick, considering that you're holding it." CR>)>)
	       (<AND <VERB? CROSS THROUGH>
		     ,LADDER-FLAG>
		<DO-WALK ,P?NORTH>)>>

<ROUTINE LADDER-LOSE (STR)
	 <TELL
"You couldn't possibly extend the ladder while ".STR " holding it." CR>>

<ROOM DORM-CORRIDOR
      (IN ROOMS)
      (DESC "Dorm Corridor")
      (LDESC
"This is a wide, east-west hallway with openings to the north and south.
To the east, the corridor stretches off into the distance. That section of
the hallway is lined with a motorized walkway (no longer running) that
was probably intended to transport people or cargo down that tremendously
long hall.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 160 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO DORM-D)
      (SOUTH TO DORM-C)
      (WEST TO MESS-CORRIDOR)
      (EAST PER LONG-HALL-F)
      (FLAGS ONBIT RLANDBIT)
      (PSEUDO "WALKWAY" WALKWAY-PSEUDO)>

<ROOM MESS-HALL
      (IN ROOMS)
      (DESC "Mess Hall")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO MESS-CORRIDOR)
      (OUT TO MESS-CORRIDOR)
      (SOUTH TO KITCHEN IF KITCHEN-DOOR IS OPEN)
      (IN TO KITCHEN IF KITCHEN-DOOR IS OPEN)
      (GLOBAL TABLES KITCHEN-DOOR SLOT)
      (FLAGS ONBIT FLOYDBIT RLANDBIT)
      (PSEUDO "BENCH" BENCH-PSEUDO "BENCHE" BENCH-PSEUDO)
      (ACTION MESS-HALL-F)>

<ROUTINE MESS-HALL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large hall lined with tables and benches. An opening to the north
leads back to the corridor. A door to the south is ">
		<DDESC ,KITCHEN-DOOR>
		<TELL ". Next to the door is a small slot." CR>)>>

<OBJECT KITCHEN-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "door")
	(SYNONYM DOOR)
	(ADJECTIVE KITCHEN)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION KITCHEN-DOOR-F)>

<ROUTINE KITCHEN-DOOR-F ()
	 <COND (<VERB? OPEN>
	        <TELL
"A light flashes \"Pleez yuuz kitcin akses kard.\"" CR>)>>

<OBJECT PF-CANTEEN
	(IN MESS-HALL)
	(DESC "canteen")
	(FDESC 
"Although the room is quite barren, an octagonally-shaped
canteen is sitting on one of the benches.")
	(SYNONYM CANTEE)
	(ADJECTIVE OCTAGONAL)
	(CAPACITY 5)
	(SIZE 10)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)>

<ROUTINE WORTHLESS-ACTION ()
	 <TELL
"A worthless action -- and much more difficult than the author is willing to
implement." CR>>

<ROOM CORRIDOR-JUNCTION
      (IN ROOMS)
      (DESC "Corridor Junction")
      (LDESC
"A north-south corridor intersects the main corridor here. To the west, the
main corridor extends as far as you can see; a non-working walkway from
that direction ends here. To the east, the corridor widens into a well-lit
area.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 160 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST"  30 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO ADMIN-CORRIDOR-S)
      (SOUTH TO MECH-CORRIDOR-N)
      (WEST PER LONG-HALL-F)
      (EAST "In the real Planetfall, there's more in that direction, but it's
not included in this excerpt.")
      (FLAGS FLOYDBIT RLANDBIT ONBIT)
      (PSEUDO "WALKWAY" WALKWAY-PSEUDO)>

<ROUTINE LONG-HALL-F ()
	 <TELL
"You walk down the long, featureless hallway for a long time. Finally,
you see ">
	 <SETG C-ELAPSED 160>
	 <COND (<EQUAL? ,HERE ,CORRIDOR-JUNCTION>
		<TELL "some doorways ahead..." CR CR>
		,DORM-CORRIDOR)
	       (T
		<TELL "an intersection ahead..." CR CR>
		,CORRIDOR-JUNCTION)>>
		
<ROOM ADMIN-CORRIDOR-S
      (IN ROOMS)
      (DESC "Admin Corridor South")
      (LDESC
"This section of hallway seems to have suffered some minor structural
damage. The walls are cracked, and a jagged crevice crosses the floor.
An opening leads east and the corridor heads north and south.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH TO CORRIDOR-JUNCTION)
      (NORTH TO ADMIN-CORRIDOR)
      (EAST TO SANFAC-E)
      (FLAGS RLANDBIT ONBIT)
      (ACTION ADMIN-CORRIDOR-S-F)>

<ROUTINE ADMIN-CORRIDOR-S-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <FSET? ,PF-KEY ,INVISIBLE>
		     <PROB 50>>
		<TELL
"You catch, out of the corner of your eye, a glint of light from the direction
of the floor." CR>)>>

<OBJECT CREVICE
	(IN ADMIN-CORRIDOR-S)
	(DESC "crevice")
	(SYNONYM CREVICE CRACK HOLE)
	(ADJECTIVE NARROW JAGGED)
	(FLAGS NDESCBIT)
	(ACTION CREVICE-F)>

<ROUTINE CREVICE-F ()
	 <COND (<VERB? REACH>
		<TELL "The crevice is too narrow to reach into." CR>)
	       (<VERB? LOOK-INSIDE EXAMINE SEARCH>
		<COND (<FSET? ,PF-KEY ,TOUCHBIT>
		       <TELL "Nothing there but bunches of dust." CR>)
		      (T
		       <FCLEAR ,PF-KEY ,INVISIBLE>
		       <TELL
"Lying at the bottom of the narrow crack, partly covered by layers of dust,
is a shiny steel key!" CR>)>)>>

<ROUTINE DUST-F ()
	 <COND (<VERB? LOOK-UNDER>
		<COND (<AND <EQUAL? ,HERE ,ADMIN-CORRIDOR-S>
			    <NOT <FSET? ,PF-KEY ,INVISIBLE>>
			    <NOT <FSET? ,PF-KEY ,TOUCHBIT>>>
		       <TELL "A shiny steel key lies under the dust." CR>)
		      (T
		       <TELL "There is nothing but more dust there." CR>)>)>>

<OBJECT PF-KEY
	(IN ADMIN-CORRIDOR-S)
	(DESC "key")
	(FDESC "Lying at the bottom of a narrow crevice is a shiny object.")
	(SIZE 3)
	(SYNONYM KEY METAL OBJECT)
	(ADJECTIVE PIECE STEEL IRON SHINY)
	(FLAGS TAKEBIT TOOLBIT INVISIBLE TRYTAKEBIT)
	(ACTION PF-KEY-F)>

<ROUTINE PF-KEY-F ()
	 <COND (<AND <VERB? TAKE ZATTRACT MOVE>
		     <NOT <FSET? ,PF-KEY ,TOUCHBIT>>>
	        <COND (<EQUAL? ,PRSI ,PLIERS>
		       <TELL
"These are heavy-duty pliers, too large to reach into this narrow crack." CR>)
		      (<EQUAL? ,PRSI ,MAGNET>
		       <PERFORM ,V?ATTRACT ,MAGNET ,PF-KEY>
		       <RTRUE>)
		      (,PRSI
		       <TELL "Nice try." CR>)
		      (T
		       <TELL
"Either the crevice is too narrow, or your fingers are too large." CR>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,CREVICE>>
		<TELL
"And you wonder why you're still only an Ensign Seventh Class?" CR>)>>

<ROOM ADMIN-CORRIDOR
      (IN ROOMS)
      (DESC "Admin Corridor") 
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH TO ADMIN-CORRIDOR-S)
      (NORTH PER LADDER-EXIT-F)
      (WEST TO SYSTEMS-MONITORS)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL RIFT)
      (PSEUDO "RUBBLE" RUBBLE-PSEUDO)
      (ACTION ADMIN-CORRIDOR-F)>

<ROUTINE ADMIN-CORRIDOR-F (RARG)
	 <COND (<AND ,LADDER-FLAG
		     <EQUAL? .RARG ,M-ENTER>>
		<MOVE ,LADDER ,HERE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"The hallway, in fact the entire building, has been rent apart here, presumably
by seismic upheaval. You can see the sky through the severed roof above, and
the ground is thick with rubble. To the north is a gaping rift, at least eight
meters across and thirty meters deep. ">
		<COND (,LADDER-FLAG
		       <TELL "A metal ladder spans the rift. ">)>
		<TELL
"A wide doorway, labelled \"Sistumz Moniturz,\" leads west." CR>)>>

<ROUTINE LADDER-EXIT-F ()
	 <COND (,LADDER-FLAG
		<SETG C-ELAPSED 33>
		<TELL
"You slowly make your way across the swaying ladder. You can see sharp,
pointy rocks at the bottom of the rift, far below..." CR CR>
		<END-PLANETFALL>
		<RFALSE>)
	       (T
		<TELL "The rift is too wide to jump across." CR>
		<RFALSE>)>>

<OBJECT RIFT
	(IN LOCAL-GLOBALS)
	(DESC "rift")
	(SYNONYM RIFT GULF PRECIPICE HOLE)
	(ADJECTIVE WIDE DEEP GAPING)
	(FLAGS NDESCBIT)
	(ACTION RIFT-F)>

<ROUTINE RIFT-F ()
	 <COND (<VERB? LEAP>
		<JIGS-UP
"You get a brief (but much closer) view of the sharp and nasty rocks at
the bottom of the rift.">)
	       (<AND <VERB? PUT>
		     <EQUAL? ,RIFT ,PRSI>>
		<REMOVE ,PRSO>
		<TELL "The " D, PRSO " sails gracefully into the rift." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The rift is at least eight meters wide and more than thirty meters deep. The
bottom is covered with sharp and nasty rocks." CR>)
	       (<AND <VERB? CROSS>
		     ,LADDER-FLAG>
		<DO-WALK ,P?NORTH>)>>

<ROOM SANFAC-E
      (IN ROOMS)
      (DESC "SanFac E")
      (LDESC
"Here is another sanitary facility. Like the others, it is dusty and
non-functional.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO ADMIN-CORRIDOR-S)
      (OUT TO ADMIN-CORRIDOR-S)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)
      (PSEUDO "FIXTURES" TOILET-PSEUDO "TOILET" TOILET-PSEUDO)>

<ROOM SYSTEMS-MONITORS
      (IN ROOMS)
      (DESC "Systems Monitors")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO ADMIN-CORRIDOR)
      (OUT TO ADMIN-CORRIDOR)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)
      (GLOBAL TABLES)
      (PSEUDO "MONITORS" MONITORS-PSEUDO "EQUIPM" EQUIPMENT-PSEUDO)
      (ACTION SYSTEMS-MONITORS-F)>

<ROUTINE SYSTEMS-MONITORS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large room filled with tables full of strange equipment. ">
		<DESCRIBE-MONITORS>)>>

<ROUTINE DESCRIBE-MONITORS ()
	 <TELL
"The far wall is filled with a number of monitors. Of these, the ones
labelled LIIBREREE, REEAKTURZ, and LIIF SUPORT are green, but the ones
labelled PLANATEREE DEFENS, PLANATEREE KORS KUNTROOL, KUMUUNIKAASHUNZ,
and PRAJEKT KUNTROOL indicate a malfunctioning condition." CR>>

<OBJECT LOWER-ELEVATOR-CARD
	(DESC "lower elevator access card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE LOWER ELEVATOR ACCESS)
	(SIZE 3)
	(FLAGS TAKEBIT READBIT)
	(TEXT "The card is embossed \"loowur elivaatur akses kard\".")
	(VALUE 1)
	(ACTION LOWER-ELEVATOR-CARD-F)>

<ROUTINE LOWER-ELEVATOR-CARD-F ()
	 <COND (<OR ,P-XNAM			;"if input's not ELEVATOR"
		    <NOT <EQUAL? ,P-ADJN ,W?ELEVATOR>>>
		<RFALSE>)
	       (<OR <AND <VERB? BOARD CLIMB-ON THROUGH>
		     	 <EQUAL? ,HERE ,REACTOR-CONTROL>>
		    <AND <VERB? DISEMBARK DROP>
			 <EQUAL? ,HERE ,REACTOR-ELEVATOR>>>
		<SETG PRSO ,REACTOR-ELEVATOR-DOOR>
		<PERFORM ,V?THROUGH ,PRSO>
		<RTRUE>)>>

<ROOM MECH-CORRIDOR-N
      (IN ROOMS)
      (DESC "Mech Corridor North")
      (LDESC
"Entrances to rooms lie to the east and west from this north-south hall.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO STORAGE-EAST)
      (WEST TO PHYSICAL-PLANT)
      (NORTH TO CORRIDOR-JUNCTION)
      (SOUTH TO MECH-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)>

<ROOM MECH-CORRIDOR
      (IN ROOMS)
      (DESC "Mech Corridor")
      (LDESC
"Entrances to rooms lie to the east and west from this north-south hall.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO REACTOR-CONTROL)
      (WEST TO PHYSICAL-PLANT)
      (NORTH TO MECH-CORRIDOR-N)
      (SOUTH TO MECH-CORRIDOR-S)
      (FLAGS RLANDBIT ONBIT)>

<ROOM MECH-CORRIDOR-S
      (IN ROOMS)
      (DESC "Mech Corridor South")
      (LDESC
"The corridor ends here with doorways to the southwest, south, and southeast.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"  25  ;"SOUTH"  0 
	 ;"SE" 25 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO MECH-CORRIDOR)
      (SW TO TOOL-ROOM)
      (SOUTH TO MACHINE-SHOP)
      (SE TO ROBOT-SHOP)
      (FLAGS RLANDBIT ONBIT)>

<ROOM STORAGE-EAST
      (IN ROOMS)
      (DESC "Storage East")
      (LDESC
"A small room for storage. The exit is to the west.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO MECH-CORRIDOR-N)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (GLOBAL SHELVES)>

<OBJECT OIL-CAN
	(IN STORAGE-EAST)
	(DESC "oil can")
	(FDESC
"One dusty shelf, otherwise bare, holds a small oil can.")
	(SYNONYM CAN)
	(ADJECTIVE SMALL OIL)
	(SIZE 10)
	(FLAGS VOWELBIT TAKEBIT)
	(ACTION OIL-CAN-F)>

<ROUTINE OIL-CAN-F ()
	 <COND (<VERB? POUR POUR-ON POUR-IN>
		<COND (<NOT ,PRSI>
		       <SETG PRSI ,GROUND>)>
		<PERFORM ,V?OIL ,PRSI>
		<RTRUE>)>>

<OBJECT CARTON
	(IN STORAGE-EAST)
	(DESC "cardboard box")
	(FDESC
"On the floor beneath the shelves sits a small cardboard box.")
	(SYNONYM BOX CARTON)
	(ADJECTIVE SMALL CARDBOARD)
	(SIZE 10)
	(CAPACITY 50)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT OPENBIT)
	(ACTION CARTON-F)>

<ROUTINE CARTON-F ()
	 <COND (<VERB? CLOSE>
		<NO-CLOSE>
		<RTRUE>)>>

<OBJECT CRACKED-BOARD
	(IN CARTON)
	(DESC "cracked seventeen-centimeter fromitz board")
	(SYNONYM BOARD BOARDS)
	(ADJECTIVE CRACKED SEVENTEEN CENTIMETER FROMITZ)
	(SIZE 10)
	(FLAGS TAKEBIT)
	(ACTION CRACKED-BOARD-F)>

<ROUTINE CRACKED-BOARD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Like most fromitz boards, it is a twisted maze of silicon circuits. It is
square, approximately seventeen centimeters on each side. This one looks as
though it's been dropped." CR>)>>

<OBJECT MEGAFUSE-B
	(IN CARTON)
	(DESC "B-series megafuse")
	(SYNONYM FUSE MEGAFUSE)
	(ADJECTIVE B-SERIES B SERIES MEGA)
	(SIZE 5)
	(FLAGS TAKEBIT)>

<OBJECT MEGAFUSE-K
	(IN CARTON)
	(DESC "K-series megafuse")
	(SYNONYM FUSE MEGAFUSE)
	(ADJECTIVE K-SERIES K SERIES MEGA)
	(SIZE 5)
	(FLAGS TAKEBIT)>

<OBJECT GOOD-BEDISTOR
	(IN CARTON)
	(DESC "good ninety-ohm bedistor")
	(SYNONYM BEDISTOR)
	(ADJECTIVE GOOD NINETY OHM)
	(SIZE 8)
	(FLAGS TAKEBIT)>

<ROOM PHYSICAL-PLANT
      (IN ROOMS)
      (DESC "Physical Plant")
      (LDESC
"This is a huge, dim room with exits in the northeast and southeast
corners. The room is criss-crossed with catwalks and is filled with
heavy equipment presumably intended to heat and ventilate this complex.
Hardly any of the equipment is still operating.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NE TO MECH-CORRIDOR-N)
      (SE TO MECH-CORRIDOR)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)
      (PSEUDO "EQUIPM" EQUIPMENT-PSEUDO "CATWALK" CATWALK-PSEUDO)>

<ROOM REACTOR-CONTROL
      (IN ROOMS)
      (DESC "Reactor Control")
      (LDESC
"This room contains many dials and gauges for controlling a massive planetary
power reactor which, according to a diagram on the wall, must be buried far
below this very complex. The exit is to the west. To the east is a metal door,
and next to it, a button. A dark stairway winds downward.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN"20  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO MECH-CORRIDOR)
      (EAST TO REACTOR-ELEVATOR IF REACTOR-ELEVATOR-DOOR IS OPEN)
      (IN TO REACTOR-ELEVATOR IF REACTOR-ELEVATOR-DOOR IS OPEN)
      (DOWN TO REACTOR-ACCESS-STAIRS)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (PSEUDO "BUTTON" REACTOR-BUTTON-PSEUDO "DIAGRAM" DIAGRAM-PSEUDO)
      (GLOBAL CONTROLS STAIRS REACTOR-ELEVATOR-DOOR)>

<ROOM REACTOR-ACCESS-STAIRS
      (IN ROOMS)
      (DESC "Reactor Access Stairs")
      (LDESC "You have just located a serious bug.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"    30
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (DOWN TO REACTOR-ACCESS-STAIRS)
      (UP TO REACTOR-CONTROL)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)> 

<OBJECT REACTOR-ELEVATOR-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "reactor elevator door")
	(SYNONYM DOOR)
	(ADJECTIVE REACTOR ELEVATOR METAL)
	(FLAGS DOORBIT)
	(ACTION REACTOR-ELEVATOR-DOOR-F)>

<ROUTINE REACTOR-ELEVATOR-DOOR-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "It won't budge." CR>)
	       (<OR <AND <VERB? BOARD CLIMB-ON>
		     	 <EQUAL? ,HERE ,REACTOR-CONTROL>>
		    <AND <VERB? DISEMBARK>
			 <EQUAL? ,HERE ,REACTOR-ELEVATOR>>>
		<PERFORM ,V?THROUGH ,PRSO>
		<RTRUE>)>>

<ROUTINE I-REACTOR-DOOR-CLOSE ()
	 <ENABLE <QUEUE I-REACTOR-DOOR-CLOSE -1>>
	 <COND (<NOT <EQUAL? ,HERE ,REACTOR-ELEVATOR>>
		<FCLEAR ,REACTOR-ELEVATOR-DOOR ,OPENBIT>
		<COND (<EQUAL? ,HERE ,REACTOR-CONTROL>
		       <TELL "The elevator door slides shut." CR>)>
		<DISABLE <INT I-REACTOR-DOOR-CLOSE>>)>>

<ROOM REACTOR-ELEVATOR
      (IN ROOMS)
      (DESC "Reactor Elevator")
      (LDESC
"This is an elevator with a door to the west, currently open. A control panel
contains an Up button, a Down button, and a small slot.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO REACTOR-CONTROL IF REACTOR-ELEVATOR-DOOR IS OPEN)
      (OUT TO REACTOR-CONTROL)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL REACTOR-ELEVATOR-DOOR SLOT CONTROLS)> 

<OBJECT ELEVATOR-BUTTON
	(IN REACTOR-ELEVATOR)
	(DESC "button")
	(SYNONYM BUTTON)
	(FLAGS NDESCBIT)
        (ACTION ELEVATOR-BUTTON-F)>

<ROUTINE ELEVATOR-BUTTON-F ()
	 <COND (<VERB? PUSH-UP PUSH-DOWN>
		<TELL "Nothing happens." CR>)	       
	       (<VERB? PUSH>
		<TELL
"You must specify whether you want to push the Up button or
the Down button." CR>)>>

<ROOM TOOL-ROOM
      (IN ROOMS)
      (DESC "Tool Room")
      (LDESC
"This is apparently a storage room for tools. Exits lead northeast and east.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"  25  ;"NORTH"  0>)
      (NE TO MECH-CORRIDOR-S)
      (EAST TO MACHINE-SHOP)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (GLOBAL SHELVES)>

<OBJECT FLASK
	(IN TOOL-ROOM)
	(DESC "glass flask")
	(FDESC
"Sitting on the floor below the lowest shelf is a large glass flask.")
	(SYNONYM FLASK)
	(ADJECTIVE GLASS LARGE PLASTIC)
	(SIZE 10)
	(CAPACITY 2)
	(FLAGS CONTBIT SEARCHBIT OPENBIT TAKEBIT)
	(ACTION FLASK-F)>

<ROUTINE FLASK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The flask has a wide mouth and looks large enough to hold one or two liters.
It is made of glass, or perhaps some tough plastic">
		<COND (<IN? ,CHEMICAL-FLUID ,FLASK>
		       <TELL ", and is filled with a milky white fluid">)>
		<TELL "." CR>)
	       (<VERB? CLOSE>
		<NO-CLOSE>
		<RTRUE>)>>

<OBJECT LASER
	(IN TOOL-ROOM)
	(DESC "laser")
	(FDESC
"A small device, labelled \"Akmee Portabul Laazur\", is resting on one of
the lower shelves.")
	(SYNONYM DEVICE LASER UNIT DEPRES)
	(ADJECTIVE PORTABLE ACME SMALL)
	(SIZE 25)
	(CAPACITY 5)
	(FLAGS TAKEBIT OPENBIT TRANSBIT CONTBIT)
	(ACTION LASER-F)>

<OBJECT LASER-DIAL
	(IN LASER)
	(DESC "laser setting dial")
	(SYNONYM DIAL)
	(ADJECTIVE LASER SETTING)
	(FLAGS NDESCBIT TURNBIT)
	(ACTION LASER-DIAL-F)>

<ROUTINE LASER-DIAL-F ()
	 <COND (<AND <VERB? TURN>
		     <EQUAL? ,PRSI ,INTNUM>>
		<COND (<FSET? ,LASER-DIAL ,RMUNGBIT>
		       <TELL
"The laser dial seems to have become damaged and will not turn." CR>)
		      (<EQUAL? ,P-NUMBER ,LASER-SETTING>
		       <TELL "That's where it's set now!" CR>)
		      (<OR <G? ,P-NUMBER 6>
			   <EQUAL? ,P-NUMBER 0>>
		       <TELL "The dial can only be set from 1 to 6." CR>)
		      (T
		       <SETG LASER-SETTING ,P-NUMBER>
		       <TELL "The dial is now set to " N ,P-NUMBER "." CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"The dial is currently set to " N ,LASER-SETTING "." CR>)>>

<OBJECT OLD-BATTERY
	(IN LASER)
	(DESC "old battery")
	(LDESC "There is a worn-out laser battery here.")
	(SYNONYM BATTERY)
	(ADJECTIVE LASER WORN-OUT OLD)
	(SIZE 5)
	(FLAGS VOWELBIT TAKEBIT)>

<GLOBAL LASER-SETTING 5> ;"dial on laser -- 1 is red, 2 is orange, etc."

<GLOBAL OLD-SHOTS 2> ;"number of shots left in the old-battery"

<ROUTINE ZAP-COUNT () ;"checks to see if if have any shots left"
	 <COND (<AND <IN? ,OLD-BATTERY ,LASER>
		     <G? ,OLD-SHOTS 0>>
		<SETG OLD-SHOTS <- ,OLD-SHOTS 1>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE LASER-F ("OPTIONAL" (RARG <>))
	 <COND (<AND <VERB? TURN>
		     <EQUAL? ,PRSI ,INTNUM>>
		<PERFORM ,V?TURN ,LASER-DIAL ,PRSI>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"The laser, though portable, is still fairly heavy. It has a long, slender
barrel and a dial with six settings, labelled \"1\" through \"6.\" This dial
is currently on setting " N ,LASER-SETTING ". There is a depression on the
top of the laser which ">
		<COND (<IN? ,OLD-BATTERY ,LASER>
		       <TELL "contains an " D ,OLD-BATTERY>)
		      (T
		       <TELL "is empty">)>
		<TELL "." CR>)
	       (<AND <VERB? LOOK-INSIDE>
		     <NOT <IN? ,OLD-BATTERY ,LASER>>>
		<TELL "The depression is empty." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"There doesn't seem to be any way to do that to this laser." CR>)
	       (<VERB? PUT>
		<COND (<EQUAL? ,PRSO ,OLD-BATTERY>
		       <MOVE ,OLD-BATTERY ,LASER>
		       <TELL
"The battery is now resting in the depression, attached to the laser." CR>)
		      (<NOT <EQUAL? ,LASER ,PRSO>>
		       <TELL
"The " D ,PRSO " doesn't fit the depression." CR>)>)
	       (<VERB? ZAP>
		<COND (<NOT <IN? ,LASER ,ADVENTURER>>
		       <NOT-HOLDING ,LASER>
		       <RTRUE>)>
		<COND (<NOT ,LASER-SCORE-FLAG>
		       <SETG LASER-SCORE-FLAG T>
		       <SETG SCORE <+ ,SCORE 2>>)>
		<COND (<OR <EQUAL? ,PRSI ,LASER>
				  <EQUAL? ,PRSI ,LASER-DIAL>
				  <AND <EQUAL? ,PRSI ,OLD-BATTERY>
				       <IN? ,OLD-BATTERY ,LASER>>>
		       <TELL
"Sorry, the laser doesn't have a rubber barrel." CR>)
		      (<ZAP-COUNT>
		       <TELL "Click." CR>)
		      (<FSET? ,LASER ,RMUNGBIT>
		       <TELL
"The laser sparks a few times, whines, and then stops." CR>)
		      (T
		       <COND (<EQUAL? ,PRSI ,ME ,HANDS ,ADVENTURER>
			      <TELL
"Ouch! You managed to burn yourself nicely." CR>)
			     (T
			      <TELL "The laser emits a narrow ">
			      <BEAM-COLOR>
			      <TELL " beam of light">
			      <COND (,PRSI
				     <COND (<EQUAL? ,PRSI ,PATROL-UNIFORM
					         ,ID-CARD ,LOWER-ELEVATOR-CARD>
					    <REMOVE ,PRSI>
					    <TELL
" which strikes the " D ,PRSI ". The " D ,PRSI " bursts into flame,
blinding you momentarily, and is quickly consumed.">
					    <COND (<HELD? ,PRSI>
						   <JIGS-UP
" Since you have it, you are also quickly consumed.">)>
					    <CRLF>)
					   (<AND <EQUAL? ,PRSI ,FLOYD>
						 <FSET? ,FLOYD ,RLANDBIT>>
					    <TELL
" which strikes Floyd. \"Yow!\" yells Floyd. He jumps to the
other end of the room and eyes you warily." CR>)
					   (T
					    <TELL
" which strikes the " D ,PRSI ". The " D ,PRSI " grows a bit warm, but
nothing else happens." CR>)>)
				    (T
				     <TELL "." CR>)>)>)>)>>

<GLOBAL LASER-SCORE-FLAG <>>

<ROUTINE BEAM-COLOR ()
	 <COND (<EQUAL? ,LASER-SETTING 1>
	        <TELL "red">)
               (<EQUAL? ,LASER-SETTING 2>
	        <TELL "orange">)
	       (<EQUAL? ,LASER-SETTING 3>
		<TELL "yellow">)
	       (<EQUAL? ,LASER-SETTING 4>
	        <TELL "green">)
	       (<EQUAL? ,LASER-SETTING 5>
		<TELL "blue">)
	       (<EQUAL? ,LASER-SETTING 6>
		<TELL "violet">)>>

<OBJECT MAGNET
	(IN TOOL-ROOM)
	(SIZE 10)
	(DESC "curved metal bar")
	(FDESC "On an upper shelf is a metal bar, curved into a U-shape.")
	(SYNONYM MAGNET BAR)
	(ADJECTIVE CURVED METAL HORSESHOE)
	(FLAGS TRYTAKEBIT TAKEBIT)
	(ACTION MAGNET-F)>

<ROUTINE MAGNET-F ()
	 <COND (<VERB? TAKE>
		<ENABLE <QUEUE I-MAGNET -1>>
		<RFALSE>)
	       (<VERB? ATTRACT PUT-ON>
		<COND (<AND <EQUAL? ,PRSO ,MAGNET>
			    <NOT <IN? ,MAGNET ,ADVENTURER>>>
		       <NOT-HOLDING ,LASER>)
		      (<AND <FSET? ,PF-KEY ,TOUCHBIT>
			    <EQUAL? ,PRSI ,PF-KEY>>
		       <MOVE ,PF-KEY ,ADVENTURER>
		       <TELL
"The key jumps against the ends of the magnet and sticks there. Proud of your
feat, you remove the key from the magnet." CR>)
		      (<AND <NOT <FSET? ,PF-KEY ,TOUCHBIT>>
			    <EQUAL? ,PRSI ,PF-KEY ,CREVICE>>
		       <MOVE ,PF-KEY ,ADVENTURER>
		       <FCLEAR ,PF-KEY ,INVISIBLE>
		       <FCLEAR ,PF-KEY ,TRYTAKEBIT>
		       <FSET ,PF-KEY ,TOUCHBIT>
		       <TELL 
"With a spray of dust and a loud clank, a piece of metal leaps from the
crevice and affixes itself to the magnet. It is a steel key! With a tug,
you remove the key from the magnet." CR>)>)>>

<GLOBAL LOWER-CARD-SCRAMBLED <>>

<ROUTINE I-MAGNET ()
	 <COND (<IN? ,MAGNET ,ADVENTURER>
		<COND (;<IN? ,LOWER-ELEVATOR-CARD ,ADVENTURER>
		       <HELD? ,LOWER-ELEVATOR-CARD>
		       <SETG LOWER-CARD-SCRAMBLED T>)>)
	       (T
		<DISABLE <INT I-MAGNET>>)>
	 <RFALSE>>

<OBJECT PLIERS
	(IN TOOL-ROOM)
	(DESC "pair of wide-nosed pliers")
	(SYNONYM PAIR PLIERS)
	(ADJECTIVE WIDE-NOSED WIDE NOSED)
	(SIZE 15)
	(FLAGS TAKEBIT)>

<ROOM MACHINE-SHOP
      (IN ROOMS)
      (DESC "Machine Shop")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO MECH-CORRIDOR-S)
      (EAST TO ROBOT-SHOP)
      (WEST TO TOOL-ROOM)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (PSEUDO "SPOUT" CHEM-SPOUT-PSEUDO)
      (ACTION MACHINE-SHOP-F)>

<ROUTINE MACHINE-SHOP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This room is probably some sort of machine shop filled with a variety
of unusual machines. Doorways lead north, east, and west.|
|
Standing against the rear wall is a large dispensing machine with a
spout. ">
		<COND (<NOT <EQUAL? ,SPOUT-PLACED ,GROUND>>
		       <TELL
"Sitting under the spout is " A ,SPOUT-PLACED ". ">)>
		<TELL
"The dispenser is lined with brightly-colored buttons. The first four
buttons, labelled \"KUULINTS 1 - 4\", are colored red, blue, green, and
yellow. The next three buttons, labelled \"KATALISTS 1 - 3\", are colored
gray, brown, and black. The last two buttons are both white. One of
these is square and says \"BAAS\". The other white button is round and
says \"ASID\"." CR>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <EQUAL? ,SPOUT-PLACED ,GROUND>
		     <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,RLANDBIT>
		     <PROB 15>>
		<SETG FLOYD-SPOKE T>
		<TELL
"Floyd pushes one of the dispenser buttons. Fluid pours from the spout and
splashes across the floor. Floyd jumps up and down, giggling." CR>)>>

<OBJECT CHEMICAL-DISPENSER
	(IN MACHINE-SHOP)
	(DESC "chemical dispenser")
	(SYNONYM DISPEN MACHIN)
	(ADJECTIVE DISPEN LARGE CHEMICAL)
	(FLAGS NDESCBIT)
	(ACTION CHEMICAL-DISPENSER-F)>

<GLOBAL SPOUT-PLACED <>>

<ROUTINE CHEMICAL-DISPENSER-F ()
	 <COND (<AND <VERB? PUT-UNDER>
		     <EQUAL? ,PRSI ,CHEMICAL-DISPENSER>>
		<COND (<EQUAL? ,SPOUT-PLACED ,GROUND>
		       <MOVE ,PRSO ,HERE>
		       <TELL
"The " D ,PRSO " is now sitting under the spout." CR>
		       <SETG SPOUT-PLACED ,PRSO>)
		      (T
		       <TELL
"The " D ,SPOUT-PLACED " is already resting under the spout." CR>)>)>>

<OBJECT RED-BUTTON
	(IN MACHINE-SHOP)
	(DESC "red button")
	(SYNONYM BUTTON)
	(ADJECTIVE RED)
	(FLAGS NDESCBIT)
	(C-MOVE 1)
	(ACTION CHEM-BUTTON-F)>

<OBJECT BLUE-BUTTON
	(IN MACHINE-SHOP)
	(DESC "blue button")
	(SYNONYM BUTTON)
	(ADJECTIVE BLUE)
	(FLAGS NDESCBIT)
	(C-MOVE 2)
	(ACTION CHEM-BUTTON-F)>

<OBJECT GREEN-BUTTON
	(IN MACHINE-SHOP)
	(DESC "green button")
	(SYNONYM BUTTON)
	(ADJECTIVE GREEN)
	(FLAGS NDESCBIT)
	(C-MOVE 3)
	(ACTION CHEM-BUTTON-F)>

<OBJECT YELLOW-BUTTON
	(IN MACHINE-SHOP)
	(DESC "yellow button")
	(SYNONYM BUTTON)
	(ADJECTIVE YELLOW)
	(FLAGS NDESCBIT)
	(C-MOVE 4)
	(ACTION CHEM-BUTTON-F)>

<OBJECT GRAY-BUTTON
	(IN MACHINE-SHOP)
	(DESC "gray button")
	(SYNONYM BUTTON)
	(ADJECTIVE GRAY GREY)
	(FLAGS NDESCBIT)
	(C-MOVE 5)
	(ACTION CHEM-BUTTON-F)>

<OBJECT BROWN-BUTTON
	(IN MACHINE-SHOP)
	(DESC "brown button")
	(SYNONYM BUTTON)
	(ADJECTIVE BROWN)
	(FLAGS NDESCBIT)
	(C-MOVE 6)
	(ACTION CHEM-BUTTON-F)>

<OBJECT BLACK-BUTTON
	(IN MACHINE-SHOP)
	(DESC "black button")
	(SYNONYM BUTTON)
	(ADJECTIVE BLACK)
	(FLAGS NDESCBIT)
	(C-MOVE 7)
	(ACTION CHEM-BUTTON-F)>

<OBJECT ROUND-WHITE-BUTTON
	(IN MACHINE-SHOP)
	(DESC "round white button")
	(SYNONYM BUTTON)
	(ADJECTIVE WHITE ROUND)
	(FLAGS NDESCBIT)
	(C-MOVE 8)
	(ACTION CHEM-BUTTON-F)>

<OBJECT SQUARE-WHITE-BUTTON
	(IN MACHINE-SHOP)
	(DESC "square white button")
	(SYNONYM BUTTON)
	(ADJECTIVE SQUARE WHITE)
	(FLAGS NDESCBIT)
	(C-MOVE 9)
	(ACTION CHEM-BUTTON-F)>

<GLOBAL CHEMICAL-FLAG 0>

<GLOBAL COLOR-LTBL
	 <PLTABLE
	  "red"
	  "blue"
	  "green"
	  "yellow"
	  "gray"
	  "brown"
	  "black"
	  "clear"
	  "clear">>

<ROUTINE CHEM-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (<FSET? ,CHEMICAL-DISPENSER ,RMUNGBIT>
		       <TELL
"The machine coughs a few times, but nothing else happens." CR>)
		      (<EQUAL? ,SPOUT-PLACED ,FLASK>
		       <COND (<IN? ,CHEMICAL-FLUID ,FLASK>
			      <TELL
"Another dose of the chemical fluid pours out of the spout, splashes over
the already-full flask, spills onto the floor, and dries up." CR>)
			     (T
			      <MOVE ,CHEMICAL-FLUID ,FLASK>
			      <TELL "The flask fills with some ">
			      <SETG CHEMICAL-FLAG <GETP ,PRSO ,P?C-MOVE>>
			      <TELL <GET ,COLOR-LTBL <GETP ,PRSO ,P?C-MOVE>>>
			      <TELL
" chemical fluid. The fluid gradually turns milky white." CR>)>)
		      (<AND <EQUAL? ,SPOUT-PLACED ,PF-CANTEEN>
			    <FSET? ,PF-CANTEEN ,OPENBIT>>
		       <TELL
"Chemical fluid gushes from the spout. Unfortunately, the mouth of the canteen
is very narrow, and the fluid just splashes over it." CR>)
		      (T
		       <TELL
"Some sort of chemical fluid pours out of the spout, spills all over the "
D ,SPOUT-PLACED ", and dries up." CR>
		       <COND (<AND <EQUAL? ,PRSO ,ROUND-WHITE-BUTTON
					         ,SQUARE-WHITE-BUTTON>
				   <OR <DISSOLVABLE? ,SPOUT-PLACED>
				       <MUNGABLE? ,SPOUT-PLACED>>>
			      <SETG CHEMICAL-FLAG 9>
			      <PERFORM ,V?POUR ,CHEMICAL-FLUID ,SPOUT-PLACED>
			      <RTRUE>)>
		       <RTRUE>)>)>>

<ROOM ROBOT-SHOP
      (IN ROOMS)
      (DESC "Robot Shop")
      (LDESC
"This room, with exits west and northwest, is filled with robot-like
devices of every conceivable description, all in various states of
disassembly.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW" 25 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO MACHINE-SHOP)
      (NW TO MECH-CORRIDOR-S)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (PSEUDO "DEVICE" DEVICES-PSEUDO)>

<OBJECT FLOYD
	(IN ROBOT-SHOP)
	(DESC "multiple purpose robot")
	(FDESC
"Only one robot, about four feet high, looks even remotely close to being
in working order.")
	(SYNONYM FLOYD COMPAR ROBOT COMPAN)
	(ADJECTIVE MULTIP PURPOS DIM- DIM WITTED)
	(FLAGS CONTBIT SEARCHBIT TRANSBIT OPENBIT LIGHTBIT)
	(CAPACITY 5)
	(ACTION FLOYD-F)>

<GLOBAL CARD-STOLEN <>> ;"true if you took elev. card from turned-off Floyd"

<ROUTINE FLOYD-F ("AUX" X N OBJ STR)
	 <COND (<EQUAL? ,FLOYD ,WINNER>
		<SETG FLOYD-SPOKE T>
		<COND (<AND <VERB? GIVE>
			    <EQUAL? ,PRSI ,ME>>
		       <SETG WINNER ,ADVENTURER>
		       <PERFORM ,V?ASK-FOR ,FLOYD ,PRSO>
		       <RTRUE>)
		      (<AND <VERB? SGIVE>
			    <EQUAL? ,PRSO ,ME>>
		       <SETG WINNER ,ADVENTURER>
		       <PERFORM ,V?ASK-FOR ,FLOYD ,PRSI>
		       <RTRUE>)
		      (<VERB? WALK>
		       <TELL
"Floyd looks slightly embarrassed. \"You know me and my sense of direction.\"
Then he looks up at you with wide, trusting eyes. \"Tell Floyd a story?\"" CR>
		       <COND (<FLUSH>
			      <RFATAL>)>
		       <RTRUE>)
		      (<VERB? THROUGH>
		       <COND (<FSET? ,PRSO ,DOORBIT>
			      <TELL "\"You go first,\" says Floyd." CR>)
			     (T
			      <TELL
"Floyd scratches his head and looks at you." CR>)>
		       <COND (<FLUSH>
			      <RFATAL>)>
		       <RTRUE>)
		      (<AND <VERB? FOLLOW>
			    <EQUAL? ,PRSO ,ME>>
		       <TELL "\"Okay!\"" CR>)
		      (<VERB? HELLO>
		       <SETG WINNER ,ADVENTURER>
		       <PERFORM ,V?HELLO ,FLOYD>
		       <RTRUE>)
		      (<VERB? DROP>
		       <COND (<IN? ,PRSO ,FLOYD>
			      <COND (<PROB 50>
				     <MOVE ,PRSO ,HERE>
				     <TELL
"Floyd shrugs and drops the " D ,PRSO "." CR>)
				    (T
				     <TELL
"Floyd clutches the " D ,PRSO " even more tightly. \"Floyd won't,\" he says
defiantly." CR>)>)
			     (T
			      <FLOYD-NOT-HAVE>)>)
		      (T
		       <TELL
"Floyd whines, \"Enough talking! Let's play Hider-and-Seeker.\"" CR>
		       <RFATAL>)>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?OPEN ,FLOYD>
		<RTRUE>)
	       (<VERB? CLOSE>
		<TELL "Huh?" CR>)
	       (<FSET? ,FLOYD ,RLANDBIT>
		<SETG FLOYD-SPOKE T>
		<COND (<VERB? LAMP-ON>
		       <TELL "He's already been activated." CR>)
		      (<VERB? LAMP-OFF>
		       <FCLEAR ,FLOYD ,RLANDBIT>
		       <FCLEAR ,FLOYD ,ACTORBIT>
		       <DISABLE <INT I-FLOYD>>
		       <TELL
"Floyd, shocked by this betrayal from his new friend, whimpers and keels over">
		       <COND (<FIRST? ,FLOYD>
			      <TELL ", dropping what he was carrying." CR>)
			     (T
			      <TELL "." CR>)>
		       <SET X <FIRST? ,FLOYD>>
		       <REPEAT ()
			       <COND (.X
				      <SET N <NEXT? .X>>
				      <MOVE .X ,HERE>
				      <SET X .N>)
				     (T
				      <RETURN>)>>)
		      (<VERB? EXAMINE>
		       <TELL
"From its design, the robot seems to be of the multi-purpose sort. It is
slightly cross-eyed, and its mechanical mouth forms a lopsided grin." CR>)
		      (<VERB? KISS>
		       <TELL "You receive a painful electric shock." CR>)
		      (<VERB? SCOLD>
		       <TELL
"Floyd looks defensive. \"What did Floyd do wrong?\"" CR>)
		      (<VERB? PLAY-WITH>
		       <SETG C-ELAPSED 30>
		       <ENABLE <QUEUE I-FLOYD 1>>
		       <TELL
"You play with Floyd for several centichrons until you drop to the floor,
exhausted. Floyd pokes at you gleefully. \"C'mon! Let's play some more!\"" CR>)
		      (<VERB? LISTEN>
		       <TELL "Floyd is babbling about this and that." CR>)
		      (<AND <VERB? TAKE>
			    <EQUAL? ,PRSO ,FLOYD>>
		       <TELL
"You manage to lift Floyd a few inches off the ground, but he is too heavy
and you drop him suddenly. Floyd gives a surprised squeal and moves
a respectable distance away." CR>)
		      (<VERB? ATTACK MUNG>
		       <TELL
"Floyd starts dashing around the room. \"Oh boy oh boy oh boy! I haven't played
Chase and Tag for years! You be It! Nah, nah!\""CR>)
		      (<VERB? KICK SHAKE>
		       <TELL
"\"Why you do that?\" Floyd whines. \"I think a wire now shaken loose.\"
He goes off into a corner and sulks." CR>)
		      (<VERB? HELLO>
		       <TELL
"\"Hi!\" Floyd grins and bounces up and down." CR>)
		      (<VERB? SEARCH OPEN>
		       <TELL
"Floyd giggles and pushes you away. \"You're tickling Floyd!\" He clutches at
his side panels, laughing hysterically. Oil drops stream from his eyes." CR>)
		      (<AND <VERB? GIVE PUT>
			    <EQUAL? ,FLOYD ,PRSI>>
		       <FCLEAR ,PRSO ,WORNBIT>
		       <COND (<OR <EQUAL? ,PRSO ,RED-GOO ,GREEN-GOO ,BROWN-GOO>
				  <EQUAL? ,PRSO ,CHEMICAL-FLUID>>
			      <COND (<EQUAL? ,PRSO ,CHEMICAL-FLUID>
				     <SET STR "fluid">)
				    (T
				     <SET STR "goo">)>
			      <TELL
"Floyd looks at the " .STR ". \"Yech! Got any Number Seven Heavy Grease?\"" CR>)
			     (<OR <FIRST? ,FLOYD>
				  <FIRST? ,PRSO>
				  <PROB 25>>
			      <MOVE ,PRSO ,HERE>
			      <TELL
"Floyd examines the " D, PRSO ", shrugs, and drops ">
			      <COND (<EQUAL? ,PRSO ,PLIERS>
				     <TELL "them." CR>)
				    (T
				     <TELL "it." CR>)>)
			     (T
			      <MOVE ,PRSO ,FLOYD>
			      <TELL
"\"Neat!\" exclaims Floyd. He thanks you profusely." CR>)>)
		      (<AND <VERB? SHOW>
			    <EQUAL? ,FLOYD ,PRSI>>
		       <COND (<EQUAL? ,PRSO ,LOWER-ELEVATOR-CARD>
			      <TELL
"\"I've got one just like that!\" says Floyd. He looks through several
of his compartments, then glances at you suspiciously." CR>)
			     (T
			      <TELL
"Floyd looks sceptically at the " D, PRSO ". \"Can you play any
games with it?\" he asks." CR>)>)
		      (<VERB? RUB>
		       <TELL "Floyd gives a contented sigh." CR>)
		      (<VERB? SMELL>
		       <TELL
"Floyd smells faintly of ozone and light machine oil." CR>)
		      (<VERB? ASK-FOR>
		       <COND (<IN? ,PRSI ,FLOYD>
			      <MOVE ,PRSI ,ADVENTURER>
			      <TELL
"\"Okay,\" says Floyd, handing you the " D, PRSI ", \"but only
because you're Floyd's best friend.\"" CR>)
			     (T
			      <FLOYD-NOT-HAVE>)>)>)
	       (T
		<COND (<VERB? LAMP-ON>
		       <COND (,FLOYD-INTRODUCED
			      <ENABLE <QUEUE I-FLOYD -1>>)
			     (T
			      <ENABLE <QUEUE I-FLOYD 25>>
			      <TELL "Nothing happens." CR>
			      <COND (<NOT ,FLOYD-SCORE-FLAG>
				     <SETG FLOYD-SCORE-FLAG T>
				     <SETG SCORE <+ ,SCORE 2>>)>
			      <RTRUE>)>)
		      (<VERB? LAMP-OFF>
		       <TELL 
"The robot doesn't seem to be on, so why turn it off?" CR>)
		      (<VERB? EXAMINE>
		       <TELL
"The de-activated robot is leaning against the wall, its head lolling to the
side. It is short, and seems to be equipped for general-purpose work. It has
apparently been turned off." CR>)
		      (<VERB? SEARCH OPEN>
		       <COND (<NOT ,CARD-STOLEN>
			      <FCLEAR ,LOWER-ELEVATOR-CARD ,INVISIBLE>
			      <MOVE ,LOWER-ELEVATOR-CARD ,ADVENTURER>
			      <SCORE-OBJ ,LOWER-ELEVATOR-CARD>
			      <SETG CARD-STOLEN T>
			      <TELL
"In one of the robot's compartments you find and take a magnetic-striped card
embossed \"Loowur Elavaatur Akses Kard.\"" CR>)
			     (<SET OBJ <FIRST? ,FLOYD>>
			      <MOVE .OBJ ,ADVENTURER>
			      <TELL "You find and take " A .OBJ "." CR>)
			     (T
			      <TELL
"Your search discovers nothing in the robot's compartments except a
single crayon which you leave where you found it." CR>)>)
		      (<AND <VERB? GIVE>
			    <PRSI? ,FLOYD>>
		       <TELL "The " D ,FLOYD " is particularly unreceptive." CR>)>)>>

<ROUTINE FLUSH ()
	 <COND (,P-CONT
		<SETG P-CONT <>>
		<TELL CR
"Floyd scratches his head and looks at you. \"What else were you saying to
Floyd? I can't remember.\"" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FLOYD-NOT-HAVE ()
	 <TELL "\"Floyd does not one of those have!\"" CR>>

<GLOBAL FLOYD-SCORE-FLAG <>>

<GLOBAL FLOYD-SPOKE <>> ;"so Floyd doesn't do two things on the same turn"

<GLOBAL FLOYD-FOLLOW <>> ;"checks if Floyd was in room where you just were"

<GLOBAL FLOYD-REACTIVATED <>> ;"checks if Floyd has been turned on before"

<GLOBAL FLOYD-INTRODUCED <>> ;"checks if Floyd has met you before"

<ROUTINE FLOYD-COMES-ALIVE ("AUX" FOO)
	 <COND (<IN? ,FLOYD ,HERE>
		<COND (,FLOYD-REACTIVATED
		       <SETG FLOYD-SPOKE T>
		       <TELL
"Floyd jumps to his feet, hopping mad. \"Why you turn Floyd off?\" he
asks accusingly." CR>)
		      (T
		       <SETG FLOYD-INTRODUCED T>
		       <SETG FLOYD-SPOKE T>
		       <TELL 
"Suddenly, the robot comes to life and its head starts swivelling about.
It notices you and bounds over. \"Hi! I'm B-19-7, but to everyperson I'm
called Floyd. Are you a doctor-person or a planner-person? ">
		       <COND (<SET FOO <FIRST? ,ADVENTURER>>
			      <TELL
"That's a nice " D .FOO " you are having there. ">)>
		       <TELL
"Let's play Hider-and-Seeker you with me.\"" CR>)>)>
	 <FSET ,FLOYD ,RLANDBIT>
	 <FSET ,FLOYD ,ACTORBIT>
	 <FSET ,FLOYD ,TOUCHBIT>
	 <SETG FLOYD-REACTIVATED T>>

<ROUTINE I-FLOYD ()
	 <ENABLE <QUEUE I-FLOYD -1>>
	 <COND (<NOT <FSET? ,FLOYD ,RLANDBIT>>
		<FSET ,FLOYD ,ACTORBIT>
		<FLOYD-COMES-ALIVE>)
	       (<IN? ,FLOYD ,HERE>
		<COND (<NOT ,FLOYD-INTRODUCED>
		       <SETG FLOYD-INTRODUCED T>
		       <TELL
"The robot, now apparently active, notices you enter. \"Hi,\" he says.
\"I'm Floyd!\"" CR>)
		      (<AND ,FLOYD-FOLLOW
			    <FSET? ,HERE ,FLOYDBIT>
			    <PROB 6>>
		       <REMOVE ,FLOYD>
		       <SETG FLOYD-FOLLOW <>>
		       <TELL
"Floyd says \"Floyd going exploring. See you later.\" He glides out
of the room." CR>)
		      (T
		       <SETG FLOYD-FOLLOW T>
		       <COND (<AND <PROB 40>
				   <NOT ,FLOYD-SPOKE>>
			      <TELL "Floyd ">
			      <TELL <PICK-ONE ,FLOYDISMS>>
			      <TELL "." CR>
			      <RTRUE>)>)>)
	       (T	;"Floyd is active but not present"
		<COND (<AND ,FLOYD-FOLLOW <PROB 80>>
		       <MOVE ,FLOYD ,HERE>
		       <TELL "Floyd follows you." CR>)
		      (T
		       <SETG FLOYD-FOLLOW <>>
		       <COND (<PROB 30>
			      <MOVE ,FLOYD ,HERE>
			      <COND (,FLOYD-INTRODUCED
				     <COND (<AND <PROB 15>
						 <NOT <IN? ,ADVENTURER ,BED>>>
					    <TELL
"Floyd rushes into the room and barrels into you. \"Oops, sorry,\" he says.
\"Floyd not looking at where he was going to.\"" CR>)
					   (T
					    <TELL
"Floyd bounds into the room. \"Floyd here now!\" he cries." CR>)>)
				    (T
				     <CALL-ME-FLOYD>)>)>)>)>
	 <SETG FLOYD-SPOKE <>>>

<ROUTINE CALL-ME-FLOYD ()
	 <SETG FLOYD-INTRODUCED T>
	 <TELL
"The robot you were fiddling with in the Robot Shop bounds into the room.
\"Hi!\" he says, with a wide and friendly smile. \"You turn Floyd on?
Be Floyd's friend, yes?\"" CR>>

<GLOBAL FLOYDISMS
	<LTABLE
	 0
	 "paces impatiently"
	 "absent-mindedly recites the first six hundred digits of pi"
	 ;"lowers his voice and tells you the latest rumors about Dr. Fizpick"
	 "recalls the time he bruised his knee"
	 ;"chants the death scene from \"Carmen\""
	 "cranes his neck to see what you are doing"
	 "rubs his head affectionately against your shoulder"
	 "asks if you want to play Hucka-Bucka-Beanstalk"
	 "examines himself for signs of rust"
	 "absent-mindedly oils one of his joints"
	 "wanders restlessly around the room"
	 "notices a mouse scurrying by and tries to hide behind you"
	 "sings an ancient ballad, totally out of key"
	 "frets about the possibility of his batteries failing"
	 "reminisces about his friend Lazarus, a medical robot"
	 ;"relates some fond memories about his robotic friend Lazarus"
	 "whistles tunelessly"
	 ;"tells you about the time he helped someone sharpen a pencil"
	 ;"yawns and looks bored"
	 "produces a crayon from one of his compartments and scrawls
his name on the wall">>

<OBJECT CHEMICAL-FLUID
	(DESC "quantity of chemical fluid")
	(SYNONYM QUANTITY LIQUID FLUID CHEMICAL)
	(ADJECTIVE MILKY WHITE CHEMICAL)
	(ACTION CHEMICAL-FLUID-F)>

<ROUTINE CHEMICAL-FLUID-F ()
	 <COND (<VERB? EAT DRINK>
		<JIGS-UP
"Mmmmm....that tasted just like delicious poisonous chemicals!">)
	       (<VERB? PUT POUR POUR-IN POUR-ON>
		<COND (<NOT <IN? ,FLASK ,PLAYER>>
		       <TELL "You're not holding the flask!" CR>
		       <RTRUE>)
		      (<EQUAL? ,PRSI ,PF-CANTEEN>
		       <WORTHLESS-ACTION>
		       <RTRUE>)>
		<REMOVE ,CHEMICAL-FLUID>
		<COND (<NOT ,PRSI>
		       <SETG PRSI ,GROUND>)>
		<COND (<EQUAL? ,CHEMICAL-FLAG 8 9>
		       <COND (<DISSOLVABLE? ,PRSI>
			      <COND (<EQUAL? ,PRSI ,SPOUT-PLACED>
				     <SETG SPOUT-PLACED ,GROUND>)>
			      <REMOVE ,PRSI>
			      <TELL
"The " D ,PRSI " dissolves right before your eyes!" CR>
			      <RTRUE>)
			     (<AND <EQUAL? ,CREVICE ,PRSI>
				   <NOT <FSET? ,PF-KEY ,TOUCHBIT>>>
			      <COND (<FSET? ,PF-KEY ,INVISIBLE>
				     <TELL
"A puff of smoke rises from the crevice." CR>)
				    (T
				     <TELL
"Although the chemical has no effect on the crevice, it does seem to have
dissolved the key that was lying in it." CR>)>
			      <REMOVE ,PF-KEY>
			      <FSET ,PF-KEY ,TOUCHBIT>
			      <FCLEAR ,PF-KEY ,INVISIBLE>)
			     (<EQUAL? ,PRSI ,ME ,ADVENTURER ,HANDS>
			      <JIGS-UP
"Have you always had this desire to see melting flesh?">)
			     (<AND <EQUAL? ,PRSI ,FLOYD>
				   <FSET? ,FLOYD ,RLANDBIT>>
			      <TELL
"Floyd yelps. \"Hey, cut it out! That stuff burns!\"" CR>)
			     (<MUNGABLE? ,PRSI>
			      <FSET ,PRSI ,RMUNGBIT>
			      <COND (<EQUAL? ,PRSI ,CHRONOMETER>
				     <SETG MUNGED-TIME ,INTERNAL-MOVES>)>
			      <TELL
"The " D ,PRSI " seems to undergo some damage as a result of your action." CR>
			      <RTRUE>)
			     (T
			      <CHEMICAL-POURS>)>)
		      (T
		       <CHEMICAL-POURS>)>)>>

<ROUTINE CHEMICAL-POURS ()
	 <TELL
"The chemical pours all over the " D ,PRSI ", making quite a mess." CR>>

<ROUTINE DISSOLVABLE? (OBJ)
	 <COND (<EQUAL? .OBJ ,PF-KEY ,GOOD-BEDISTOR ,OLD-BATTERY>
		<RTRUE>)
	       (<EQUAL? .OBJ ,MEGAFUSE-B ,MEGAFUSE-K ,CRACKED-BOARD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MUNGABLE? (OBJ)
	 <COND (<EQUAL? .OBJ ,LASER ,LASER-DIAL ,PADLOCK>
		<RTRUE>)
	       (<EQUAL? .OBJ ,CHEMICAL-DISPENSER ,CHRONOMETER>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE END-PLANETFALL ()
	 <COND (,FLOYD-INTRODUCED
		<TELL
"Floyd bounces after you. \"Hey, wait for Floyd!">)
	       (T
		<TELL
"A robot comes bounding across the ladder after you. \"Hi, I'm Floyd! Oh,
boy, I haven't had any friends to play with in thousands of years!">)>
	 <TELL
"\" He seems to hear something inaudible to you. \"What? Planetfall excerpt
is over? Already? But we haven't even played one game of Hider-and-Seeker!\"
The robot looks up at you, and you can see tears of oil beginning to form in
his wide eyes. \"You'll buy the real Planetfall and come back and play with
Floyd, won't you?\" Then the robot, and your surroundings, begin fading
away..." CR CR>
	 <FINISH>>

<ROUTINE V-REMOVE ()
	 <COND (<FSET? ,PRSO ,WORNBIT>
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
	        <RTRUE>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<V-DISEMBARK>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TELL "You are no longer wearing the " D ,PRSO "." CR>
		<SETG C-ELAPSED 18>
		<FCLEAR ,PRSO ,WORNBIT>)
	       (T
		<TELL "You aren't wearing that." CR>)>>

<ROUTINE V-TASTE ()
	 <COND (<EQUAL? ,PRSO ,BROWN-GOO ,GREEN-GOO ,RED-GOO>
		<TELL "It tastes edible." CR>)
	       (T
		<TELL "It tastes just like a ">
		<TELL D ,PRSO "." CR>)>>

<ROUTINE V-TIME ()
	 <COND (<NOT <EQUAL? ,GAME-FLAG 2>>
		<TELL "Who knows?" CR>)
	       (<IN? ,CHRONOMETER ,ADVENTURER>
		<TELL-TIME>
		<CRLF>)
	       (T
		<TELL
"It's hard to say, since you've removed your chronometer." CR>)>>

<ROUTINE V-LOOK-CRETIN ()
	 <TELL "This isn't a primitive two-word-parser adventure game.
If you want to look AT that object, please say so." CR>>

<ROUTINE TAKE-IT-OFF ()
	 <TELL "You'll have to take it off, first." CR>>

<ROUTINE ALREADY-OPEN ()
	 <TELL "It's already open!" CR>>

<ROUTINE IS-CLOSED ()
	 <TELL "It is closed!" CR>>

<ROUTINE USE-DIRECTIONS ()
	 <TELL "Use compass directions for movement." CR>>

<ROUTINE OWN-FEET ()
	 <MOVE ,WINNER ,HERE>
	 <TELL "You're on your own feet again." CR>>

<ROUTINE DDESC (DOOR)
	 <COND (<FSET? .DOOR ,OPENBIT>
		<TELL "open">)
	       (T
		<TELL "closed">)>>

<OBJECT SLOT
	(IN LOCAL-GLOBALS)
	(DESC "slot")
	(SYNONYM SLOT)
	(ADJECTIVE SMALL)
	(FLAGS NDESCBIT)
	(ACTION SLOT-F)>

<ROUTINE SLOT-F ()
	 <COND (<AND <VERB? PUT>
		     <EQUAL? ,SLOT ,PRSI>>
		<TELL
"The slot is shallow, so you can't put anything in it. It may be possible to
slide something through the slot, though." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The slot is about ten centimeters wide, but only about two centimeters deep.
It is surrounded on its long sides by parallel ridges of metal." CR>)
	       (<AND <VERB? SLIDE>
		     <EQUAL? ,SLOT ,PRSI>>
		<COND (<OR <AND <EQUAL? ,PRSO ,LOWER-ELEVATOR-CARD>
			        ,LOWER-CARD-SCRAMBLED>
			   <EQUAL? ,PRSO ,ID-CARD>>		       
		       <MOVE ,PRSO ,PLAYER>
		       <TELL
"A sign flashes \"Magnetik striip randumiizd...konsult Prajekt Handbuk abowt
propur kaar uv awtharazaashun kardz.\"" CR>)
		      (<EQUAL? ,PRSO ,LOWER-ELEVATOR-CARD>
		       <MOVE ,PRSO ,PLAYER>
		       <TELL
"A sign flashes \"Inkorekt awtharazaashun kard...akses deeniid.\"" CR>)>)>>

<GLOBAL SLEEPY-LEVEL 0>

<ROUTINE I-SLEEP-WARNINGS ()
	 <SETG SLEEPY-LEVEL <+ ,SLEEPY-LEVEL 1>>
	 <COND (<IN? ,ADVENTURER ,BED>
		<TELL "You suddenly realize how tired you were and how
comfortable the bed is. You should be asleep in no time." CR>
		<DISABLE <INT I-SLEEP-WARNINGS>>
		<ENABLE <QUEUE I-FALL-ASLEEP 16>>
		<RTRUE>)>
	 <COND (<EQUAL? ,SLEEPY-LEVEL 1>
		<TELL
"You begin to feel weary. It might be time to think about finding
a nice safe place to sleep." CR>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 400>>)
	       (<EQUAL? ,SLEEPY-LEVEL 2>
		<TELL
"You're really tired now. You'd better find a place to sleep real soon." CR>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 135>>)
	       (<EQUAL? ,SLEEPY-LEVEL 3>
		<TELL
"If you don't get some sleep soon you'll probably drop." CR>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 60>>)
	       (<EQUAL? ,SLEEPY-LEVEL 4>
		<TELL "You can barely keep your eyes open." CR>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 50>>)
	       (<EQUAL? ,SLEEPY-LEVEL 5>
		<COND (<EQUAL? ,HERE ,BED>
		       <TELL
"You slowly sink into a deep and blissful sleep." CR>
		       <DREAMING>)
		      (<EQUAL? ,HERE ,DORM-C ,DORM-D>
		       <TELL
"You climb into one of the bunk beds and immediately fall asleep." CR>
		       <MOVE ,ADVENTURER ,BED>
		       <DREAMING>)
		      (T
		       <TELL
"You can't stay awake a moment longer. You drop to the ground and fall
into a deep but fitful sleep." CR>
		       <COND (<PROB 30>
			      <JIGS-UP
"|
|
|
Suddenly, in the middle of the night, you awake as several ferocious beasts
(could they be grues?) surround and attack you. Perhaps you should have found
a slightly safer place to sleep.">)
			     (T
			      <DREAMING>)>)>)>>

<OBJECT BED
	(IN LOCAL-GLOBALS)
	(DESC "bed")
	(SYNONYM BUNK BED)
	(ADJECTIVE MULTI- TIERED BUNK)
	(FLAGS NDESCBIT CLIMBBIT VEHBIT)
	(ACTION BED-F)>

<ROUTINE BED-F ("OPTIONAL" (RARG ,M-OBJECT))
	 <COND (<AND <VERB? WALK>
		     <EQUAL? .RARG ,M-BEG>>
		<TELL "You'll have to stand up, first." CR>)
	       (<AND <VERB? TAKE>
		     <EQUAL? .RARG ,M-BEG>
		     <NOT <EQUAL? ,PRSO ,BED>>>
		<TELL "You can't reach it from here." CR>)
	       (.RARG
		<RFALSE>)
	       (<VERB? THROUGH BOARD WALK-TO CLIMB-ON>
		<COND (<IN? ,ADVENTURER ,BED>
		       <TELL "You are already in bed!" CR>)
		      (<G? ,SLEEPY-LEVEL 0>
		       <MOVE ,ADVENTURER ,BED>
		       <ENABLE <QUEUE I-FALL-ASLEEP 16>>
		       <DISABLE <INT I-SLEEP-WARNINGS>>
		       <TELL 
"Ahhh...the bed is soft and comfortable. You should be asleep in short
order." CR>)
		      (T
		       <MOVE ,ADVENTURER ,BED>
		       <TELL "You are now in bed." CR>)>)
	       (<AND <VERB? DISEMBARK STAND EXIT DROP>
		     <GET <INT I-FALL-ASLEEP> ,C-TICK>>
		<TELL
"How could you suggest such a thing when you're so tired and this
bed is so comfy?" CR>)
	       (<VERB? LEAVE EXIT DROP>
		<PERFORM ,V?DISEMBARK ,BED>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,BED ,PRSI>>
		<MOVE ,PRSO ,HERE>
		<TELL
"The " D ,PRSO " bounces off the bed and lands on the floor." CR>)>>

<ROUTINE I-FALL-ASLEEP ()
	 <TELL 
"You slowly sink into a deep and restful sleep." CR>
	 <DISABLE <INT I-FALL-ASLEEP>>
	 <DREAMING>>

<ROUTINE DREAMING ()
	 <COND (<PROB 60>
		<CRLF>
		<TELL <PICK-ONE ,DREAMS> CR>)>
	 <WAKING-UP>>

<GLOBAL DREAMS
	<LTABLE
	 0

;"...You find yourself on the bridge of the Feinstein. Ensign Blather is here,
as well as Admiral Smithers. You are diligently scrubbing the control panel.
Blather keeps yelling at you to scrub harder. Suddenly you hit the ship's
self-destruct switch! Smithers and Blather howl at you as the ship begins
exploding! You try to run, but your feet seem to be fused to the deck..."

"...You gulp down the last of your Ramosian Fire Nectar and ask the
andro-waiter for another pitcher. This pub makes the finest Nectar on
all of Ramos Two, and you and your shipmates are having a pretty rowdy
time. Through the windows of the pub you can see a mighty, ancient castle,
shining in the light of the three Ramosian moons. The Fire Nectar spreads
through your blood and you begin to feel drowsy..."

;"...Strangely, you wake to find yourself back home on Gallium. Even more
strangely, you are only eight years old again. You are playing with your
pet sponge-cat, Swanzo, on the edge of the pond in your backyard. Mom is
hanging orange towels on the clothesline. Suddenly the school bully jumps
out from behind a bush, grabs you, and pushes your head under the water.
You try to scream, but cannot. You feel your life draining away..."

;"...Your vision slowly returns. You are on a wooded cliff overlooking
a waterfall. A rainbow spans the falls. Blather stands above you, bellowing
that the ground is filthy -- scrub harder! You throw your brush at Blather,
but it passes thru him as though he were a ghost, and sails over the cliff.
Blather leaps after the valuable piece of Patrol property, and both plummet
into the void..."

"...At last, the Feinstein has arrived at the historic Nebulon system. It's
been five months since the last shore leave, and you're anxious for
Planetfall. You and some other Ensigns Seventh Class enter the shuttle for
surfaceside. Suddenly, you're alone on the shuttle, and it's tumbling out of
control! It lands in the ocean and begins sinking! You try to clamber out,
but you are stuck in a giant spider web. A giant spider crawls closer and
closer...">> 

<GLOBAL DAY 1>

<ROUTINE WAKING-UP ("AUX" X N)
	 <SETG DAY <+ ,DAY 1>>
	 <SETG SLEEPY-LEVEL 0>
	 <RESET-TIME>
	 <SET X <FIRST? ,ADVENTURER>>
	 <REPEAT ()
		 <COND (.X
			<SET N <NEXT? .X>>
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <MOVE .X ,HERE>)>
			<COND (<AND <EQUAL? .X ,FLASK>
				    <IN? ,CHEMICAL-FLUID ,FLASK>>
			       <REMOVE ,CHEMICAL-FLUID>)>
			<SET X .N>)
		       (T
			<RETURN>)>>
	 <TELL
"|
***** SEPTEM " N <+ ,DAY 5> ", 11344 *****|
|">
	 <COND (<NOT <IN? ,ADVENTURER ,BED>>
		<TELL
"You wake and slowly stand up, feeling stiff from your
night on the floor.">)
	       (T
		<TELL
"You wake up feeling refreshed and ready to face the challenges of this
mysterious world.">)>
	 <COND (<G? ,HUNGER-LEVEL 0>
		<SETG HUNGER-LEVEL 4>
		<ENABLE <QUEUE I-HUNGER-WARNINGS 100>>
		<TELL
" You are also incredibly famished. Better get some breakfast!">)
	       (T
		<ENABLE <QUEUE I-HUNGER-WARNINGS 400>>)>
	 <CRLF>
	 <COND (<FSET? ,FLOYD ,RLANDBIT>
		<MOVE ,FLOYD ,HERE>
		<SETG FLOYD-SPOKE T>
		<COND (<IN? ,ADVENTURER ,BED>
		       <TELL
"Floyd bounces impatiently at the foot of the bed. \"About time you woke
up, you lazy bones! Let's explore around some more!\"" CR>)
		      (T
		       <TELL
"Floyd gives you a nudge with his foot and giggles. \"You sure look silly
sleeping on the floor,\" he says." CR>)>)>>

<ROUTINE RESET-TIME ()
	 <SETG INTERNAL-MOVES <+ 1600 <RANDOM 80>>>
	 <ENABLE <QUEUE I-SLEEP-WARNINGS 5800>>>

<GLOBAL HUNGER-LEVEL 0>

<ROUTINE I-HUNGER-WARNINGS ()
	 <SETG HUNGER-LEVEL <+ ,HUNGER-LEVEL 1>>
	 <COND (<EQUAL? ,HUNGER-LEVEL 1>
		<ENABLE <QUEUE I-HUNGER-WARNINGS 450>>
		<TELL
"A growl from your stomach warns that you're getting pretty hungry and
thirsty." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 2>
		<ENABLE <QUEUE I-HUNGER-WARNINGS 150>>
		<TELL
"You're now really ravenous and your lips are quite parched." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 3>
		<ENABLE <QUEUE I-HUNGER-WARNINGS 100>>
		<TELL
"You're starting to feel faint from lack of food and liquid." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 4>
		<ENABLE <QUEUE I-HUNGER-WARNINGS 50>>
		<TELL
"If you don't eat or drink something in a few millichrons, you'll probably
pass out." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 5>
		<JIGS-UP "You collapse from extreme thirst and hunger.">)>>

<GLOBAL NOT-HUNGRY "Thanks, but you're not hungry.">

<ROUTINE NO-CLOSE ()
	 <TELL "There's no way to close it." CR>>


;"pseudo routines"

<ROUTINE WALKWAY-PSEUDO ()
	 <COND (<VERB? EXAMINE LAMP-ON>
		<TELL "The walkway, which hastened the trip down that
long corridor, is no longer in service." CR>)>>

<ROUTINE BENCH-PSEUDO ()
	 <COND (<VERB? CLIMB-ON BOARD>
		<TELL "The benches look uncomfortable." CR>)>>

<ROUTINE CATWALK-PSEUDO ()
	 <COND (<VERB? CLIMB-ON CLIMB-UP CLIMB-FOO>
		<TELL "The catwalks are too high for you to access." CR>)>>

<ROUTINE EQUIPMENT-PSEUDO ()
	 <COND (<VERB? EXAMINE RUB LAMP-ON LAMP-OFF>
		<TELL
"The equipment here is so complicated that you couldn't even begin to
figure out how to operate it." CR>)>>

<ROUTINE MONITORS-PSEUDO ()
	 <COND (<VERB? EXAMINE READ>
		<DESCRIBE-MONITORS>)>>

<ROUTINE TOILET-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "The fixtures are all dry and dusty." CR>)
	       (<VERB? FLUSH>
		<TELL "The water seems to be turned off." CR>)>>

<ROUTINE PARTITION-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "The partitions are very plain, and were
obviously intended to separate this huge room into smaller areas." CR>)>>

<ROUTINE DEVICES-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"They are components of disassembled robots, beyond repair." CR>)>>

<ROUTINE CHEM-SPOUT-PSEUDO ()
	 <COND (<AND <VERB? PUT-UNDER>
		     <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<PERFORM ,V?PUT-UNDER ,PRSO ,CHEMICAL-DISPENSER>
		<RTRUE>)
	       (<AND <VERB? LOOK-UNDER>
		     <NOT <EQUAL? ,SPOUT-PLACED ,GROUND>>>
		<TELL "There is " A ,SPOUT-PLACED " under the spout." CR>)>>

<ROUTINE RUBBLE-PSEUDO ()
	 <COND (<VERB? MOVE>
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE DIAGRAM-PSEUDO ()
	 <COND (<VERB? READ>
		<TELL "Not unless you've taken a special
twelve-year course in ninth-order molecular physics." CR>)>>

<ROUTINE REACTOR-BUTTON-PSEUDO ()
	 <COND (<VERB? PUSH>
		<COND (<FSET? ,REACTOR-ELEVATOR-DOOR ,OPENBIT>
		       <TELL "Nothing happens." CR>)
		      (T
		       <FSET ,REACTOR-ELEVATOR-DOOR ,OPENBIT>
		       <ENABLE <QUEUE I-REACTOR-DOOR-CLOSE 30>>
		       <TELL
"The metal doors slide open, revealing a small room to the east." CR>)>)>>