"GLOBALS for
				SAMPLER
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<OBJECT GLOBAL-OBJECTS
	(FLAGS RMUNGBIT INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT OPENBIT
	       SEARCHBIT TRANSBIT ONBIT RLANDBIT FIGHTBIT STAGGERED WEARBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK) ;"Yes, this synonym needs to exist... sigh"
	(DESCFCN PATH-OBJECT)
        (GLOBAL GLOBAL-OBJECTS)
	(FDESC "F")
	(LDESC "F")
	(PSEUDO "FOOBAR" V-WALK)
	(CONTFCN 0)
	(VTYPE 1)
	(SIZE 0)
	(CAPACITY 0)>

<OBJECT ROOMS
	(IN TO ROOMS)>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	(FLAGS TOOLBIT)
	(DESC "number")>

<OBJECT PSEUDO-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "pseudo")
	(ACTION ME-F)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THEM HER HIM)
	(DESC "it")
	(FLAGS NDESCBIT TOUCHBIT)>

<OBJECT NOT-HERE-OBJECT
	(DESC "thing")
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ)
	 ;"This COND is game independent (except the TELL)"
	 <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 ;"Here is the default 'cant see any' printer"
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You can't see any">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!" CR>
		<COND (<AND ,TUTORIAL-MODE <NOT ,CANT-SEE-FLAG>>
		       <SETG CANT-SEE-FLAG T>
		       <TELL "|
(In this case, you referred to an object in the game that was not
accessible to you. This may mean that the object is in a different
location from your own, or that it's in a closed container.)" CR>)>)
	       (T
		<TELL "The " D ,WINNER " seems confused. \"I don't see any">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!\"" CR>)>
	 <RTRUE>>

<GLOBAL CANT-SEE-FLAG <>>

;<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
	  ;"not referenced, removed 2/27/85 by SEM"
	;"Here is where special-case code goes. <MOBY-FIND .TBL> returns
	   number of matches. If 1, then P-MOBY-FOUND is it. One may treat
	   the 0 and >1 cases alike or different. It doesn't matter. Always
	   return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	<COND (,DEBUG
	       <TELL "[Moby-found " N .M-F " objects" "]" CR>)>
	<COND (<AND <G? .M-F 1>
		    <SET OBJ <GETP <1 .TBL> ,P?GLOBAL>>>
	       <SET M-F 1>
	       <SETG P-MOBY-FOUND .OBJ>)>
	<COND (<==? 1 .M-F>
	       <COND (,DEBUG <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO? <SETG PRSO ,P-MOBY-FOUND>)
		     (T <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<NOT .PRSO?>
	       <TELL "You wouldn't find any">
	       <NOT-HERE-PRINT .PRSO?>
	       <TELL " there." CR>
	       <RTRUE>)
	      (T ,NOT-HERE-OBJECT)>>

;<ROUTINE GLOBAL-NOT-HERE-PRINT (OBJ) ;"not referenced, removed 2/27/85 by SEM"
	 ;<COND (,P-MULT <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>)>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <TELL "You can't see any">
	 <COND (<EQUAL? .OBJ ,PRSO> <PRSO-PRINT>)
	       (T <PRSI-PRINT>)>
	 <TELL " here." CR>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
 <COND (<OR ,P-OFLAG ,P-MERGED>
	<COND (,P-XADJ <TELL " "> <PRINTB ,P-XADJN>)>
	<COND (,P-XNAM
	       <COND (<EQUAL? ,P-XNAM ,W?FLOYD> <TELL "Floyd">)
		     (T <TELL " "> <PRINTB ,P-XNAM>)>)>)
       (.PRSO?
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
       (T
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

/^L

<GLOBAL LOAD-MAX 100>

<GLOBAL LOAD-ALLOWED 100>

<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(SYNONYM STAIRS STEPS STAIRCASE STAIRWAY ;GANGWAY)
	(ADJECTIVE STONE DARK MARBLE FORBIDDING STEEP)
	(DESC "flight of stairs")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<VERB? THROUGH>
		<TELL
"You should indicate whether you want to go up or down." CR>)>>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(SYNONYM GROUND SAND DIRT FLOOR)
	(DESC "ground")
	(ACTION GROUND-FUNCTION)>

<ROUTINE GROUND-FUNCTION ()
	 <COND (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSI ,GROUND>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? SIT CLIMB-ON>
		<SETG C-ELAPSED 28>
		<TELL
"You sit down on the floor. After a while, you stand up again." CR>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,ADMIN-CORRIDOR-S>>
		<TELL "A narrow, jagged crevice runs across the floor." CR>)
	       (<VERB? DIG>
		<TELL "The ground is too hard for digging here." CR>)>>

<OBJECT GRUE
	(IN GLOBAL-OBJECTS)
	(DESC "lurking grue")
	(SYNONYM GRUE)
	(ADJECTIVE LURKING VICIOUS CARNIV SINISTER HUNGRY SILENT)
	(ACTION GRUE-F)>

<ROUTINE GRUE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,GAME-FLAG 2>
		       <TELL
"Grues are vicious, carnivorous beasts first introduced to Earth by a
visiting alien spaceship during the late 22nd century. Grues spread throughout
the galaxy alongside man. Although now extinct on all civilized planets,
they still exist in some backwater corners of the galaxy. Their favorite diet
is Ensigns Seventh Class, but their insatiable appetite is tempered by their
fear of light." CR>)
		      (T
		       <TELL
"The grue is a sinister, lurking presence in the dark places of the
earth. Its favorite diet is adventurers, but its insatiable appetite
is tempered by its fear of light.  No grue has ever been seen by the
light of day, and few have survived its fearsome jaws to tell the tale." CR>)>)
	  (<VERB? FIND>
	   <TELL
"There is no grue here, but I'm sure there is at least one lurking
in the darkness nearby.  I wouldn't ">
	   <COND (<EQUAL? ,GAME-FLAG 2>
		  <TELL "spend much time in the dark">)
		 (T <TELL "let my light go out">)>
	   <TELL " if I were you!" CR>)
	  (<VERB? LISTEN>
	   <TELL
"It makes no sound but is always lurking in the darkness nearby." CR>)
	  (T <TELL "There is no grue here, and a good thing too." CR>)>>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM ME MYSELF SELF CRETIN)
	(DESC "you")
	(FLAGS ACTORBIT)
	(ACTION ME-F)>

<ROUTINE ME-F ()
	 <COND (<VERB? TELL>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<TELL
"Talking to yourself is said to be a sign of impending mental collapse." CR>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSI ,ME>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)	       
	       (<VERB? FOLLOW>
		<TELL "It would be hard not to." CR>)
	       (<VERB? SMELL>
		<TELL "Phew!" CR>)	       
	       (<VERB? DROP>
		<TELL "Huh?" CR>)
	       (<VERB? MAKE>
		<TELL "Only you can do that." CR>)
	       (<VERB? DISEMBARK>
		<TELL "You'll have to do that on your own." CR>)
	       (<VERB? EAT>
		<TELL "Auto-cannibalism is not the answer." CR>)
	       (<VERB? ATTACK MUNG>
		<COND (<AND ,PRSI <FSET? ,PRSI ,WEAPONBIT>>
		       <JIGS-UP "If you insist.... Poof, you're dead!">)
		      (T
		       <TELL "Suicide is not the answer." CR>)>)
	       (<VERB? TAKE>
		<TELL "How romantic!" CR>)
	       (<VERB? ALARM>
		<TELL "You're awake." CR>)
	       (<VERB? EXAMINE>
		<TELL
"That's difficult unless your eyes are prehensile." CR>)>>

<OBJECT ADVENTURER
	(SYNONYM ADVENTURER)
	(DESC "cretin")
	(FLAGS NDESCBIT INVISIBLE ACTORBIT)
	(STRENGTH 0)
	(ACTION 0)>

<OBJECT PATHOBJ
	(IN GLOBAL-OBJECTS)
	(SYNONYM PASSAGE CRAWLWAY TRAIL PATH)
        (ADJECTIVE FOREST NARROW LONG WINDING)
	(DESC "path")
	(FLAGS NDESCBIT)
	(ACTION PATH-OBJECT)>

<ROUTINE PATH-OBJECT ()
	 <COND (<VERB? TAKE FOLLOW>
		<TELL "You must specify a direction to go." CR>)
	       (<VERB? FIND>
		<TELL "I can't help you there...." CR>)
	       (<VERB? DIG>
		<TELL "Not a chance." CR>)>>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM PAIR HANDS HAND)
	(ADJECTIVE BARE)
	(DESC "pair of hands")
	(FLAGS NDESCBIT TOOLBIT)
	(ACTION HANDS-F)>

<OBJECT GLOBAL-DUST
	(IN GLOBAL-OBJECTS)
	(SYNONYM DUST)
	(DESC "clump of dust")
	(ACTION GLOBAL-DUST-F)>

<ROUTINE GLOBAL-DUST-F ()
	 <TELL "Are you really that fascinated by dust?" CR>>