"ACTIONS for
				SAMPLER
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<ROUTINE EAST-HOUSE (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are behind the white house. A path leads into the forest
to the east. In one corner of the house there is a small window
that is ">
		<COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
		       <TELL "open.">)
		      (T <TELL "slightly ajar.">)>
		<CRLF>)>>

<ROUTINE OPEN-CLOSE (OBJ STROPN STRCLS)
	 <COND (<VERB? OPEN>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL <PICK-ONE ,DUMMY>>)
		      (T
		       <TELL .STROPN>
		       <FSET .OBJ ,OPENBIT>)>
		<CRLF>)
	       (<VERB? CLOSE>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL .STRCLS>
		       <FCLEAR .OBJ ,OPENBIT>
		       T)
		      (T <TELL <PICK-ONE ,DUMMY>>)>
		<CRLF>)>>

<ROUTINE BOARD-F ()
	 <COND (<VERB? TAKE EXAMINE>
		<TELL "The boards are securely fastened." CR>)>>

<ROUTINE TEETH-F ()
	 <COND (<AND <VERB? BRUSH>
		     <EQUAL? ,PRSO ,TEETH>>
		<COND (<NOT ,PRSI>
		       <TELL
"Dental hygiene is highly recommended, but I'm not sure what you want
to brush them with." CR>)
		      (T
		       <TELL "A nice idea, but with " A ,PRSI "?" CR>)>)>>

;<ROUTINE GRANITE-WALL-F () ;"not referenced, removed 2/27/85 by SEM"
	 <TELL "There is no granite wall here." CR>>

<ROUTINE SONGBIRD-F ()
	 <COND (<VERB? FIND TAKE>
		<TELL "The songbird is not here but is probably nearby." CR>)
	       (<VERB? LISTEN>
		<TELL "You can't hear the songbird now." CR>)
	       (<VERB? FOLLOW>
		<TELL "It can't be followed." CR>)
	       (T
		<TELL "You can't see any songbird here." CR>)>>

<ROUTINE WHITE-HOUSE-F ()
    <COND (<EQUAL? ,HERE ,KITCHEN ,LIVING-ROOM ,ATTIC>
	   <COND (<VERB? FIND>
		  <TELL "Why not find your brains?" CR>)
		 (<VERB? WALK-AROUND>
		  <GO-NEXT ,IN-HOUSE-AROUND>
		  T)>)
	  (<NOT <OR <EQUAL? ,HERE ,EAST-OF-HOUSE ,WEST-OF-HOUSE>
		    <EQUAL? ,HERE ,NORTH-OF-HOUSE ,SOUTH-OF-HOUSE>>>
	   <COND (<VERB? FIND>
		  <COND (<EQUAL? ,HERE ,CLEARING>
			 <TELL "It seems to be to the west." CR>)
			(T
			 <TELL "It was here just a minute ago...." CR>)>)
		 (T <TELL "You're not at the house." CR>)>)
	  (<VERB? FIND>
	   <TELL
"It's right in front of you. Are you blind or something?" CR>)
	  (<VERB? WALK-AROUND>
	   <GO-NEXT ,HOUSE-AROUND>
	   T)
	  (<VERB? EXAMINE>
	   <TELL
"The house is a beautiful colonial house that is painted white.
It is clear that the owners must have been extremely wealthy." CR>)
	  (<VERB? THROUGH OPEN>
	   <COND (<EQUAL? ,HERE ,EAST-OF-HOUSE>
		  <COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
			 <GOTO ,KITCHEN>)
			(T
			 <TELL "The window is closed." CR>
			 <THIS-IS-IT ,KITCHEN-WINDOW>)>)
		 (T
		  <TELL "I can't see how to get in from here." CR>)>)
	  (<VERB? BURN>
	   <TELL "You must be joking." CR>)>>

<ROUTINE FOREST-F ()
	 <COND (<VERB? WALK-AROUND>
		<GO-NEXT ,FOREST-AROUND>)
	       (<VERB? DISEMBARK>
		<TELL "You will have to specify a direction." CR>)
	       (<VERB? FIND>
		<TELL "You cannot see the forest for the trees." CR>)
	       (<VERB? LISTEN>
		<TELL "The pines and the hemlocks seem to be murmuring." CR>)>>

<ROUTINE MOUNTAIN-RANGE-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		<TELL "Don't you believe me? The mountains are impassable!"
		      CR>)>>

<ROUTINE WATER-F ("AUX" AV W PI?)
	 <COND (<EQUAL? ,GAME-FLAG 2>
		<TELL "I don't know the word \"water\"." CR>
		<RTRUE>)
	       (<AND <EQUAL? ,GAME-FLAG 3>
		     <VERB? TAKE DROP>>
		<TELL <PICK-ONE ,YUKS> CR>
		<RTRUE>)
	       (<OR <VERB? SGIVE>
		    <EQUAL? ,GAME-FLAG 3>>
		<RFALSE>)
	       (<VERB? THROUGH>
		<TELL "You can't swim in the dungeon." CR>
		<RTRUE>)
	       (<VERB? FILL>	;"fill bottle with water =>"
		<SET W ,PRSI>	   ;"put water in bottle"
		<SETG PRSA ,V?PUT>
		<SETG PRSI ,PRSO>
		<SETG PRSO .W>
		<SET PI? <>>)
	       (<OR <EQUAL? ,PRSO ,GLOBAL-WATER>
		    <EQUAL? ,PRSO ,WATER>>
		<SET W ,PRSO>
		<SET PI? <>>)
	       (<SET W ,PRSI>
		<SET PI? T>)>
	 <COND (<EQUAL? .W ,GLOBAL-WATER>
		<SET W ,WATER>
		<COND (<VERB? TAKE PUT> <REMOVE-CAREFULLY .W>)>)>
	 <COND (.PI? <SETG PRSI .W>)
	       (T <SETG PRSO .W>)>
	 <SET AV <LOC ,WINNER>>
	 <COND (<NOT <FSET? .AV ,VEHBIT>> <SET AV <>>)>
	 <COND (<AND <VERB? TAKE PUT> <NOT .PI?>>
		<COND (<AND .AV
			    <OR <EQUAL? .AV ,PRSI>
				<AND <NOT ,PRSI>
				     <NOT <IN? .W .AV>>>>>
		       <TELL "There is now a puddle in the bottom of the "
			     D .AV "." CR>
		       <REMOVE-CAREFULLY ,PRSO>
		       <MOVE ,PRSO .AV>)
		      (<AND ,PRSI <NOT <EQUAL? ,PRSI ,BOTTLE>>>
		       <TELL "The water leaks out of the " D ,PRSI
			     " and evaporates immediately." CR>
		       <REMOVE-CAREFULLY .W>)
		      (<IN? ,BOTTLE ,WINNER>
		       <COND (<NOT <FSET? ,BOTTLE ,OPENBIT>>
			      <TELL "The bottle is closed." CR>
			      <THIS-IS-IT ,BOTTLE>)
			     (<NOT <FIRST? ,BOTTLE>>
			      <MOVE ,WATER ,BOTTLE>
			      <TELL "The bottle is now full of water." CR>)
			     (T
			      <TELL "The water slips through your fingers." CR>
			      <RTRUE>)>)
		      (<AND <IN? ,PRSO ,BOTTLE>
			    <VERB? TAKE>
			    <NOT ,PRSI>>
		       <TELL
"It's in the bottle. Perhaps you should take that instead." CR>)
		      (T
		       <TELL "The water slips through your fingers." CR>)>)
	       (.PI? <TELL "Nice try." CR>)
	       (<VERB? DROP GIVE>
		<REMOVE-CAREFULLY ,WATER>
		<COND (.AV
		       <TELL "There is now a puddle in the bottom of the "
			     D .AV "." CR>
		       <MOVE ,WATER .AV>)
		      (T
		       <TELL
"The water spills to the floor and evaporates immediately." CR>
		       <REMOVE-CAREFULLY ,WATER>)>)
	       (<VERB? THROW>
		<TELL
"The water splashes on the walls and evaporates immediately." CR>
		<REMOVE-CAREFULLY ,WATER>)>>

<GLOBAL KITCHEN-WINDOW-FLAG <>>

<ROUTINE KITCHEN-WINDOW-F ()
	 <COND (<VERB? OPEN CLOSE>
		<SETG KITCHEN-WINDOW-FLAG T>
		<OPEN-CLOSE ,KITCHEN-WINDOW
"With great effort, you open the window far enough to allow entry."
"The window closes (more easily than it opened).">)
	       (<AND <VERB? EXAMINE>
		     <NOT ,KITCHEN-WINDOW-FLAG>>
		<TELL
"The window is slightly ajar, but not enough to allow entry." CR>)
	       (<VERB? WALK BOARD THROUGH>
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <DO-WALK ,P?EAST>)
		      (T
		       <DO-WALK ,P?WEST>)>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL "You can see ">
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <TELL "a clear area leading towards a forest." CR>)
		      (T
		       <TELL "what appears to be a kitchen." CR>)>)>>

<ROUTINE BOARDED-WINDOW-FCN ()
	 <COND (<VERB? OPEN>
		<TELL "The windows are boarded and can't be opened." CR>)
	       (<VERB? MUNG>
		<TELL "You can't break the windows open." CR>)>>

<ROUTINE NAILS-PSEUDO ()
	 <COND (<VERB? TAKE>
		<TELL
"The nails, deeply imbedded in the door, cannot be removed." CR>)>>

<ROUTINE CRACK-FCN ()
	 <COND (<VERB? THROUGH>
		<TELL "You can't fit through the crack." CR>)>>

<ROUTINE KITCHEN-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"You are in the kitchen of the white house. A table seems to
have been used recently for the preparation of food. A passage
leads to the west and a dark staircase can be seen leading
upward. A dark chimney leads down and to the east is a small
window which is ">
	       <COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
		      <TELL "open." CR>)
		     (T
		      <TELL "slightly ajar." CR>)>)
	      (<==? .RARG ,M-BEG>
	       <COND (<AND <VERB? CLIMB-UP> <EQUAL? ,PRSO ,STAIRS>>
		      <DO-WALK ,P?UP>)
		     (<AND <VERB? CLIMB-UP> <EQUAL? ,PRSO ,STAIRS>>
		      <TELL "There are no stairs leading down." CR>)>)>>

\

<ROUTINE TROPHY-CASE-FCN ()
    <COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,TROPHY-CASE>>
	   <TELL
"The trophy case is securely fastened to the wall." CR>)>>
	
<GLOBAL RUG-MOVED <>>

<ROUTINE LIVING-ROOM-FCN (RARG "AUX" RUG? TC)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"You are in the living room. There is a doorway to the east, a wooden
door with strange gothic lettering to the west, which appears to be
nailed shut, a trophy case, ">
	       <SET RUG? ,RUG-MOVED>
	       <COND (<AND .RUG? <FSET? ,TRAP-DOOR ,OPENBIT>>
		      <TELL
		       "and a rug lying beside an open trap door.">)
		     (.RUG?
		      <TELL "and a closed trap door at your feet.">)
		     (<FSET? ,TRAP-DOOR ,OPENBIT>
		      <TELL "and an open trap door at your feet.">)
		     (T
		      <TELL
		       "and a large oriental rug in the center of the room.">)>
	       <CRLF>
	       T)
	      (<EQUAL? .RARG ,M-END>
	       <COND (<OR <VERB? TAKE>
			  <AND <VERB? PUT>
			       <EQUAL? ,PRSI ,TROPHY-CASE>>>
		      <COND (<IN? ,PRSO ,TROPHY-CASE>
			     <TOUCH-ALL ,PRSO>)>
		      <SETG SCORE <+ ,BASE-SCORE <OTVAL-FROB>>>
		      <SCORE-UPD 0>
		      <RFALSE>)>)>>

<ROUTINE TOUCH-ALL (OBJ "AUX" F)
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (T
			<FSET .F ,TOUCHBIT>
			<COND (<FIRST? .F> <TOUCH-ALL .F>)>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE OTVAL-FROB ("OPTIONAL" (O ,TROPHY-CASE) "AUX" F (SCORE 0))
	 <SET F <FIRST? .O>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN .SCORE>)>
		 <SET SCORE <+ .SCORE <GETP .F ,P?TVALUE>>>
		 <COND (<FIRST? .F> <OTVAL-FROB .F>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE TRAP-DOOR-FCN ()
    <COND (<VERB? RAISE>
	   <PERFORM ,V?OPEN ,TRAP-DOOR>
	   <RTRUE>)
	  (<AND <VERB? OPEN CLOSE>
		<EQUAL? ,HERE ,LIVING-ROOM>>
	   <OPEN-CLOSE ,PRSO
"The door reluctantly opens to reveal a rickety staircase
descending into darkness."
"The door swings shut and closes.">)
	  (<AND <VERB? LOOK-UNDER> <EQUAL? ,HERE LIVING-ROOM>>
	   <COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		  <TELL
"You see a rickety staircase descending into darkness." CR>)
		 (T <TELL "It's closed." CR>)>)
	  (<EQUAL? ,HERE ,CELLAR>
	   <COND (<AND <VERB? OPEN UNLOCK>
		       <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		  <TELL
"The door is locked from above." CR>)
		 (<AND <VERB? CLOSE> <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		  <FCLEAR ,TRAP-DOOR ,TOUCHBIT>
		  <FCLEAR ,TRAP-DOOR ,OPENBIT>
		  <TELL "The door closes and locks." CR>)
		 (<VERB? OPEN CLOSE>
		  <TELL <PICK-ONE ,DUMMY> CR>)>)>>

<ROUTINE CELLAR-FCN (RARG)
  <COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL
"You are in a dark and damp cellar with a narrow passageway leading
north, and a crawlway to the south. On the west is the bottom of a
steep metal ramp which is unclimbable." CR>)
	(<EQUAL? .RARG ,M-ENTER>
	 <COND (<AND <FSET? ,TRAP-DOOR ,OPENBIT>
		     <NOT <FSET? ,TRAP-DOOR ,TOUCHBIT>>>
		<FCLEAR ,TRAP-DOOR ,OPENBIT>
		<FSET ,TRAP-DOOR ,TOUCHBIT>
		<TELL
"The trap door crashes shut, and you hear someone barring it." CR CR>)>)>>

<ROUTINE CHIMNEY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The chimney leads ">
		<COND (<==? ,HERE ,KITCHEN>
		       <TELL "down">)
		      (T <TELL "up">)>
		<TELL "ward, and looks climbable." CR>)>>

<ROUTINE UP-CHIMNEY-FUNCTION ("AUX" F)
  <COND (<NOT <SET F <FIRST? ,WINNER>>>
	 <TELL "Going up empty-handed is a bad idea." CR>
	 <RFALSE>)
	(<AND <OR <NOT <SET F <NEXT? .F>>>
		  <NOT <NEXT? .F>>>
	      <IN? ,LAMP ,WINNER>>
	 <COND (<NOT <FSET? ,TRAP-DOOR ,OPENBIT>>
		<FCLEAR ,TRAP-DOOR ,TOUCHBIT>)>
	 <RETURN ,KITCHEN>)
	(T
	 <TELL "You can't get up there with what you're carrying." CR>
	 <RFALSE>)>>

<ROUTINE TRAP-DOOR-EXIT ()
	 <COND (,RUG-MOVED
		<COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		       <RETURN ,CELLAR>)
		      (T
		       <TELL "The trap door is closed." CR>
		       <THIS-IS-IT ,TRAP-DOOR>
		       <RFALSE>)>)
	       (T
		<TELL ,CANT-GO CR>
		<RFALSE>)>>

<ROUTINE RUG-FCN ()
   <COND (<VERB? RAISE>
	  <COND (,RUG-MOVED
		 <TELL "The rug is too heavy to lift." CR>)
		(T
		 <TELL
"The rug is too heavy to lift, but in trying to take it you have
noticed an irregularity beneath it." CR>)>)
	 (<VERB? MOVE PUSH>
	  <COND (,RUG-MOVED
		 <TELL
"Having moved the carpet previously, you find it impossible to move
it again." CR>)
		(T
		 <TELL
"With a great effort, the rug is moved to one side of the room.
With the rug moved, the dusty cover of a closed trap door appears." CR>
		 <FCLEAR ,TRAP-DOOR ,INVISIBLE>
		 <THIS-IS-IT ,TRAP-DOOR>
		 <SETG RUG-MOVED T>)>)
	 (<VERB? TAKE>
	  <TELL
"The rug is extremely heavy and cannot be carried." CR>)
	 (<AND <VERB? LOOK-UNDER>
	       <NOT ,RUG-MOVED>
	       <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
	  <TELL "Underneath the rug is a closed trap door. As you drop the
corner of the rug, the trap door is once again concealed from view." CR>)
	 (<VERB? CLIMB-ON>
	  <COND (<AND <NOT ,RUG-MOVED>
		      <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		 <TELL
"You sit down. The rug seems to have an irregularity underneath it." CR>)
		(ELSE
		 <TELL "I suppose you think it's a magic carpet?" CR>)>)>>

\

"SUBTITLE TROLL"

<ROUTINE AXE-F ()
	 <COND (,TROLL-FLAG <>)
	       (T <WEAPON-FUNCTION ,AXE ,TROLL>)>>

<ROUTINE WEAPON-FUNCTION (W V)
	<COND (<NOT <IN? .V ,HERE>> <RFALSE>)
	      (<VERB? TAKE>
	       <COND (<IN? .W .V>
		      <TELL
"The " D .V " swings it out of your reach." CR>)
		     (T
		      <TELL
"The " D .W " seems white-hot. You can't hold on to it." CR>)>
	       T)>>

<ROUTINE TROLL-FCN ("OPTIONAL" (MODE <>))
	 <COND (<VERB? TELL>
		<TELL "The troll isn't much of a conversationalist." CR>
		<SETG P-CONT <>>)
	       (<EQUAL? .MODE ,F-BUSY?>
		<COND (<IN? ,AXE ,TROLL> <>)
		      (<AND <IN? ,AXE ,HERE> <PROB 75 90>>
		       <FSET ,AXE ,NDESCBIT>
		       <FCLEAR ,AXE ,WEAPONBIT>
		       <MOVE ,AXE ,TROLL>
		       <PUTP ,TROLL ,P?LDESC
"A nasty-looking troll, brandishing a bloody axe, blocks
all passages out of the room.">
		       <AND <IN? ,TROLL ,HERE>
			    <TELL
"The troll, angered and humiliated, recovers his weapon. He appears to have
an axe to grind with you." CR>>
		      T)
		     (<IN? ,TROLL ,HERE>
		      <PUTP ,TROLL ,P?LDESC
"A pathetically babbling troll is here.">
		      <TELL
"The troll, disarmed, cowers in terror, pleading for his life in
the guttural tongue of the trolls." CR>
		      T)>)
	      (<EQUAL? .MODE ,F-DEAD ,F-UNCONSCIOUS>
	       <TELL
"|
A wraith slowly materializes before you and speaks: \"You have successfully
completed this excerpt from Zork I and are ready to fully explore the vast 
world of the Great Underground Empire in the Zork Trilogy and the other works 
of interactive fiction from Infocom.\" With that, he leaves you to ponder
your fate. Very odd, to say the least.|
" CR>
	       <FINISH>)
	      (<EQUAL? .MODE ,F-FIRST?>
	       <COND (<PROB 33>
		      <FSET ,TROLL ,FIGHTBIT>
		      <SETG P-CONT <>>
		      T)>)
	      (<NOT .MODE>
	       <COND (<VERB? EXAMINE>
		      <TELL <GETP ,TROLL ,P?LDESC> CR>)
		     (<OR <AND <VERB? THROW GIVE>
			       ,PRSO
			       <EQUAL? ,PRSI ,TROLL>>
			  <VERB? TAKE MOVE MUNG>>
		      <AWAKEN ,TROLL>
		      <COND (<VERB? THROW GIVE>
			     <COND (<AND <EQUAL? ,PRSO ,AXE>
					 <IN? ,AXE ,WINNER>>
				    <TELL
"The troll scratches his head in confusion, then takes the axe." CR>
				    <FSET ,TROLL ,FIGHTBIT>
				    <MOVE ,AXE ,TROLL>
				    <RTRUE>)
				   (<EQUAL? ,PRSO ,TROLL ,AXE>
				    <TELL
"You would have to get the " D ,PRSO " first, and that seems unlikely." CR>
				    <RTRUE>)>
			     <COND (<VERB? THROW>
				    <TELL
"The troll, who is remarkably coordinated, catches the " D ,PRSO>)
				   (T
				    <TELL
"The troll, who is not overly proud, graciously accepts the gift">)>
			     <COND (<AND <PROB 20>
					 <EQUAL? ,PRSO ,KNIFE ,SWORD ,AXE>>
				    <REMOVE-CAREFULLY ,PRSO>
				    <TELL
" and eats it hungrily. Poor troll, he dies from an internal hemorrhage
and his carcass disappears in a sinister black fog." CR>
				    <REMOVE-CAREFULLY ,TROLL>
				    <APPLY <GETP ,TROLL ,P?ACTION> ,F-DEAD>
				    <SETG TROLL-FLAG T>)
				   (<EQUAL? ,PRSO ,KNIFE ,SWORD ,AXE>
				    <MOVE ,PRSO ,HERE>
				    <TELL
" and, being for the moment sated, throws it back. Fortunately, the
troll has poor control, and the " D ,PRSO " falls to the floor. He does
not look pleased." CR>
				    <FSET ,TROLL ,FIGHTBIT>)
				   (T
				    <TELL
" and not having the most discriminating tastes, gleefully eats it." CR>
				    <REMOVE-CAREFULLY ,PRSO>)>)
			    (<VERB? TAKE MOVE>
			     <TELL
"The troll spits in your face, grunting \"Better luck next time\" in a
rather barbarous accent." CR>)
			    (<VERB? MUNG>
			     <TELL
"The troll laughs at your puny gesture." CR>)>)
		     (<VERB? LISTEN>
		      <TELL
"Every so often the troll says something, probably uncomplimentary, in
his guttural tongue." CR>)
		     (<AND ,TROLL-FLAG <VERB? HELLO>>
		      <TELL "Unfortunately, the troll can't hear you." CR>)>)>>

\

"SUBTITLE GRATING/MAZE"

;<GLOBAL LEAVES-GONE <>> ;"not referenced, removed 2/27/85 by SEM"
;<GLOBAL GRUNLOCK <>> ;"not referenced, removed 2/27/85 by SEM"
<GLOBAL GRATE-REVEALED <>>

<ROUTINE LEAVES-APPEAR ()
	<COND (<AND <NOT <FSET? ,GRATE ,OPENBIT>>
	            <NOT ,GRATE-REVEALED>>
	       <COND (<VERB? MOVE TAKE>
		      <TELL
"In disturbing the pile of leaves, a grating is revealed." CR>)
		     (T <TELL
"With the leaves moved, a grating is revealed." CR>)>
	       <FCLEAR ,GRATE ,INVISIBLE>
	       <SETG GRATE-REVEALED T>)>
	<>>

<ROUTINE LEAF-PILE ()
	<COND (<VERB? COUNT>
	       <TELL "There are 69,105 leaves here." CR>)
	      (<VERB? BURN>
	       <LEAVES-APPEAR>
	       <REMOVE-CAREFULLY ,PRSO>
	       <COND (<IN? ,PRSO ,HERE>
		      <TELL
"The leaves burn." CR>)
		     (T
		      <JIGS-UP
"The leaves burn, and so do you.">)>)
	      (<VERB? CUT>
	       <TELL "You rustle the leaves around, making quite a mess." CR>
	       <LEAVES-APPEAR>
	       <RTRUE>)
	      (<VERB? MOVE TAKE>
	       <COND (<VERB? MOVE>
		      <TELL "Done." CR>)>
	       <COND (,GRATE-REVEALED <RFALSE>)>
	       <LEAVES-APPEAR>
	       <COND (<VERB? TAKE> <RFALSE>)
		     (T <RTRUE>)>)
	      (<AND <VERB? LOOK-UNDER>
		    <NOT ,GRATE-REVEALED>>
	       <TELL "Underneath the pile of leaves is a grating. As you
release the leaves, the grating is once again concealed from view." CR>)>>
 
<ROUTINE CLEARING-FCN (RARG)
  	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT ,GRATE-REVEALED>
		       <FSET ,GRATE ,INVISIBLE>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a clearing, with a forest surrounding you on all sides. A
path leads south.">
		<COND (<FSET? ,GRATE ,OPENBIT>
		       <CRLF>
		       <TELL
"There is an open grating, descending into darkness.">)
		      (,GRATE-REVEALED
		       <CRLF>
		       <TELL
"There is a grating securely fastened into the ground.">)>
		<CRLF>)>>

<ROUTINE GRATE-FUNCTION ()
    	 <COND (<VERB? LOCK>
		<COND (<EQUAL? ,HERE ,GRATING-CLEARING>
		       <TELL "You can't lock it from this side." CR>)>)
	       (<AND <VERB? UNLOCK> <EQUAL? ,PRSO ,GRATE>>
		<TELL
"Can you unlock a grating with " A ,PRSI "?" CR>)
               (<VERB? PICK>
		<TELL "You can't pick the lock." CR>)
               (<VERB? OPEN CLOSE>
		<TELL "The grating is locked." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,GRATE>>
		<COND (<G? <GETP ,PRSO ,P?SIZE> 20>
		       <TELL "It won't fit through the grating." CR>)
		      (T
		       <REMOVE ,PRSO>
		       <TELL
"The " D ,PRSO " goes through the grating into the darkness below." CR>)>)>>

<ROUTINE KNIFE-F ()
	 <COND (<VERB? TAKE>
		<FCLEAR ,ATTIC-TABLE ,NDESCBIT>
		<RFALSE>)>>

<GLOBAL LUCKY T>

;<ROUTINE WITH-TELL (OBJ) ;"not referenced, removed 2/27/85 by SEM"
	 <TELL "With " A .OBJ "?" CR>>

<ROUTINE BOTTLE-FUNCTION ("AUX" (E? <>))
  <COND (<VERB? THROW>
	 <REMOVE-CAREFULLY ,PRSO>
	 <SET E? T>
	 <TELL "The bottle hits the far wall and shatters." CR>)
	(<VERB? MUNG>
	 <SET E? T>
	 <REMOVE-CAREFULLY ,PRSO>
	 <TELL "A brilliant maneuver destroys the bottle." CR>)
	(<VERB? SHAKE>
	 <COND (<AND <FSET? ,PRSO ,OPENBIT> <IN? ,WATER ,PRSO>>
		<SET E? T>)>)>
  <COND (<AND .E? <IN? ,WATER ,PRSO>>
	 <TELL "The water spills to the floor and evaporates." CR>
	 <REMOVE-CAREFULLY ,WATER>
	 T)
	(.E? <RTRUE>)>>

;<GLOBAL EGG-SOLVE <>> ;"not referenced, removed 2/27/85 by SEM"

;
<ROUTINE MOVE-ALL (FROM TO "AUX" X N) ;"not referenced, removed 2/27/85 by SEM"
	 <COND (<SET X <FIRST? .FROM>>
		<REPEAT ()
			<COND (<NOT .X> <RETURN>)>
			<SET N <NEXT? .X>>
			<FCLEAR .X ,INVISIBLE>
			<MOVE .X .TO>
			<SET X .N>>)>>

<ROUTINE FRONT-DOOR-FCN ()
	 <COND (<VERB? OPEN>
		<TELL "The door cannot be opened." CR>)
	       (<VERB? BURN>
		<TELL
		 "You cannot burn this door." CR>)
	       (<VERB? MUNG>
		<TELL <PICK-ONE ,DOORMUNGS> CR>)
	       (<VERB? LOOK-BEHIND>
		<TELL "It won't open." CR>)>>

<GLOBAL DOORMUNGS
	<LTABLE 0 "You cannot damage this door."
	       "The door is still under warranty.">>

<ROUTINE PAINTING-FCN ()
	 <COND (<VERB? MUNG>
		<PUTP ,PRSO ,P?TVALUE 0>
		<PUTP ,PRSO ,P?LDESC
"There is a worthless piece of canvas here.">
		<TELL
"Congratulations! Unlike the other vandals, who merely stole the
artist's masterpieces, you have destroyed one." CR>)>>

<GLOBAL LAMP-TABLE
	<TABLE 100
	       "The lamp appears a bit dimmer."
	       70
	       "The lamp is definitely dimmer now."
	       15   
	       "The lamp is nearly out."
	       0>>

<ROUTINE LANTERN ()
	 <COND (<VERB? THROW>
		<TELL
"The lamp has smashed into the floor, and the light has gone out." CR>
		<DISABLE <INT I-LANTERN>>
		<REMOVE-CAREFULLY ,LAMP>
		<MOVE ,BROKEN-LAMP ,HERE>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "A burned-out lamp won't light." CR>)
		      (T
		       <ENABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "The lamp has already burned out." CR>)
		      (T
		       <DISABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? EXAMINE>
		<TELL "The lamp ">
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "has burned out.">)
		      (<FSET? ,LAMP ,ONBIT>
		       <TELL "is on.">)
		      (T
		       <TELL "is turned off.">)>
		<CRLF>)>>

<ROUTINE MAILBOX-F ()
	 <COND (<VERB? TAKE>
		<TELL "It is securely anchored." CR>)>>

<ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))
	 <ENABLE <QUEUE I-LANTERN <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,LAMP .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG LAMP-TABLE <REST .TBL 4>>)>>

<ROUTINE LIGHT-INT (OBJ TBL TICK)
	 <COND (<0? .TICK>
		<FCLEAR .OBJ ,ONBIT>
		<FSET .OBJ ,RMUNGBIT>)>
	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
		<COND (<0? .TICK>
		       <TELL
"You'd better have more light than from the " D .OBJ "." CR>)
		      (T
		       <TELL <GET .TBL 1> CR>)>)>>

;<ROUTINE MIN (N1 N2) ;"not referenced, removed 2/27/85 by SEM"
	 <COND (<L? .N1 .N2> .N1)
	       (T .N2)>>

<ROUTINE SWORD-FCN ("AUX" G)
	 <COND (<AND <VERB? TAKE> <EQUAL? ,WINNER ,ADVENTURER>>
		<ENABLE <QUEUE I-SWORD -1>>
		<>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? <SET G <GETP ,SWORD ,P?TVALUE>> 1>
		       <TELL
"Your sword is glowing with a faint blue glow." CR>)
		      (<EQUAL? .G 2>
		       <TELL
"Your sword is glowing very brightly." CR>)>)>>

<ROUTINE RAINBOW-FCN ()
	 <COND (<VERB? CROSS THROUGH>
		<COND (<EQUAL? ,HERE ,CANYON-VIEW>
		       <TELL "From here?!?" CR>
		       <RTRUE>)>
		<TELL "I didn't know you could walk on water vapor."
			     CR>)
	       (<VERB? LOOK-UNDER>
		<TELL "The Frigid River flows under the rainbow." CR>)>>

<ROUTINE RIVER-FUNCTION ()
	 <COND (<VERB? PUT>
		<COND (<EQUAL? ,PRSI ,RIVER>
		       <COND (<EQUAL? ,PRSO ,ME>
			      <JIGS-UP
"You splash around for a while, fighting the current, then you drown.">)
			     (<FSET? ,PRSO ,BURNBIT>
			      <REMOVE-CAREFULLY ,PRSO>
			      <TELL
"The " D ,PRSO " floats for a moment, then sinks." CR>)
			     (T
			      <REMOVE-CAREFULLY ,PRSO>
			      <TELL
"The " D ,PRSO " splashes into the water and is gone forever." CR>)>)>)
	       (<VERB? LEAP THROUGH>
		<TELL
"A look before leaping reveals that the river is wide and dangerous,
with swift currents and large, sharp, half-hidden rocks. You therefore
decide to forgo your ill-considered swim." CR>)>>

;<ROUTINE BREATHE () ;"not referenced, removed 2/27/85 by SEM"
	 <PERFORM ,V?INFLATE ,PRSO ,LUNGS>>

<ROUTINE TREE-ROOM (RARG "AUX" F)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are about 10 feet above the ground nestled among some large
branches. The nearest branch above you is above your reach." CR>
		<COND (<AND <SET F <FIRST? ,PATH>>
			    <NEXT? .F>>
		       <TELL "On the ground below you can see:  ">
		       <PRINT-CONTENTS ,PATH>
		       <TELL "." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? CLIMB-DOWN> <EQUAL? ,PRSO ,TREE>>
		       <DO-WALK ,P?DOWN>)
		      (<AND <VERB? CLIMB-UP CLIMB-FOO>
			    <EQUAL? ,PRSO ,TREE>>
		       <DO-WALK ,P?UP>)
		      (<VERB? DROP>
		       <COND (<NOT <IDROP>> <RTRUE>)
			     (<AND <EQUAL? ,PRSO ,NEST> <IN? ,EGG ,NEST>>
			      <TELL
"The nest falls to the ground, and the egg spills out of it, seriously
damaged." CR>
			      <REMOVE-CAREFULLY ,EGG>
			      <MOVE ,BROKEN-EGG ,PATH>)
			     (<EQUAL? ,PRSO ,EGG>
			      <TELL
"The egg falls to the ground and springs open, seriously damaged.">
			      <MOVE ,EGG ,PATH>
			      <BAD-EGG>
			      <CRLF>)
			     (<NOT <EQUAL? ,PRSO ,WINNER ,TREE>>
			      <MOVE ,PRSO ,PATH>
			      <TELL
"The " D ,PRSO " falls to the ground." CR>)
			     (<VERB? LEAP>
			      <JIGS-UP
			        "That was just a bit too far down.">)>)>)
	       (<EQUAL? .RARG ,M-ENTER> <ENABLE <QUEUE I-FOREST-ROOM -1>>)>>

<ROUTINE EGG-OBJECT ()
	 <COND (<AND <VERB? OPEN MUNG> <EQUAL? ,PRSO ,EGG>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "The egg is already open." CR>)
		      (<NOT ,PRSI>
		       <TELL "You have neither the tools nor the expertise."
			     CR>)
		      (<EQUAL? ,PRSI ,HANDS>
		       <TELL "I doubt you could do that without damaging it."
			     CR>)
		      (<OR <FSET? ,PRSI ,WEAPONBIT>
			   <FSET? ,PRSI ,TOOLBIT>
			   <VERB? MUNG>>
		       <TELL
"The egg is now open, but the clumsiness of your attempt has seriously
compromised its esthetic appeal.">
		       <BAD-EGG>
		       <CRLF>)
		      (<FSET? ,PRSO ,FIGHTBIT>
		       <TELL "Not to say that using the "
			     D ,PRSI
			     " isn't original too..." CR>)
		      (T
		       <TELL "The concept of using a "
			     D ,PRSI
			     " is certainly original." CR>
		       <FSET ,PRSO ,FIGHTBIT>)>)
	       (<VERB? CLIMB-ON HATCH>
		<TELL
"There is a noticeable crunch from beneath you, and inspection reveals
that the egg is lying open, badly damaged.">
		<BAD-EGG>
		<CRLF>)
	       (<VERB? OPEN MUNG THROW>
		<COND (<VERB? THROW> <MOVE ,PRSO ,HERE>)>
		<TELL
"Your rather indelicate handling of the egg has caused it some damage,
although you have succeeded in opening it.">
		<BAD-EGG>
		<CRLF>)>>

<ROUTINE BAD-EGG ("AUX" L)
	 <COND (<IN? ,CANARY ,EGG>
		<TELL " " <GETP ,BROKEN-CANARY ,P?FDESC>>)
	       (T <REMOVE-CAREFULLY ,BROKEN-CANARY>)>
	 <MOVE ,BROKEN-EGG <LOC ,EGG>>
	 <REMOVE-CAREFULLY ,EGG>
	 <RTRUE>>

;<GLOBAL SING-SONG <>> ;"not referenced, removed 2/27/85 by SEM"

<ROUTINE CANARY-OBJECT ()
	 <COND (<VERB? WIND>
		<TELL
"There is an unpleasant grinding noise from inside the canary." CR>)>>

<ROUTINE FOREST-ROOM? ()
	 <OR <EQUAL? ,HERE ,FOREST-1 ,FOREST-2 ,FOREST-3>
	     <EQUAL? ,HERE ,PATH ,UP-A-TREE>>>

<ROUTINE I-FOREST-ROOM ()
	 <COND (<NOT <FOREST-ROOM?>>
		<DISABLE <INT I-FOREST-ROOM>>
		<RFALSE>)
	       (<PROB 15>
		<TELL
"You hear in the distance the chirping of a song bird." CR>)>>

<ROUTINE FOREST-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER> <ENABLE <QUEUE I-FOREST-ROOM -1>>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? CLIMB-FOO CLIMB-UP>
			    <EQUAL? ,PRSO ,TREE>>
		       <DO-WALK ,P?UP>)>)>>

<ROUTINE MOUNTAINS-ROOM (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? CLIMB-FOO CLIMB-UP>
		     <EQUAL? ,PRSO ,TREE>>
		<TELL "There is no tree here suitable for climbing." CR>)>>

<ROUTINE ROPE-FUNCTION ("AUX" RLOC)
	 <COND (<VERB? TIE>
		<TELL "You can't tie the rope to that." CR>)>>

;<ROUTINE UNTIE-FROM () ;"not referenced, removed 2/27/85 by SEM"
	 <TELL "It's not attached to that!" CR>>

<ROUTINE SLIDE-FUNCTION ()
	 <COND (<OR <VERB? THROUGH CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		    <AND <VERB? PUT>
			 <EQUAL? ,PRSO ,ME>>>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (<VERB? PUT>
		<SLIDER ,PRSO>)>>

<ROUTINE SLIDER (OBJ)
	 <COND (<FSET? .OBJ ,TAKEBIT>
		<TELL "The " D .OBJ " falls into the slide and is gone." CR>
		<COND (<EQUAL? .OBJ ,WATER> <REMOVE-CAREFULLY .OBJ>)
		      (T
		       <MOVE .OBJ ,CELLAR>)>)
	       (T <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE CLIFF-OBJECT ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<TELL
		 "That would be very unwise. Perhaps even fatal." CR>)
	       (<EQUAL? ,PRSI ,CLIMBABLE-CLIFF>
		<COND (<VERB? PUT THROW-OFF>
		       <TELL
"The " D ,PRSO " tumbles end over end into the river and is seen no more." CR>
		       <REMOVE-CAREFULLY ,PRSO>)>)>>

<ROUTINE SANDWICH-BAG-FCN ()
	 <COND (<AND <VERB? SMELL>
		     <IN? ,LUNCH ,PRSO>>
		<TELL "It smells of hot peppers." CR>)>>

"MORE RANDOMNESS"

<ROUTINE DOOR-PSEUDO () ;"in Studio"
	 <COND (<VERB? OPEN CLOSE>
		<TELL "The door won't budge." CR>)
	       (<VERB? THROUGH>
		<DO-WALK ,P?SOUTH>)>>

<ROUTINE PAINT-PSEUDO ()
	 <COND (<VERB? MUNG>
		<TELL "Some paint chips away, revealing more paint." CR>)>>

"SUBTITLE MELEE"

"melee actions (object functions for villains called with these"

<CONSTANT F-BUSY? 1>		;"busy recovering weapon?"
<CONSTANT F-DEAD 2>		;"mistah kurtz, he dead."
<CONSTANT F-UNCONSCIOUS 3>	;"into dreamland"
<CONSTANT F-CONSCIOUS 4>	;"rise and shine"
<CONSTANT F-FIRST? 5>		;"strike first?"

\

"blow results"

<CONSTANT MISSED 1>		;"attacker misses"
<CONSTANT UNCONSCIOUS 2>	;"defender unconscious"
<CONSTANT KILLED 3>		;"defender dead"
<CONSTANT LIGHT-WOUND 4>	;"defender lightly wounded"
<CONSTANT SERIOUS-WOUND 5>	;"defender seriously wounded"
<CONSTANT STAGGER 6>		;"defender staggered (miss turn)"
<CONSTANT LOSE-WEAPON 7>	;"defender loses weapon"
<CONSTANT HESITATE 8>		;"hesitates (miss on free swing)"
<CONSTANT SITTING-DUCK 9>	;"sitting duck (crunch!)"

"tables of melee results"

<GLOBAL DEF1
	<TABLE
	 MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 UNCONSCIOUS UNCONSCIOUS
	 KILLED KILLED KILLED KILLED KILLED>>

<GLOBAL DEF2A
	<TABLE
	 MISSED MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND
	 UNCONSCIOUS>>

<GLOBAL DEF2B
	<TABLE
	 MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 UNCONSCIOUS
	 KILLED KILLED KILLED>>

<GLOBAL DEF3A
	<TABLE
	 MISSED MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF3B
	<TABLE
	 MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF3C
	<TABLE
	 MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF1-RES
	<TABLE DEF1
	       0 ;<REST ,DEF1 2>
	       0 ;<REST ,DEF1 4>>>

<GLOBAL DEF2-RES
	<TABLE DEF2A
	       DEF2B
	       0; <REST ,DEF2B 2>
	       0; <REST ,DEF2B 4>>>

<GLOBAL DEF3-RES
	<TABLE DEF3A
	       0 ;<REST ,DEF3A 2>
	       DEF3B
	       0 ;<REST ,DEF3B 2>
	       DEF3C>>

\

"useful constants"

<CONSTANT STRENGTH-MAX 7>
<CONSTANT STRENGTH-MIN 2>
<CONSTANT CURE-WAIT 30>

\

"I-FIGHT moved to DEMONS"

<ROUTINE DO-FIGHT (LEN "AUX" CNT RES O OO (OUT <>))
	<REPEAT ()
	      <SET CNT 0>
	      <REPEAT ()
		      <SET CNT <+ .CNT 1>>
		      <COND (<G? .CNT .LEN>
			     <SET RES T>
			     <RETURN T>)>
		      <SET OO <GET ,VILLAINS .CNT>>
		      <SET O <GET .OO ,V-VILLAIN>>
		      <COND (<NOT <FSET? .O ,FIGHTBIT>>)
			    (<APPLY <GETP .O ,P?ACTION>
				    ,F-BUSY?>)
			    (<NOT <SET RES
				       <VILLAIN-BLOW
					.OO
					.OUT>>>
			     <SET RES <>>
			     <RETURN>)
			    (<EQUAL? .RES ,UNCONSCIOUS>
			     <SET OUT <+ 1 <RANDOM 3>>>)>>
	      <COND (.RES
		     <COND (<NOT .OUT> <RETURN>)
			   (T
			    <SET OUT <- .OUT 1>>
			    <COND (<0? .OUT> <RETURN>)>)>)
		    (T <RETURN>)>>>

\

"takes a remark, defender, and good-guy's weapon"

<ROUTINE REMARK (REMARK D W "AUX" (LEN <GET .REMARK 0>) (CNT 0) STR)
	 <REPEAT ()
	         <COND (<G? <SET CNT <+ .CNT 1>> .LEN> <RETURN>)>
		 <SET STR <GET .REMARK .CNT>>
		 <COND (<EQUAL? .STR ,F-WEP> <PRINTD .W>)
		       (<EQUAL? .STR ,F-DEF> <PRINTD .D>)
		       (T <PRINT .STR>)>>
	 <CRLF>>

"Strength of the player is a basic value (S) adjusted by his P?STRENGTH
property, which is normally 0"

<ROUTINE FIGHT-STRENGTH ("OPTIONAL" (ADJUST? T) "AUX" S)
	 <SET S
	      <+ ,STRENGTH-MIN
		 </ ,SCORE
		    </ 350
		       <- ,STRENGTH-MAX ,STRENGTH-MIN>>>>>
	 <COND (.ADJUST? <+ .S <GETP ,WINNER ,P?STRENGTH>>)(T .S)>>

<ROUTINE VILLAIN-STRENGTH (OO
			   "AUX" (VILLAIN <GET .OO ,V-VILLAIN>)
			   OD TMP)
	 <SET OD <GETP .VILLAIN ,P?STRENGTH>>
	 <COND (<NOT <L? .OD 0>>
		<COND (<AND ,PRSI
			    <FSET? ,PRSI ,WEAPONBIT>
			    <EQUAL? <GET .OO ,V-BEST> ,PRSI>>
		       <SET TMP <- .OD <GET .OO ,V-BEST-ADV>>>
		       <COND (<L? .TMP 1> <SET TMP 1>)>
		       <SET OD .TMP>)>)>
	 .OD>

"find a weapon (if any) in possession of argument"

<ROUTINE FIND-WEAPON (O "AUX" W)
	 <SET W <FIRST? .O>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<EQUAL? .W ,AXE ,SWORD ,KNIFE>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RFALSE>)>>>

\

<ROUTINE VILLAIN-BLOW (OO OUT?
		       "AUX" (VILLAIN <GET .OO ,V-VILLAIN>)
		       (REMARKS <GET .OO ,V-MSGS>)
		       DWEAPON ATT DEF OA OD TBL RES NWEAPON)
	 <FCLEAR ,WINNER ,STAGGERED>
	 <COND (<FSET? .VILLAIN ,STAGGERED>
		<TELL "The " D .VILLAIN
		      " slowly regains his feet." CR>
		<FCLEAR .VILLAIN ,STAGGERED>
		<RTRUE>)>
	 <SET OA <SET ATT <VILLAIN-STRENGTH .OO>>>
	 <COND (<NOT <G? <SET DEF <FIGHT-STRENGTH>> 0>> <RTRUE>)>
	 <SET OD <FIGHT-STRENGTH <>>>
	 <SET DWEAPON <FIND-WEAPON ,WINNER>>
	 <COND (<L? .DEF 0> <SET RES ,KILLED>)
	       (T
		<COND (<1? .DEF>
		       <COND (<G? .ATT 2> <SET ATT 3>)>
		       <SET TBL <GET ,DEF1-RES <- .ATT 1>>>)
		      (<EQUAL? .DEF 2>
		       <COND (<G? .ATT 3> <SET ATT 4>)>
		       <SET TBL <GET ,DEF2-RES <- .ATT 1>>>)
		      (<G? .DEF 2>
		       <SET ATT <- .ATT .DEF>>
		       <COND (<L? .ATT -1> <SET ATT -2>)
			     (<G? .ATT 1> <SET ATT 2>)>
		       <SET TBL <GET ,DEF3-RES <+ .ATT 2>>>)>
		<SET RES <GET .TBL <- <RANDOM 9> 1>>>
		<COND (.OUT?
		       <COND (<EQUAL? .RES ,STAGGER> <SET RES ,HESITATE>)
			     (T <SET RES ,SITTING-DUCK>)>)>
		<COND (<AND <EQUAL? .RES ,STAGGER>
			    .DWEAPON
			    <PROB 25 <COND (.HERO? 10)(T 50)>>>
		       <SET RES ,LOSE-WEAPON>)>
		<REMARK
		  <RANDOM-ELEMENT <GET .REMARKS <- .RES 1>>>
		  ,WINNER
		  .DWEAPON>)>
	 <COND (<OR <EQUAL? .RES ,MISSED> <EQUAL? .RES ,HESITATE>>)
	       (<EQUAL? .RES ,UNCONSCIOUS>)
	       (<OR <EQUAL? .RES ,KILLED>
		    <EQUAL? .RES ,SITTING-DUCK>>
		<SET DEF 0>)
	       (<EQUAL? .RES ,LIGHT-WOUND>
		<SET DEF <- .DEF 1>>
		<COND (<L? .DEF 0> <SET DEF 0>)>
		<COND (<G? ,LOAD-ALLOWED 50>
		       <SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 10>>)>)
	       (<EQUAL? .RES ,SERIOUS-WOUND>
		<SET DEF <- .DEF 2>>
		<COND (<L? .DEF 0> <SET DEF 0>)>
		<COND (<G? ,LOAD-ALLOWED 50>
		       <SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 20>>)>)
	       (<EQUAL? .RES ,STAGGER> <FSET ,WINNER ,STAGGERED>)
	       (T
		<AND <EQUAL? .RES ,LOSE-WEAPON> .DWEAPON>
		<MOVE .DWEAPON ,HERE>
		<COND (<SET NWEAPON <FIND-WEAPON ,WINNER>>
		       <TELL
"Fortunately, you still have " A .NWEAPON "." CR>)>)>
	 <WINNER-RESULT .DEF .RES .OD>>

<ROUTINE HERO-BLOW ("AUX" OO VILLAIN (OUT? <>) DWEAPON ATT DEF (CNT 0)
		    OA OD TBL RES NWEAPON (LEN <GET ,VILLAINS 0>))
	 <REPEAT ()
		 <SET CNT <+ .CNT 1>>
		 <COND (<G? .CNT .LEN> <RETURN>)>
		 <SET OO <GET ,VILLAINS .CNT>>
		 <COND (<EQUAL? <GET .OO ,V-VILLAIN> ,PRSO>
			<RETURN>)>>
	 <FSET ,PRSO ,FIGHTBIT>
	 <COND (<FSET? ,WINNER ,STAGGERED>
		<TELL
"You are still recovering from that last blow, so your attack is
ineffective." CR>
		<FCLEAR ,WINNER ,STAGGERED>
		<RTRUE>)>
	 <SET ATT <FIGHT-STRENGTH>>
	 <COND (<L? .ATT 1> <SET ATT 1>)>
	 <SET OA .ATT>
	 <SET VILLAIN <GET .OO ,V-VILLAIN>>
	 <COND (<0? <SET OD <SET DEF <VILLAIN-STRENGTH .OO>>>>
		<COND (<EQUAL? ,PRSO ,WINNER>
		       <RETURN <JIGS-UP
"Well, you really did it that time. Is suicide painless?">>)>
		<TELL "Attacking the " D .VILLAIN " is pointless." CR>
		<RTRUE>)>
	 <SET DWEAPON <FIND-WEAPON .VILLAIN>>
	 <COND (<OR <NOT .DWEAPON> <L? .DEF 0>>
		<TELL "The ">
		<COND (<NOT .DWEAPON> <TELL "unarmed">)
		      (T <TELL "unconscious">)>
		<TELL " " D .VILLAIN
		      " cannot defend himself:  He dies." CR>
		<SET RES ,KILLED>)
	       (T
		<COND (<1? .DEF>
		       <COND (<G? .ATT 2> <SET ATT 3>)>
		       <SET TBL <GET ,DEF1-RES <- .ATT 1>>>)
		      (<EQUAL? .DEF 2>
		       <COND (<G? .ATT 3> <SET ATT 4>)>
		       <SET TBL <GET ,DEF2-RES <- .ATT 1>>>)
		      (<G? .DEF 2>
		       <SET ATT <- .ATT .DEF>>
		       <COND (<L? .ATT -1> <SET ATT -2>)
			     (<G? .ATT 1> <SET ATT 2>)>
		       <SET TBL <GET ,DEF3-RES <+ .ATT 2>>>)>
		<SET RES <GET .TBL <- <RANDOM 9> 1>>>
		<COND (.OUT?
		       <COND (<EQUAL? .RES ,STAGGER> <SET RES ,HESITATE>)
			     (T <SET RES ,SITTING-DUCK>)>)>
		<COND (<AND <EQUAL? .RES ,STAGGER> .DWEAPON <PROB 25>>
		       <SET RES ,LOSE-WEAPON>)>
		<REMARK
		  <RANDOM-ELEMENT <GET ,HERO-MELEE <- .RES 1>>>
		  ,PRSO
		  ,PRSI>)>
	 <COND (<OR <EQUAL? .RES ,MISSED> <EQUAL? .RES ,HESITATE>>)
	       (<EQUAL? .RES ,UNCONSCIOUS> <SET DEF <- .DEF>>)
	       (<OR <EQUAL? .RES ,KILLED> <EQUAL? .RES ,SITTING-DUCK>>
		<SET DEF 0>)
	       (<EQUAL? .RES ,LIGHT-WOUND>
		<SET DEF <- .DEF 1>>
		<COND (<L? .DEF 0> <SET DEF 0>)>)
	       (<EQUAL? .RES ,SERIOUS-WOUND>
		<SET DEF <- .DEF 2>>
		<COND (<L? .DEF 0> <SET DEF 0>)>)
	       (<EQUAL? .RES ,STAGGER> <FSET ,PRSO ,STAGGERED>)
	       (T
		<AND <EQUAL? .RES ,LOSE-WEAPON> .DWEAPON>
		<FCLEAR .DWEAPON ,NDESCBIT>
		<FSET .DWEAPON ,WEAPONBIT>
		<MOVE .DWEAPON ,HERE>
		<THIS-IS-IT .DWEAPON>)>
	 <VILLAIN-RESULT ,PRSO .DEF .RES>>

\

<ROUTINE WINNER-RESULT (DEF RES OD)
	 <PUTP ,WINNER
	       ,P?STRENGTH
	       <COND (<0? .DEF> -10000)(T <- .DEF .OD>)>>
	 <COND (<L? <- .DEF .OD> 0>
		<ENABLE <QUEUE I-CURE ,CURE-WAIT>>)>
	 <COND (<NOT <G? <FIGHT-STRENGTH> 0>>
		<PUTP ,WINNER ,P?STRENGTH <+ 1 <- <FIGHT-STRENGTH <>>>>>
		<JIGS-UP
"It appears that that last blow was too much for you. I'm afraid you
are dead.">
		<>)
	       (T .RES)>>

<ROUTINE VILLAIN-RESULT (VILLAIN DEF RES)
	 <PUTP .VILLAIN ,P?STRENGTH .DEF>
	 <COND (<0? .DEF>
		<FCLEAR .VILLAIN ,FIGHTBIT>
		<TELL
"Almost as soon as the " D .VILLAIN " breathes his last breath, a cloud
of sinister black fog envelops him, and when the fog lifts, the
carcass has disappeared." CR>
		<REMOVE-CAREFULLY .VILLAIN>
		<APPLY <GETP .VILLAIN ,P?ACTION> ,F-DEAD>
		.RES)
	       (<EQUAL? .RES ,UNCONSCIOUS>
		<APPLY <GETP .VILLAIN ,P?ACTION> ,F-UNCONSCIOUS>
		.RES)
	       (T .RES)>>

\

;<ROUTINE WINNING? (V "AUX" VS PS) ;"not referenced, removed 2/27/85 by SEM"
	 <SET VS <GETP .V ,P?STRENGTH>>
	 <SET PS <- .VS <FIGHT-STRENGTH>>>
	 <COND (<G? .PS 3> <PROB 90>)
	       (<G? .PS 0> <PROB 75>)
	       (<0? .PS> <PROB 50>)
	       (<G? .VS 1> <PROB 25>)
	       (T <PROB 10>)>>

<ROUTINE I-CURE ("AUX" (S <GETP ,WINNER ,P?STRENGTH>))
	 <COND (<G? .S 0> <SET S 0> <PUTP ,WINNER ,P?STRENGTH .S>)
	       (<L? .S 0> <SET S <+ .S 1>> <PUTP ,WINNER ,P?STRENGTH .S>)>
	 <COND (<L? .S 0>
		<COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
		       <SETG LOAD-ALLOWED <+ ,LOAD-ALLOWED 10>>)>
		<ENABLE <QUEUE I-CURE ,CURE-WAIT>>)
	       (T
		<SETG LOAD-ALLOWED ,LOAD-MAX>
		<DISABLE <INT I-CURE>>)>>

"FIGHTS"

"messages for winner"

<CONSTANT F-WEP 0>	;"means print weapon name"
<CONSTANT F-DEF 1>	;"means print defender name (villain, e.g.)"

<GLOBAL HERO-MELEE
 <TABLE
  <LTABLE
   <LTABLE "Your " F-WEP " misses the " F-DEF " by an inch.">
   <LTABLE "A good slash, but it misses the " F-DEF " by a mile.">
   <LTABLE "You charge, but the " F-DEF " jumps nimbly aside.">
   <LTABLE "Clang! Crash! The " F-DEF " parries.">
   <LTABLE "A quick stroke, but the " F-DEF " is on guard.">
   <LTABLE "A good stroke, but it's too slow; the " F-DEF " dodges.">>
  <LTABLE
   <LTABLE "Your " F-WEP " crashes down, knocking the " F-DEF " into dreamland.">
   <LTABLE "The " F-DEF " is battered into unconsciousness.">
   <LTABLE "A furious exchange, and the " F-DEF " is knocked out!">
   <LTABLE "The haft of your " F-WEP " knocks out the " F-DEF ".">
   <LTABLE "The " F-DEF " is knocked out!">>
  <LTABLE
   <LTABLE "It's curtains for the " F-DEF " as your " F-WEP " removes his head.">
   <LTABLE "The fatal blow strikes the " F-DEF " square in the heart:  He dies.">
   <LTABLE "The " F-DEF " takes a fatal blow and slumps to the floor dead.">>
  <LTABLE
   <LTABLE "The " F-DEF " is struck on the arm; blood begins to trickle down.">
   <LTABLE "Your " F-WEP " pinks the " F-DEF " on the wrist, but it's not serious.">
   <LTABLE "Your stroke lands, but it was only the flat of the blade.">
   <LTABLE "The blow lands, making a shallow gash in the " F-DEF "'s arm!">>
  <LTABLE
   <LTABLE "The " F-DEF " receives a deep gash in his side.">
   <LTABLE "A savage blow on the thigh! The " F-DEF " is stunned but can still fight!">
   <LTABLE "Slash! Your blow lands! That one hit an artery, it could be serious!">
   <LTABLE "Slash! Your stroke connects! This could be serious!">>
  <LTABLE
   <LTABLE "The " F-DEF " is staggered, and drops to his knees.">
   <LTABLE "The " F-DEF " is momentarily disoriented and can't fight back.">
   <LTABLE "The force of your blow knocks the " F-DEF " back, stunned.">
   <LTABLE "The " F-DEF " is confused and can't fight back.">
   <LTABLE "The quickness of your thrust knocks the " F-DEF " back, stunned.">>
  <LTABLE
   <LTABLE "The " F-DEF "'s weapon is knocked to the floor, leaving him unarmed.">
   <LTABLE "The " F-DEF " is disarmed by a subtle feint past his guard.">>>>

"messages for troll"

<GLOBAL TROLL-MELEE

<TABLE
 <LTABLE
  <LTABLE "The troll swings his axe, but it misses.">
  <LTABLE "The troll's axe barely misses your ear.">
  <LTABLE "The axe sweeps past as you jump aside.">
  <LTABLE "The axe crashes against the rock, throwing sparks!">>
 <LTABLE
  <LTABLE "The flat of the troll's axe hits you delicately on the head, knocking
you out.">>
 <LTABLE
  <LTABLE "The troll neatly removes your head.">
  <LTABLE "The troll's axe stroke cleaves you from the nave to the chops.">
  <LTABLE "The troll's axe removes your head.">>
 <LTABLE
  <LTABLE "The axe gets you right in the side. Ouch!">
  <LTABLE "The flat of the troll's axe skins across your forearm.">
  <LTABLE "The troll's swing almost knocks you over as you barely parry
in time.">
  <LTABLE "The troll swings his axe, and it nicks your arm as you dodge.">>
 <LTABLE
  <LTABLE "The troll charges, and his axe slashes you on your " F-WEP " arm.">
  <LTABLE "An axe stroke makes a deep wound in your leg.">
  <LTABLE "The troll's axe swings down, gashing your shoulder.">>
 <LTABLE
  <LTABLE "The troll hits you with a glancing blow, and you are momentarily
stunned.">
  <LTABLE "The troll swings; the blade turns on your armor but crashes
broadside into your head.">
  <LTABLE "You stagger back under a hail of axe strokes.">
  <LTABLE "The troll's mighty blow drops you to your knees.">>
 <LTABLE
  <LTABLE "The axe hits your " F-WEP " and knocks it spinning.">
  <LTABLE "The troll swings, you parry, but the force of his blow knocks your " F-WEP " away.">
  <LTABLE "The axe knocks your " F-WEP " out of your hand. It falls to the floor.">>
 <LTABLE
  <LTABLE "The troll hesitates, fingering his axe.">
  <LTABLE "The troll scratches his head ruminatively:  Might you be magically
protected, he wonders?">>
 <LTABLE
  <LTABLE "Conquering his fears, the troll puts you to death.">>>>

"each table entry is:"

<CONSTANT V-VILLAIN 0>	;"villain"
<CONSTANT V-BEST 1>	;"best weapon"
<CONSTANT V-BEST-ADV 2>	;"advantage it confers"
<CONSTANT V-PROB 3>	;"prob of waking if unconscious"
<CONSTANT V-MSGS 4>	;"messages for that villain"

"This table must be after TROLL-MELEE,  defined!"

<GLOBAL VILLAINS
	<LTABLE <TABLE TROLL SWORD 1 0 TROLL-MELEE>>>

"DEMONS"

"Fighting demon"

<ROUTINE I-FIGHT ("AUX" (FIGHT? <>) (LEN <GET ,VILLAINS 0>)
		  CNT OO O P)
      <COND (,DEAD <RFALSE>)>
      <SET CNT 0>
      <REPEAT ()
	      <SET CNT <+ .CNT 1>>
	      <COND (<G? .CNT .LEN> <RETURN>)>
	      <SET OO <GET ,VILLAINS .CNT>>
	      <COND (<AND <IN? <SET O <GET .OO ,V-VILLAIN>> ,HERE>
			  <NOT <FSET? .O ,INVISIBLE>>>
		     <COND (<L? <GETP .O ,P?STRENGTH> 0>
			    <SET P <GET .OO ,V-PROB>>
			    <COND (<AND <NOT <0? .P>> <PROB .P>>
				   <PUT .OO ,V-PROB 0>
				   <AWAKEN .O>)
				  (T
				   <PUT .OO ,V-PROB <+ .P 25>>)>)
			   (<OR <FSET? .O ,FIGHTBIT>
				<APPLY <GETP .O ,P?ACTION> ,F-FIRST?>>
			    <SET FIGHT? T>)>)
		    (T
		     <COND (<FSET? .O ,FIGHTBIT>
			    <APPLY <GETP .O ,P?ACTION> ,F-BUSY?>)>
		     <FCLEAR ,WINNER ,STAGGERED>
		     <FCLEAR .O ,STAGGERED>
		     <FCLEAR .O ,FIGHTBIT>
		     <AWAKEN .O>)>>
      <COND (<NOT .FIGHT?> <RFALSE>)>
      <DO-FIGHT .LEN>>

<ROUTINE AWAKEN (O "AUX" (S <GETP .O ,P?STRENGTH>))
	 <COND (<L? .S 0>
		<PUTP .O ,P?STRENGTH <- 0 .S>>
		<APPLY <GETP .O ,P?ACTION> ,F-CONSCIOUS>)>
	 T>

"SWORD demon"

<ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (G <GETP ,SWORD ,P?TVALUE>)
		        (NG 0) P T L)
	 <COND (<IN? ,SWORD ,ADVENTURER>
		<COND (<INFESTED? ,HERE> <SET NG 2>)
		      (T
		       <SET P 0>
		       <REPEAT ()
			       <COND (<0? <SET P <NEXTP ,HERE .P>>>
				      <RETURN>)
				     (<NOT <L? .P ,LOW-DIRECTION>>
				      <SET T <GETPT ,HERE .P>>
				      <SET L <PTSIZE .T>>
				      <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
					     <COND (<INFESTED? <GETB .T 0>>
						    <SET NG 1>
						    <RETURN>)>)>)>>)>
		<COND (<EQUAL? .NG .G> <RFALSE>)
		      (<EQUAL? .NG 2>
		       <TELL "Your sword has begun to glow very brightly." CR>)
		      (<1? .NG>
		       <TELL "Your sword is glowing with a faint blue glow."
			     CR>)
		      (<0? .NG>
		       <TELL "Your sword is no longer glowing." CR>)>
		<PUTP ,SWORD ,P?TVALUE .NG>
		<RTRUE>)
	       (T
		<PUT .DEM ,C-ENABLED? 0>
		<RFALSE>)>>

<ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))
	 <REPEAT ()
		 <COND (<NOT .F> <RFALSE>)
		       (<AND <FSET? .F ,ACTORBIT> <NOT <FSET? .F ,INVISIBLE>>>
			<RTRUE>)
		       (<NOT <SET F <NEXT? .F>>> <RFALSE>)>>>

<ROUTINE V-DIAGNOSE ("AUX" (MS <FIGHT-STRENGTH <>>)
		     (WD <GETP ,WINNER ,P?STRENGTH>) (RS <+ .MS .WD>))
	 #DECL ((MS WD RS) FIX)
	 <COND (<EQUAL? ,GAME-FLAG 2>
		<SETG C-ELAPSED 18>
		<COND (<EQUAL? ,SICKNESS-LEVEL 0>
		       <TELL "You are in perfect health." CR>)
		      (T
		       <TELL "You are ">
		       <COND (<G? ,SICKNESS-LEVEL 7>
			      <TELL "severely">)
			     (<G? ,SICKNESS-LEVEL 5>
			      <TELL "very">)
			     (<G? ,SICKNESS-LEVEL 3>
			      <TELL "somewhat">)
			     (T
			      <TELL "a bit">)>
		       <TELL " sick and feverish." CR>)>
		<COND (<EQUAL? ,SLEEPY-LEVEL 0>
		       <TELL "You feel well-rested." CR>)
		      (T
		       <TELL "You feel ">
		       <COND (<G? ,SLEEPY-LEVEL 2>
			      <TELL "phenomenally">)
			     (<G? ,SLEEPY-LEVEL 1>
			      <TELL "quite">)
			     (T
			      <TELL "sort of">)>
		       <TELL " tired." CR>)>
		<COND (<EQUAL? ,HUNGER-LEVEL 0>
		       <TELL "You seem to be well-fed." CR>)
		      (T
		       <TELL "You seem to be ">
		       <COND (<G? ,HUNGER-LEVEL 4>
			      <TELL "awesomely phenomenally">)
			     (<G? ,HUNGER-LEVEL 2>
			      <TELL "noticeably">)
			     (T
			      <TELL "fairly">)>
		       <TELL " thirsty and hungry." CR>)>
		<RTRUE>)
	       (<EQUAL? ,GAME-FLAG 3>
		<TELL
"Never mind about that. Get back to finding the pyramid!" CR>
		<RTRUE>)>
	 <COND (<0? <GET <INT I-CURE> ,C-ENABLED?>> <SET WD 0>)
	       (ELSE <SET WD <- .WD>>)>
	 <COND (<0? .WD> <TELL "You are in perfect health.">)
	       (<1? .WD> <TELL "You have a light wound,">)
	       (<EQUAL? .WD 2> <TELL "You have a serious wound,">)
	       (<EQUAL? .WD 3> <TELL "You have several wounds,">)
	       (<G? .WD 3> <TELL "You have serious wounds,">)>
	 <COND (<NOT <0? .WD>>
		<TELL " that will be cured after ">
		<PRINTN
		 <+ <* ,CURE-WAIT <- .WD 1>>
		    <GET <INT I-CURE> ,C-TICK>>>
		<TELL " moves.">)>
	 <CRLF>
	 <COND (<0? .RS> <TELL "You are at death's door.">)
	       (<1? .RS> <TELL "You can be killed by one more light wound.">)
	       (<EQUAL? .RS 2> <TELL "You can be killed by a serious wound.">)
	       (<EQUAL? .RS 3> <TELL "You can survive one serious wound.">)
	       (<G? .RS 3>
		<TELL "You are strong enough to take several wounds.">)>
	 <CRLF>
	 <COND (<NOT <0? ,DEATHS>>
		<TELL "You have been killed ">
		<COND (<1? ,DEATHS> <TELL "once.">)
		      (T <TELL "twice.">)>
		<CRLF>)>>

<GLOBAL SICKNESS-LEVEL 0>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Your score is ">
	 <TELL N ,SCORE " (total of ">
	 <COND (,TUTORIAL-MODE
		<TELL "50 points for the Tutorial Game">)
	       (<EQUAL? ,GAME-FLAG 1>
		<TELL "350 points for the entire Zork I">)
	       (<EQUAL? ,GAME-FLAG 2>
		<TELL "80 points for the entire Planetfall">)
	       (<EQUAL? ,GAME-FLAG 3>
		<TELL "400 points for the entire Infidel">)>
	 <COND (<EQUAL? ,GAME-FLAG 2>
		<TELL
"). It is Day " N ,DAY " of your adventure. Current Galactic Standard Time ">
		<COND (<IN? ,CHRONOMETER ,ADVENTURER>
		       <TELL "(adjusted to your local day-cycle) is ">
		       <TELL N ,INTERNAL-MOVES>)
		      (T
		       <TELL
"is impossible to determine, since you're not wearing your chronometer">)>
		<TELL ".">)
	       (T
		<TELL "), in ">
		<TELL N ,MOVES>
		<COND (<1? ,MOVES>
		       <TELL " move.">)
		      (T
		       <TELL " moves.">)>)>
	 <CRLF>
	 ,SCORE>

<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))
 	 <TELL .DESC CR>
	 <COND (<NOT ,LUCKY>
		<TELL "Bad luck, huh?" CR>)>
	 <COND (<EQUAL? ,GAME-FLAG 1>
		<PROG ()
		      <SCORE-UPD -10>
		      <TELL "
|    ****  You have died  ****
|
|">
		      <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
			     <MOVE ,WINNER ,HERE>)>
		      <COND
		       (<NOT <L? ,DEATHS 2>>
			<TELL
"You clearly are a suicidal maniac.  We don't allow psychotics in the
cave, since they may harm other adventurers.  Your remains will be
installed in the Land of the Living Dead, where your fellow
adventurers may gloat over them. " ; CR>
			<FINISH>)
		       (T
			<SETG DEATHS <+ ,DEATHS 1>>
			<MOVE ,WINNER ,HERE>
			<TELL
"Now, let's take a look here...
Well, you probably deserve another chance.  I can't quite fix you
up completely, but you can't have everything." CR CR>
			<GOTO ,FOREST-1>
			<FCLEAR ,TRAP-DOOR ,TOUCHBIT>
			<SETG P-CONT <>>
			<RANDOMIZE-OBJECTS>
			<KILL-INTERRUPTS>)>>)
	       (<EQUAL? ,GAME-FLAG 2>
		<PROG ()
		      <TELL "
|    ****  You have died  ****
|
|"> 
		      <TELL "Oh, well. ">
		      <COND (<NOT <FSET? ,PF-KEY ,TOUCHBIT>>
			     <TELL
"Maybe next time you'll find something attractive in the Tool Room." CR CR>)>
		      <TELL
"According to the Treaty of Gishen IV, signed in 8747 GY, all
adventure game players must be given another chance after dying. ">
		    ; <TELL " In the
interests of interstellar peace, would you like to play again?
(YES is affirmative): ">
		      <FINISH>
		    ; <COND (<YES?>
			     <RESTART>)
			    (T
			     <FINISH>)>>)
	       (<EQUAL? ,GAME-FLAG 3>
		<TELL CR "
|    ****  You have died  ****
|
|
You feel yourself disembodied in a deep blackness. A voice from the void, or
perhaps it's just your dying thoughts, rings in your ears.|
|
\"Obsessions are the torment of men's souls, reaching out for something greater
than life has offered. Perhaps this is what makes the difference between an
ordinary mortal and an adventurer!\" It is the last thing you hear. " ; CR ; CR>
		<COND (<OR <NOT <FSET? ,MAP ,TOUCHBIT>>
			   <NOT <FSET? ,BLACK-BOX ,TOUCHBIT>>>
		       <TELL CR CR "Have you opened ">
		       <COND (<NOT <FSET? ,MAP ,TOUCHBIT>>
			      <TELL "the trunk in your tent">
			      <COND (<NOT <FSET? ,BLACK-BOX ,TOUCHBIT>>
				     <TELL ", and opened ">)>)>
		       <COND (<NOT <FSET? ,BLACK-BOX ,TOUCHBIT>>
			      <TELL "the crate that the plane dropped">)>
		       <TELL "? " ; CR ; CR>)>
		 <FINISH>
	       ; <TELL
"If you would like to give it another try? (YES is affirmative): ">
	      ;  <COND (<YES?>
		       <RESTART>)
		      (T
		       <FINISH>)>)>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)
	 <COND (<IN? ,LAMP ,WINNER>
		<MOVE ,LAMP ,LIVING-ROOM>)>
	 <PUTP ,SWORD ,P?TVALUE 0>
	 <SET N <FIRST? ,WINNER>>
	 <SET L <GET ,ABOVE-GROUND 0>>
	 <REPEAT ()
		 <SET F .N>
		 <COND (<NOT .F> <RETURN>)>
		 <SET N <NEXT? .F>>
		 <COND (<G? <GETP .F ,P?TVALUE> 0>
			<REPEAT ()
				<COND (<NOT .R> <SET R <FIRST? ,ROOMS>>)>
				<COND (<AND <FSET? .R ,RLANDBIT>
					    <NOT <FSET? .R ,ONBIT>>
					    <PROB 50>>
				       <MOVE .F .R>
				       <RETURN>)
				      (ELSE <SET R <NEXT? .R>>)>>)
		       (ELSE
			<MOVE .F <GET ,ABOVE-GROUND <RANDOM .L>>>)>>>

<ROUTINE KILL-INTERRUPTS ()
	 <DISABLE <INT I-LANTERN>>
	 <DISABLE <INT I-SWORD>>
	 <DISABLE <INT I-FOREST-ROOM>>
	 <RTRUE>>

;<ROUTINE STUPID-CONTAINER (OBJ STR) ;"not referenced, removed 2/27/85 by SEM"
	 <COND (<VERB? OPEN CLOSE>
		<TELL
"The " .STR " are safely inside; there's no need to do that." CR>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<TELL
"There are lots of " .STR " in there." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI .OBJ>>
		<TELL
"Don't be silly. It wouldn't be " A .OBJ " anymore." CR>)>>

;<ROUTINE DUMB-CONTAINER () ;"not referenced, removed 2/27/85 by SEM"
	 <COND (<VERB? OPEN CLOSE LOOK-INSIDE>
		<TELL "You can't do that." CR>)
	       (<VERB? EXAMINE>
		<TELL "It looks pretty much like " A ,PRSO "." CR>)>>

<ROUTINE GARLIC-F ()
	 <COND (<VERB? EAT>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL
"What the heck! You won't make friends this way, but nobody around
here is too friendly anyhow. Gulp!" CR>)>> 

<ROUTINE TROLL-ROOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <IN? ,TROLL ,HERE>>
		<THIS-IS-IT ,TROLL>)>>

<ROUTINE CHASM-PSEUDO ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<TELL
"For a change, you look before leaping. You realize you would
never survive." CR>)
	       (<VERB? CROSS>
		<TELL "It's too far to jump, and there's no bridge." CR>)
	       (<AND <VERB? PUT THROW-OFF> <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<TELL
"The " D ,PRSO " drops out of sight into the chasm." CR>
		<REMOVE-CAREFULLY ,PRSO>)>>