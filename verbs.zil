"VERBS for
				SAMPLER
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

"Verb Functions for Game Commands"

<GLOBAL VERBOSE <>>
<GLOBAL SUPER-BRIEF <>>
<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosity." CR>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Super-brief descriptions." CR>>

;"V-DIAGNOSE is in ACTIONS.ZIL"

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER> <PRINT-CONT ,WINNER>)
	       (T <TELL "You are empty-handed." CR>)>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 <V-SCORE>
	 <COND (<OR <AND .ASK?
			 <TELL 
"Do you wish to leave this excerpt? (YES is affirmative): "> ;"was 'the game'"
			 <YES?>>
		    <NOT .ASK?>>
		<FINISH <>>)
	       (ELSE <TELL "Ok." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL
"Do you wish to leave this excerpt and return to the menu? (YES is affirmative): ">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<ROUTINE YOU-CANT (STR)
	 <TELL
"You can't use " .STR " in the Tutorial and Demonstrations,
although you can in all of Infocom's interactive fiction." CR>>

<ROUTINE V-RESTORE ()
	 <YOU-CANT "RESTORE">>

<ROUTINE V-SAVE ()
	 <YOU-CANT "SAVE">>

;"V-SCORE is in ACTIONS.ZIL"

<ROUTINE V-SCRIPT ()
	<YOU-CANT "SCRIPT">>

<ROUTINE V-UNSCRIPT ()
	<YOU-CANT "UNSCRIPT">>

<ROUTINE V-VERSION ("AUX" (CNT 17))
	<COND (,TUTORIAL-MODE
	       <TELL "Tutorial Game">)
	      (T
	       <TELL "Demonstration of ">
	       <COND (<EQUAL? ,GAME-FLAG 2>
		      <TELL "Planetfall">)
		     (<EQUAL? ,GAME-FLAG 3>
		      <TELL "Infidel">)
		     (T
		      <TELL "ZORK I">)>)>
	<TELL "|
Copyright (c) 1984 Infocom, Inc. All rights reserved.|
ZORK is a registered trademark of Infocom, Inc.|
PLANETFALL, INFIDEL, and The WITNESS are trademarks of Infocom, Inc.|
Release ">
	<PRINTN <BAND <GET 0 1> *3777*>>
	<TELL " / Serial number ">
	<REPEAT ()
		<COND (<G? <SET CNT <+ .CNT 1>> 23>
		       <RETURN>)
		      (T
		       <PRINTC <GETB 0 .CNT>>)>>
	<CRLF>>

<ROUTINE V-VERIFY ()
	 <TELL "Verifying disk..." CR>
	 <COND (<VERIFY>
		<TELL "The disk is correct." CR>)
	       (T
		<TELL CR "** Disk Failure **" CR>)>>

<ROUTINE V-DEBUG ()
	 <TELL "Turning debugging feature ">
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "off">)
	       (T
		<SETG DEBUG T>
		<TELL "on">)>
	 <TELL "." CR>>

^L

"Real Verb Functions"

<ROUTINE V-ADVENT ()
	 <TELL "A hollow voice says \"Fool.\"" CR>>

<ROUTINE HERE-AT-ALL? (OBJ "AUX" L)
	 <COND (<OR <IN? .OBJ ,HERE>
		    <IN? .OBJ ,WINNER>
		    <IN? <SET L <LOC .OBJ>> ,WINNER>
		    <AND <LOC .L>
			 <IN? <LOC .L> ,WINNER>>
		    <AND <IN? .L ,HERE>
			 <OR <NOT <FSET? .L ,CONTBIT>>
			     <FSET? .L ,OPENBIT>>>
		    <GLOBAL-IN? .OBJ ,HERE>
		    <IN? .OBJ ,GLOBAL-OBJECTS>
		    <EQUAL? .OBJ ,PSEUDO-OBJECT>>
		<RTRUE>)>>

<ROUTINE V-AGAIN ("AUX" (OBJ <>) OWINNER V)
	 <COND (<EQUAL? ,L-PRSA ,V?WALK>
		<PERFORM ,L-PRSA ,L-WALK-DIR>)
	       (T
		<COND (,L-PRSO
		       <COND (<OR <NOT <LOC ,L-PRSO>>
				  <FSET? ,L-PRSO ,INVISIBLE>
				  <NOT <HERE-AT-ALL? ,L-PRSO>>>
			      <SET OBJ ,L-PRSO>)>)>
		<COND (,L-PRSI
		       <COND (<OR <NOT <LOC ,L-PRSI>>
				  <FSET? ,L-PRSI ,INVISIBLE>
				  <NOT <HERE-AT-ALL? ,L-PRSO>>>
			      <SET OBJ ,L-PRSI>)>)>
		<COND (<AND .OBJ 
			    <NOT <EQUAL? .OBJ ,PSEUDO-OBJECT ,ROOMS>>>
		       <COND (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
			      <TELL "You can't see that here." CR>)
			     (T
			      <TELL
"You can't see the " D .OBJ " anymore." CR>)>
		       <SETG P-WON <>>
		       <RFATAL>)
		      (<NOT <IN? ,L-WINNER ,HERE>>
		       <COND (<EQUAL? ,L-WINNER ,FLOYD>
			      <TELL "Floyd">)
			     (T <TELL D ,L-WINNER>)>
		       <TELL " isn't here anymore!" CR>
		       <RFATAL>)
		      (T
		       <SET OWINNER ,WINNER>
		       <SETG WINNER ,L-WINNER>
		       <SET V <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>>
		       <COND (,P-CONT
			      <SETG WINNER .OWINNER>)>
		       <RETURN .V>)>)>>

<GLOBAL L-WINNER <>>

<ROUTINE V-ALARM ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "He's wide awake, or haven't you noticed..." CR>)
	       (T
		<TELL "The " D ,PRSO " isn't sleeping." CR>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be awaiting your answer." CR>
	 <RFATAL>>

<ROUTINE V-ASK-FOR ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (<IN? ,PRSI ,PRSO>
		      <TELL
"The " D ,PRSO " doesn't seem inclined to give up the " D ,PRSI "." CR>)
		     (T
		      <TELL
"The " D ,PRSO " isn't holding the " D ,PRSI "." CR>)>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ATTACK ()
	 <COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<TELL
"I've known strange people, but fighting " A ,PRSO "?" CR>)
	       (<OR <NOT ,PRSI>
		    <EQUAL? ,PRSI ,HANDS>>
		<TELL
"Trying to attack " A ,PRSO " with your bare hands is suicidal." CR>)
	       (<NOT <IN? ,PRSI ,WINNER>>
		<TELL "You aren't even holding the " D ,PRSI "." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"Trying to attack the " D ,PRSO " with " A ,PRSI " is suicidal." CR>)
	       (T
	        <HERO-BLOW>)>>

<ROUTINE V-ATTRACT ()
	 <TELL "Nothing interesting happens." CR>>

<ROUTINE V-ZATTRACT ()
	 <PERFORM ,V?ATTRACT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-BACK ()
	 <TELL "Sorry, my memory is poor. Please give a direction." CR>>

<ROUTINE V-BLAST ()
	 <TELL "You can't blast anything by using words." CR>>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<AND <NOT <IN? ,PRSO ,HERE>>
			    <NOT <GLOBAL-IN? ,PRSO ,HERE>>>
		       <TELL
"The " D ,PRSO " must be on the ground to be boarded." CR>)
		      (<FSET? .AV ,VEHBIT>
		       <TELL "You are already in the " D .AV "!" CR>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO ,KITCHEN-WINDOW ,SAND> <RFALSE>)
	       (<AND <EQUAL? ,HERE ,REACTOR-CONTROL>
		     <EQUAL? ,PRSO ,LOWER-ELEVATOR-CARD ,REACTOR-ELEVATOR-DOOR>
		     <NOT ,P-XNAM>
		     <EQUAL? ,P-ADJN ,W?ELEVATOR>>
		<RFALSE>)
	       (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"You have a theory on how to board " A ,PRSO ", perhaps?" CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ("AUX" AV)
	 <TELL "You are now in the " D ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<ROUTINE V-BREATHE ()
	 <PERFORM ,V?INFLATE ,PRSO ,LUNGS>>

<ROUTINE V-BRUSH ()
	 <TELL "If you wish, but heaven only knows why." CR>>

<ROUTINE V-BUG ()
	 <TELL
"Bug? Not in a flawless program like this! (Cough, cough)." CR>>

<ROUTINE PRE-BURN ()
	 <COND (<EQUAL? ,GAME-FLAG 2>
		<PERFORM ,V?ZAP ,PRSO ,PRSI>
		<RTRUE>)
	       (<FLAMING? ,PRSI>
	        <RFALSE>)
	       (T
	        <TELL "With " A ,PRSI "??!?" CR>)>>

<ROUTINE V-BURN ()
	 <COND (<FSET? ,PRSO ,BURNBIT>
		<COND (<IN? ,PRSO ,WINNER>
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL "The " D ,PRSO>
		       <JIGS-UP
" catches fire. Unfortunately, you were holding it at the time.">)
		      (T
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL
"The " D ,PRSO " catches fire and is consumed." CR>)>)
	       (T
		<TELL "You can't burn " A ,PRSO "." CR>)>>

<ROUTINE V-CHOMP ()
	 <TELL "Preposterous!" CR>>

<ROUTINE V-CLIMB-DOWN () <V-CLIMB-UP ,P?DOWN ,PRSO>>

<ROUTINE V-CLIMB-FOO ()
	 <V-CLIMB-UP ,P?UP ,PRSO>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<V-CLIMB-UP ,P?UP T>)
	       (T
		<TELL "You can't climb onto the " D ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X T)
	 <COND (<AND <NOT .OBJ> ,PRSO>
		<SET OBJ ,PRSO>)>
	 <COND (<SET T <GETPT ,HERE .DIR>>
		<COND (.OBJ
		       <SET X <PTSIZE .T>>
		       <COND (<OR <EQUAL? .X ,NEXIT>
				  <AND <EQUAL? .X ,CEXIT ,DEXIT ,UEXIT>
				       <NOT <GLOBAL-IN? ,PRSO <GETB .T 0>>>>>
			      <TELL "The " D .OBJ " do">
			      <COND (<NOT <EQUAL? .OBJ ,STAIRS>>
				     <TELL "es">)>
			      <TELL "n't lead ">
			      <COND (<==? .DIR ,P?UP>
				     <TELL "up">)
				    (T <TELL "down">)>
			      <TELL "ward." CR>
			      <RTRUE>)>)>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<NOT .OBJ>
		<TELL ,CANT-GO CR>)
	       (<AND .OBJ
		     <ZMEMQ ,W?WALL
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>>
		<TELL "Climbing the walls is to no avail." CR>)
	       (T
	        <TELL "You can't do that!" CR>)>>

<ROUTINE V-CLOSE ()
	 <COND (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<TELL "You must tell me how to do that to " A ,PRSO "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed." CR>
		       <COND (<AND ,LIT <NOT <SETG LIT <LIT? ,HERE>>>>
			      <TELL "It is now pitch black." CR>)>
		       <RTRUE>)
		      (T
	 	       <TELL "It is already closed." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "The " D ,PRSO " is now closed." CR>)
		      (T
	 	       <TELL "It is already closed." CR>)>)
	       (T
		<TELL "You cannot close that." CR>)>>

<ROUTINE V-COMMAND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "The " D ,PRSO " pays no attention." CR>)
	       (T
		<TELL "You cannot talk to that!" CR>)>>

<ROUTINE V-COUNT ("AUX" CNT)
	 <COND (<EQUAL? ,PRSO ,BLESSINGS>
	 	<TELL "Well, for one, you are in an Infocom story..." CR>)
	       (<EQUAL? ,GAME-FLAG 3>
		<TELL "You have ">
		<COND (<==? ,PRSO ,MATCHES ,MANY-MATCHES>
		       <COND (<NOT <FSET? ,MATCHES ,OPENBIT>>
			      <TELL "a closed matchbook.">
			      <RTRUE>)>
		       <SET CNT <-  ,MATCH-COUNT 1>>
		       <TELL N .CNT " match">
		       <COND (<NOT <1? .CNT>> <TELL "es.">) (ELSE <TELL ".">)>
		       <CRLF>)
		      (ELSE <TELL "a weird sense of counting!" CR>)>)
	       (T
		<TELL "You have lost your mind." CR>)>>

<ROUTINE V-CROSS ()
	 <TELL "You can't cross that!" CR>>

<ROUTINE V-CURSES ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "Insults of this nature won't help you." CR>)
		      (T
		       <TELL "What a loony!" CR>)>)
	       (<EQUAL? ,GAME-FLAG 2>
		<TELL
"Such language from an Ensign in the Stellar Patrol!" CR>)
	       (T
		<TELL
"Such language in a high-class establishment like this!" CR>)>>

<ROUTINE V-CUT ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?ATTACK ,PRSO ,PRSI>)
	       (<AND <FSET? ,PRSO ,BURNBIT>
		     <FSET? ,PRSI ,WEAPONBIT>>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL "Your skillful " D ,PRSI "smanship slices the " D ,PRSO
" into innumerable slivers which blow away." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"The \"cutting edge\" of " A ,PRSI " is hardly adequate." CR>)
	       (T
		<TELL "Strange concept, cutting the " D ,PRSO "...." CR>)>>

<ROUTINE V-DEFLATE ()
	 <TELL "Come on, now!" CR>>

<ROUTINE PRE-DIG () 
	 <COND (<OR <PRSO? ,NOT-HERE-OBJECT>
		    <NOT <EQUAL? ,GAME-FLAG 3>>>
		<RFALSE>)
	       (<NOT ,PRSI>
		<COND (<IN? ,SHOVEL ,WINNER>
		       <SETG PRSI ,SHOVEL>
		       <TELL "(with the shovel)" CR>)
		      (<IN? ,PICK-AXE ,WINNER>
		       <SETG PRSI ,PICK-AXE>
		       <TELL "(with the axe)" CR>)
		      (T <SETG PRSI ,HANDS>
		       <TELL "(with your hands)" CR>)>)>
	 <COND (<FSET? ,PRSI ,TOOLBIT> <RFALSE>)
	       (ELSE
		<TELL "Digging with the " D ,PRSI " is very silly." CR>)>>

<GLOBAL THIRST 0>

<ROUTINE V-DIG-WITH ()
	 <PERFORM ,V?DIG ,SAND ,PRSO>
	 <RTRUE>>

<ROUTINE V-HOLE-DIG ()
	 <COND (<NOT <EQUAL? ,PRSO ,HOLE>>
		<TELL "I don't know how to dig the " D ,PRSO "." CR>)
	       (<EQUAL? ,PRSI ,SAND>
		<PERFORM ,V?DIG ,SAND>
		<RTRUE>)
	       (ELSE
		<TELL "I can't dig in the " D ,PRSI "." CR>
		<RTRUE>)>>

<ROUTINE V-DIG ("AUX" COUNTER)
	 <COND (<NOT <EQUAL? ,GAME-FLAG 3>>
		<COND (<NOT ,PRSI>
		       <SETG PRSI ,HANDS>)>
		<COND (<FSET? ,PRSI ,TOOLBIT>
		       <TELL
			"Digging with the " D ,PRSI " is slow and tedious." CR>)
		      (T
		       <TELL "Digging with " A ,PRSI " is silly." CR>)>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSO ,SAND ,GROUND ,HOLE>>
		<TELL "You can't dig in that." CR>)
	       (<EQUAL? ,HERE ,RIVER-BANK>
		<TELL 
"You dig a small hole, but it quickly fills in with water and sand, almost
immediately disappearing." CR>)
	       (<NOT <GETP ,HERE ,P?CAPACITY>>
		<TELL "The ground is too hard here." CR>)
	       (<PRSI? ,HANDS>
		<TELL
		 "I suppose you also excavate tunnels with a teaspoon?!" CR>)
	       (<PRSI? ,PICK-AXE>
		<TELL
		 "Let's face it, for digging in the sand, the axe is cute but ineffective." CR>)
	       (T
		<SET COUNTER <GETP ,HERE ,P?CAPACITY>>
		<SET COUNTER <+ .COUNTER 1>>
		<SETG THIRST <+ ,THIRST 4>>
		<COND (<AND <G? .COUNTER 5>
			    <NOT <EQUAL? ,HERE ,EX2>>>
		       <JIGS-UP
"The walls of the hole collapse around you, smothering you in the shifting
sands.">
		       <RFATAL>)
		      (<AND <G? .COUNTER 5>
			    <EQUAL? ,HERE ,EX2>>
		       <COND (<G? .COUNTER 6>
			      <TELL "Enough already." CR>
			      <RTRUE>)>
		       <TELL
"You've uncovered what could only be the top of a pyramid. After clearing it
away with your hands, you notice a square opening in the top of it." CR>
		       <PUTP ,HERE ,P?CAPACITY 6>
		       <PUTP ,HERE ,P?LDESC
"You are in the desert, almost out of sight of the encampment to the west. At
last, though, you've found the ancient pyramid. The top of the pyramid is
clearly exposed and on one of its sides is a square opening.">
		       <FCLEAR ,ROCK-LOCK ,INVISIBLE>
		       <MOVE ,PYRAMID ,HERE>
		       <SETG SCORE <+ ,SCORE 25>>)
		      (T
		       <TELL <GET ,DIGGER-LTBL .COUNTER> CR>
		       <PUTP ,HERE ,P?CAPACITY .COUNTER>)>)>>

<GLOBAL DIGGER-LTBL
	<LTABLE 
"You've dug a small hole. As you stand there and watch it, the sand starts to
fill it in a little."
"You've enlarged the hole a little, taking out two shovelsful for every one
that collapses back in from the walls."
"You've made the hole quite sizable, though it's not very deep. The deeper you
dig, the more the walls collapse and so you widen the base of the hole."
"You're knee-deep in the hole, digging away, taking out more and more sand. You
silently curse those workers for having deserted you."
"You've dug yourself into a deep hole. You're actually several feet below the
surrounding sand. The walls look very unstable.">>

<ROUTINE V-DISEMBARK ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?OUT>)
	       (<AND <FSET? ,PRSO ,WORNBIT>
		     <NOT <FSET? ,PRSO ,VEHBIT>>>
		<V-TAKE-OFF>)
	       (<NOT <EQUAL? <LOC ,WINNER> ,PRSO>>
		<TELL "You're not in that!" CR>
		<RFATAL>)
	       (T
		<OWN-FEET>)>>

<ROUTINE V-DISENCHANT ()
	 <TELL "Nothing happens." CR>>

<ROUTINE PRE-DROP ()
	 <COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<TELL "Dropped." CR>)>>

<ROUTINE V-DRINK ()
	 <COND (<PRE-EAT>
		<RTRUE>)
	       (T <V-EAT>)>>

<ROUTINE PRE-EAT ()
	 <COND (<EQUAL? ,GAME-FLAG 2>
		<RFALSE>)>
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <FSET? ,PRSO ,FOODBIT>>
		<COND (<EQUAL? <ITAKE <>> T>
		       <TELL "(Taken)" CR>
		       <RFALSE>)
		      (T ;"won't this result in a null response
			   - or will ITAKE have responded"
		       <RTRUE>)>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <EQUAL? ,PRSO ,ME ,WINNER ,ADVENTURER>>
		     <FSET? ,PRSO ,FOODBIT>>
		<NOT-HOLDING ,PRSO>
		<RTRUE>)>>

<ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))
	 <COND (<AND <SET EAT? <FSET? ,PRSO ,FOODBIT>> <IN? ,PRSO ,WINNER>>
		<COND (<VERB? DRINK> <TELL "How can you drink that?">)
		      (ELSE
		       <TELL "That really hit the spot.">
		       <COND (<EQUAL? ,GAME-FLAG 3>
			      <REMOVE ,PRSO>
			      <SETG THIRST <+ ,THIRST 10>>
			      <DISABLE <INT I-GROWL>>
			      <TELL 
" It did make you a little thirstier, though.">
			      <CRLF>
			      <RTRUE>)>
		       <REMOVE-CAREFULLY ,PRSO>)>
		<CRLF>)
	       (<SET DRINK? <FSET? ,PRSO ,DRINKBIT>>
		<COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
			   <AND <SET NOBJ <LOC ,PRSO>>
				<IN? .NOBJ ,WINNER>
				<FSET? .NOBJ ,OPENBIT>>>
		       <COND (<EQUAL? ,GAME-FLAG 1>
			      <HIT-SPOT>
			      <RTRUE>)>
		       <TELL "You feel much refreshed.">
		       <COND (,SANDY-CANTEEN
			      <TELL 
" Some sand from the bottom of the canteen is gritty in your mouth, though.">)>
		       <CRLF>
		       <SETG WATER-LEFT <- ,WATER-LEFT 10>>
		       <COND (<L? ,WATER-LEFT 10>
			      <REMOVE ,PRSO>)>
		       <SETG THIRST 0>)
		      (<AND <EQUAL? ,HERE ,RIVER-BANK>
			    <PRSO? ,GLOBAL-WATER>
			    <EQUAL? ,GAME-FLAG 3>>
		       <TELL
"You kneel down and drink deeply from the Nile and feel refreshed." CR>
		       <SETG THIRST 0>)
		      (T <TELL 
"I'd like to oblige, but it's not within easy reach." CR>)>)
	       (<NOT <OR .EAT? .DRINK?>>
		<TELL "I don't think that the "
		      D
		      ,PRSO
		      " would agree with you." CR>)>>

<ROUTINE HIT-SPOT ()
	 <TELL
"Thank you very much. I was rather thirsty (from all this talking,
probably)." CR>
         <REMOVE-CAREFULLY ,PRSO>>

<ROUTINE V-ECHO ("AUX" LST MAX (ECH 0) CNT) 
	 #DECL ((LST) <PRIMTYPE VECTOR> (MAX CNT ECH) FIX)
	 <COND (<G? <GETB ,P-LEXV ,P-LEXWORDS> 0>
	                 <SET LST <REST 
				   ,P-LEXV
				   <* <GETB ,P-LEXV ,P-LEXWORDS> ,P-WORDLEN>>>
	                 <SET MAX <- <+ <GETB .LST 0> <GETB .LST 1>> 1>>
	                 <REPEAT ()
		            <COND (<G? <SET ECH <+ .ECH 1>> 2>
			           <TELL "..." CR>
				   <RETURN>)
			          (T
			           <SET CNT <- <GETB .LST 1> 1>>
			           <REPEAT ()
				      <COND (<G? <SET CNT <+ .CNT 1>> .MAX>
					     <RETURN>)
					    (T
					     <PRINTC <GETB ,P-INBUF .CNT>>)>>
			           <TELL " ">)>>)
			(T
			 <TELL "echo echo ..." CR>)>>

<ROUTINE REMOVE-CAREFULLY (OBJ "AUX" OLIT)
	 <COND (<EQUAL? .OBJ ,P-IT-OBJECT>
		<SETG P-IT-OBJECT <>>
		<SETG P-IT-LOC <>>)>
	 <SET OLIT ,LIT>
	 <REMOVE .OBJ>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND .OLIT <NOT <EQUAL? .OLIT ,LIT>>>
		<TELL "You are left in the dark..." CR>)>
	 T>

<ROUTINE V-ENTER ()
	<DO-WALK ,P?IN>>

<ROUTINE PRE-EXAMINE ()
	 <COND (<AND <NOT ,LIT>
		     <NOT <EQUAL? ,PRSO ,GRUE>>>
		<TELL "It's too dark to see!" CR>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<V-LOOK-INSIDE>)
	       (T
		<TELL "There's nothing special about the " D ,PRSO "." CR>)>>

<ROUTINE V-EXIT ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-EXORCISE ()
	 <TELL "What a bizarre concept!" CR>>

;<ROUTINE PRE-FILL ("AUX" T)
	 <COND (<AND <NOT ,PRSI> <SET T <GETPT ,HERE ,P?GLOBAL>>>
		<COND (<ZMEMQB ,GLOBAL-WATER .T <- <PTSIZE .T> 1>>
		       <SETG PRSI ,GLOBAL-WATER>
		       <RFALSE>)
		      (<EQUAL? ,GAME-FLAG 3>
		       <TELL "There is nothing to fill it with.">
		       <COND (<GETP ,HERE ,P?VTYPE>
			      <TELL " Except for some sand.">)>
		       <CRLF>
		       <RTRUE>)
		      (T
		       <TELL "There is nothing to fill it with." CR>
		       <RTRUE>)>)>
	 <COND (<NOT <EQUAL? ,PRSI ,GLOBAL-WATER>>
		<PERFORM ,V?PUT ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-FILL ()
	 <COND (<EQUAL? ,GAME-FLAG 3>
		<COND (<NOT ,PRSI>
		       <COND (<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
			      <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>)
			     (T
			      <TELL "There's nothing to fill it with.">
			      <COND (<GETP ,HERE ,P?VTYPE>
				     <TELL " Except for maybe some sand.">)>
			      <CRLF>)>)
		      (<EQUAL? ,PRSI ,GLOBAL-WATER>
		       <COND (<OR <EQUAL? ,WATER-LEFT 40>
				  <IN? ,C-SAND ,PRSO>>
			      <TELL "It's already full." CR>)
			     (<NOT <FSET? ,PRSO ,CONTBIT>>
			      <HOW? ,PRSO>
			      <RTRUE>)
			     (<NOT <FSET? ,PRSO ,OPENBIT>>
			      <TELL "Tough to do when the " D ,PRSO " is closed." CR>)
			     (<NOT <PRSO? ,CANTEEN>>
			      <TELL <PICK-ONE ,YUKS> CR>)
			     (T
			      <MOVE ,WATER ,PRSO>
			      <COND (<EQUAL? ,HERE ,RIVER-BANK>
				     <SETG WATER-LEFT 40>)
				    (T
				     <SETG WATER-LEFT 0>)>
			      <MOVE ,CANTEEN ,PLAYER>
			      <TELL "Okay, you have filled the " D ,PRSO "." CR>)>)
		      (<EQUAL? ,PRSI ,WATER>
		       <PERFORM ,V?POUR-IN ,WATER ,PRSO>
		       <THIS-IS-IT ,PRSO>
		       <RTRUE>)
		      (T <TELL "You may know how to do that, but I don't." CR>)>)
	       (T
		<COND (<NOT ,PRSI>
		       <COND (<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
			      <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>
			      <RTRUE>)
			     (<IN? ,WATER <LOC ,WINNER>>
			      <PERFORM ,V?FILL ,PRSO ,WATER>
			      <RTRUE>)
			     (T
			      <TELL "There's nothing to fill it with." CR>)>)
		      (T
		       <TELL
"You may know how to do that, but I don't." CR>)>)>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,HANDS ,LUNGS>
		<TELL
"Within six feet of your head, assuming you haven't left that
somewhere." CR>)
	       (<EQUAL? ,PRSO ,ME>
		<TELL "You're around here somewhere..." CR>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<TELL "You find it." CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "You have it." CR>)
	       (<IN? ,PRSO ,ENDLESS-DESERT>
		<TELL "With all this sand around here? Give me a break!" CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<TELL "It's right here." CR>)
	       (<FSET? .L ,ACTORBIT>
		<TELL "The " D .L " has it." CR>)
	       (<FSET? .L ,SURFACEBIT>
		<TELL "It's on the " D .L "." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL "It's in the " D .L "." CR>)
	       (T
		<TELL "Beats me." CR>)>>

<ROUTINE V-FLUSH ()
	 <TELL "Flush " A ,PRSO "?" CR>>

<ROUTINE V-FOLLOW ()
	 <TELL "You're nuts!" CR>>

<ROUTINE V-FROBOZZ ()
	 <TELL
"The FROBOZZ Corporation created, owns, and operates this dungeon." CR>>

<ROUTINE PRE-GIVE ()
	 <COND (<EQUAL? ,PRSI ,PRSO>
		<TELL "That's not a very useful idea." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSO ,BUTTERFLY>>
		<RFALSE>)		
	       (<AND <VERB? PUT>
		     <PRSI-IN-PRSO?>>
		<TELL
"But the " D ,PRSI " is in the " D ,PRSO "!" CR>)
	       (<AND <VERB? PUT-ON>
		     ,LADDER-EXTENDED>
		<PERFORM ,V?SPAN ,PRSO ,PRSI>
		<RTRUE>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TELL "You can't while you're wearing it." CR>)
	       (<NOT <HELD? ,PRSO>>
		<TELL 
"That's easy for you to say since you don't even have the " D ,PRSO "." CR>)>>

<ROUTINE PRSI-IN-PRSO? ("AUX" OBJ)
	 <SET OBJ <LOC ,PRSI>>
	 <REPEAT ()
		 <COND (<NOT .OBJ> <RFALSE>)
		       (<EQUAL? .OBJ ,PRSO> <RTRUE>)
		       (T <SET OBJ <LOC .OBJ>>)>>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "You can't give " A ,PRSO " to " A ,PRSI "!" CR>)
	       (T
		<TELL "The " D ,PRSI " refuses it politely." CR>)>>

<ROUTINE V-HATCH ()
	 <TELL "Bizarre!" CR>>

<GLOBAL HS 0> ;"counts occurences of HELLO, SAILOR"

<ROUTINE V-HELLO ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL
"The " D ,PRSO " bows his head to you in greeting." CR>)
		      (T
		       <TELL
"It's a well known fact that only schizophrenics say \"Hello\" to a "
D ,PRSO "." CR>)>)
	       (T
		<TELL <PICK-ONE ,HELLOS> CR>)>>

<ROUTINE V-INFLATE ()
	 <TELL "How can you inflate that?" CR>>

<ROUTINE V-IS-IN ()
	 <COND (<IN? ,PRSO ,PRSI>
		<TELL "Yes, it is ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL " the " D ,PRSI "." CR>)
	       (T
		<TELL "No, it isn't." CR>)>>

<ROUTINE V-KICK () <HACK-HACK "Kicking the ">>

<ROUTINE V-KISS ()
	 <COND (<EQUAL? ,GAME-FLAG 2>
		<TELL "I'd sooner kiss a pile of Antarian swamp mold." CR>)
	       (T
		<TELL "I'd sooner kiss a pig." CR>)>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Nobody's home." CR>)
	       (T
		<TELL "Why knock on " A ,PRSO "?" CR>)>>

<ROUTINE LIGHT-THE (OBJECT SUPPRESS?)
	 <FSET .OBJECT ,ONBIT>
	 <FSET .OBJECT ,FLAMEBIT>
	 <COND (<EQUAL? .OBJECT ,ONE-MATCH>
		<COND (<FSET? ,MATCHES ,OPENBIT>
		       <COND (<PROB 10>
			      <TELL
"Ooops! You didn't remember to close the cover before striking! The matchbook
bursts into flames, burning your fingertips." CR>
			      <MOVE ,BURNED-MATCHBOOK <LOC ,MATCHES>>
			      <FSET ,BURNED-MATCHBOOK ,OPENBIT>
			      <REMOVE ,MATCHES>
			      <REMOVE ,MANUAL>
			      <REMOVE ,ONE-MATCH>
			      <SETG MATCH-COUNT 0>
			      <SET SUPPRESS? T>)>)>)>
	 <COND (<NOT .SUPPRESS?>
		<TELL "The " D .OBJECT " is now lit." CR>)>
	 <COND (<NOT ,LIT>
		<SETG LIT <LIT? ,HERE>>
		<CRLF>
		<V-LOOK>)>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<NOT <EQUAL? ,GAME-FLAG 3>>
		<COND (<FSET? ,PRSO ,LIGHTBIT>
		       <COND (<NOT <FSET? ,PRSO ,ONBIT>>
			      <TELL "It is already off." CR>)
			     (T
			      <FCLEAR ,PRSO ,ONBIT>
			      <COND (,LIT
				     <SETG LIT <LIT? ,HERE>>)>
			      <TELL "The " D ,PRSO " is now off." CR>
			      <COND (<NOT ,LIT>
				     <TELL "It is now pitch black." CR>)>)>)
		      (T
		       <TELL "You can't turn that off." CR>)>
		<RTRUE>)
	       (T
		<COND (<FSET? ,PRSO ,BURNBIT>
		       <COND (<NOT <FLAMING? ,PRSO>>
			      <TELL "It is already out." CR>)
			     (<EQUAL? ,PRSO ,MATCHES ,ONE-MATCH>
			      <DISABLE <INT I-MATCH-OUT>>
			      <I-MATCH-OUT T>
			      <RTRUE>)
			     (ELSE
			      <TELL "The " D ,PRSO " is now out." CR>)>)
		      (ELSE <TELL "You can't extinguish that." CR>)>)>>

<ROUTINE V-LAMP-ON ()
	 <COND (<NOT <EQUAL? ,GAME-FLAG 3>>
		<COND (<FSET? ,PRSO ,LIGHTBIT>
		       <COND (<FSET? ,PRSO ,ONBIT>
			      <TELL "It is already on." CR>)
			     (T
			      <FSET ,PRSO ,ONBIT>
			      <TELL "The " D ,PRSO " is now on." CR>
			      <COND (<NOT ,LIT>
				     <SETG LIT <LIT? ,HERE>>
				     <CRLF>
				     <V-LOOK>)>)>)
		      (T
		       <TELL "You can't turn that on." CR>)>
		<RTRUE>)
	       (T
		<COND (<FSET? ,PRSO ,BURNBIT>
		       <COND (<FLAMING? ,PRSO>
			      <COND (<EQUAL? ,PRSO ,ONE-MATCH>
				     <TELL "One">)
				    (T <TELL "It">)>
			      <TELL " is already lit." CR>)
			     (<AND
			       <OR <EQUAL? ,PRSO ,MANY-MATCHES ,SINGLE-MATCH 
					   ,EMPTY-MATCHES>
				   <EQUAL? ,PRSO ,ONE-MATCH>>
			       <AND <NOT <IN? ,ONE-MATCH ,WINNER>>
				    <NOT <IN? ,MATCHES ,WINNER>>>>
			      <TELL "I see no match here." CR>
			      <RTRUE>)
			     (<OR <EQUAL? ,PRSO ,MANY-MATCHES ,SINGLE-MATCH 
					  ,EMPTY-MATCHES>
				  <EQUAL? ,PRSO ,ONE-MATCH>>
			      <COND (<L? ,MATCH-COUNT 1>
				     <TELL
"That's a little tough to do with an empty book of matches." CR>
				     <RTRUE>)
				    (T
				     <COND (<NOT <IN? ,ONE-MATCH ,WINNER>>
					    <MATCH-MOVER>)>
				     <TELL "You have now lit a match." CR>
				     <LIGHT-THE ,ONE-MATCH T>
				     <COND (<LOC ,MATCHES> ;"book didn't burn"
					    <ENABLE <QUEUE I-MATCH-OUT 3>>)>)>)
			     (ELSE
			      <HOW? ,PRSO>)>)
		      (T
		       <TELL "You can't light that." CR>)>)>>

<ROUTINE V-LAUNCH ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<TELL "You can't launch that by saying \"launch\"!" CR>)
	       (T
		<TELL "That's pretty weird." CR>)>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Getting tired?" CR>>

<ROUTINE V-LEAP ("AUX" T S)
	 <COND (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <COND (<FSET? ,PRSO ,ACTORBIT>
			      <TELL
"The " D ,PRSO " is too big to jump over." CR>)
			     (T
			      <V-SKIP>)>)
		      (T
		       <TELL "That would be a good trick." CR>)>)
	       (<SET T <GETPT ,HERE ,P?DOWN>>
		<SET S <PTSIZE .T>>
		<COND (<OR <EQUAL? .S 2> ;NEXIT
       			   <AND <EQUAL? .S 4> ;CEXIT
				<NOT <VALUE <GETB .T 1>>>>>
		       <TELL
"This was not a very safe place to try jumping." CR>
		       <JIGS-UP <PICK-ONE ,JUMPLOSS>>)
		      (<EQUAL? ,HERE ,UP-A-TREE>
		       <TELL
"In a feat of unaccustomed daring, you manage to land on your feet without
killing yourself." CR CR>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (T
		       <V-SKIP>)>)
	       (T
		<V-SKIP>)>>

<GLOBAL JUMPLOSS
	<LTABLE 0
	       "You should have looked before you leaped."
	       "In the movies, your life would be passing before your eyes."
	       "Geronimo...">>

<ROUTINE V-LEAVE () 
	 <DO-WALK ,P?OUT>>

<ROUTINE V-LISTEN ()
	 <TELL "The " D ,PRSO " makes no sound." CR>>

<ROUTINE V-LOCK ()
	 <TELL "It doesn't seem to work." CR>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL "There is nothing behind the " D ,PRSO "." CR>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"The " D ,PRSO " is open, but I can't tell what's beyond it.">)
		      (T
		       <TELL "The " D ,PRSO " is closed.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "There is nothing special to be seen." CR>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO>
				   <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     (T
			      <TELL "The " D ,PRSO " is ">
			      <COND (<FIRST? ,PRSO>
				     <TELL "otherwise ">)>
			      <TELL "empty." CR>)>)
		      (T
		       <TELL "The " D ,PRSO " is closed." CR>)>)
	       (T
		<TELL "You can't look inside " A ,PRSO "." CR>)>>

<ROUTINE PRE-LOOK-ON ()
	 <COND (<EQUAL? ,GAME-FLAG 2>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOOK-ON ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Look on " A ,PRSO "???" CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <TELL "There is nothing but dust there." CR>>

<ROUTINE V-LOWER () <HACK-HACK "Playing in this way with the ">>

<ROUTINE V-MAKE ()
    	<TELL "You can't do that." CR>>

<ROUTINE V-MELT ()
	 <TELL "It's not clear that " A ,PRSO " can be melted." CR>>

<ROUTINE PRE-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "You aren't an accomplished enough juggler." CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving the " D ,PRSO " reveals nothing." CR>)
	       (T
		<TELL "You can't move the " D ,PRSO "." CR>)>>

<ROUTINE V-MUMBLE ()
	 <TELL "You'll have to speak up if you expect me to hear you!" CR>>

<ROUTINE PRE-MUNG ()
	 <COND (<PRSO? ,LOCK ,CRATE ,BLACK-BOX>
	        <RFALSE>)
	       (<OR <NOT ,PRSI>
		    <NOT <FSET? ,PRSI ,WEAPONBIT>>>
		<TELL "Trying to destroy the " D ,PRSO " with ">
		<COND (<NOT ,PRSI>
		       <TELL "your bare hands">)
		      (T
		       <TELL A ,PRSI>)>
		<TELL " is futile." CR>)>>

<ROUTINE V-MUNG ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?ATTACK ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Nice try." CR>)>>

<ROUTINE V-ODYSSEUS ()
	 <TELL "Wasn't he a sailor?" CR>>

;<ROUTINE V-OIL ()
	 <TELL "You probably put spinach in your gas tank, too." CR>>

<ROUTINE V-OIL ()
	 <COND (<NOT ,PRSI>
		<COND (<IN? ,OIL-CAN ,ADVENTURER>
		       <PERFORM ,V?OIL ,PRSO ,OIL-CAN>
		       <RTRUE>)
		      (T
		       <TELL "Oil the " D ,PRSO " with what?" CR>)>)
	       (<EQUAL? ,PRSI ,OIL-CAN>
		<COND (<AND <EQUAL? ,PRSO ,FLOYD>
			    <FSET? ,FLOYD ,RLANDBIT>>
		       <TELL
"Floyd thanks you for your thoughtfulness." CR>)
		      (T
		       <TELL
"The " D, PRSO " doesn't need oiling." CR>)>)
	       (T
		<TELL "You can't use " A ,PRSI " as an oil can!" CR>)>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It is already open." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>> <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <NOT <FSET? .F ,TOUCHBIT>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "The " D ,PRSO " opens." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening the " D ,PRSO " reveals ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It is already open." CR>)
		      (T
		       <TELL "The " D ,PRSO " opens." CR>
		       <FSET ,PRSO ,OPENBIT>)>)
	       (T
		<TELL
"You must tell me how to do that to " A ,PRSO "." CR>)>>

<ROUTINE V-OVERBOARD ("AUX" LOCN)
	 <COND (<EQUAL? ,PRSI ,TEETH>
		<COND (<FSET? <SET LOCN <LOC ,WINNER>> ,VEHBIT>
		       <MOVE ,PRSO <LOC .LOCN>>
		       <TELL "Ahoy -- " D ,PRSO " overboard!" CR>)
		      (T
		       <TELL "You're not in anything!" CR>)>)
	       (T
		<TELL "Huh?" CR>)>>

<ROUTINE V-PICK () <TELL "You can't pick that." CR>>

<ROUTINE V-PLAY ()
    <TELL "That's silly!" CR>>

<ROUTINE V-PLAY-WITH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?PLAY ,GLOBAL-GAMES>
		<RTRUE>)
	       (T
		<TELL "I sometimes wonder about your mental health." CR>)>>

<ROUTINE V-PLUG ()
	 <TELL "This has no effect." CR>>

<ROUTINE V-POUR ()
	 <COND (<EQUAL? ,GAME-FLAG 2>
		<TELL
"Pouring or spilling non-liquids is specifically forbidden by
section 17.9.2 of the Galactic Adventure Game Compendium of Rules." CR>)
	       (<EQUAL? ,GAME-FLAG 3>
		<COND (<NOT <EQUAL? ,PRSO ,WATER ,C-SAND>>
		       <TELL "You can't pour that." CR>
		       <RTRUE>)
		      (T
		       <TELL "Poured." CR>
		       <COND (<EQUAL? ,PRSO ,C-SAND>
			      <SETG SAND-FILLED <>>
			      <REMOVE ,C-SAND>)
			     (T
			      <REMOVE ,WATER>
			      <SETG WATER-LEFT 0>)>)>)
	       (T
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

;<ROUTINE PRE-POUR-ON ("AUX" LIQ) ;"not referenced, removed 2/27/85 by SEM"
	 <COND (<OR <NOT <EQUAL? ,GAME-FLAG 3>>
		    <EQUAL? ,PRSO ,NOT-HERE-OBJECT>>
		<RFALSE>)
	       (<EQUAL? ,PRSO ,WATER ,C-SAND>
		<SET LIQ ,PRSO>
		<COND (<NOT <FSET? <LOC .LIQ> ,OPENBIT>>
		       <TELL "You'd better open the " D <LOC .LIQ> " first."
			     CR>
		       <RTRUE>)
		      (<FLAMING? ,PRSI>
		       <TELL "Poured." CR>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <COND (<NOT <SETG LIT <LIT? ,HERE>>>
			      <TELL " It is now pitch black.">)>
		       <COND (<EQUAL? .LIQ ,WATER>
			      <SETG WATER-LEFT <- ,WATER-LEFT 10>>
			      <COND (<L? ,WATER-LEFT 10>
				     <REMOVE ,WATER>)>)
			     (T
			      <SETG SAND-FILLED <>>
			      <REMOVE ,C-SAND>)>
		       <FCLEAR ,PRSI ,FLAMEBIT>
		       <FCLEAR ,PRSI ,ONBIT>
		       <RTRUE>)
		      (T
		       <TELL "Poured." CR>
		       <COND (<EQUAL? .LIQ ,WATER>
			      <SETG WATER-LEFT <- ,WATER-LEFT 10>>
			      <COND (<L? ,WATER-LEFT 10>
				     <REMOVE ,WATER>)>
			      <TELL "The " D ,PRSI
				     " gets wet, but quickly dries." CR>)
			     (T
			      <COND (<GETP ,HERE ,P?VTYPE>
				     <TELL "The sand is gone with the wind." CR>)
				    (T <TELL 
"The sand falls through the cracks in the stone floor." CR>)>
			      <SETG SAND-FILLED <>>)>
		       <RTRUE>)>)>>

<ROUTINE V-POUR-ON ()
	 <COND (<EQUAL? ,PRSO ,WATER>
		<REMOVE ,PRSO>
		<SETG WATER-LEFT 0>
	        <COND (<FLAMING? ,PRSI>
		       <TELL "The " D ,PRSI " is extinguished." CR>
		       <FCLEAR ,PRSI ,ONBIT>
		       <FCLEAR ,PRSI ,FLAMEBIT>)
	              (T
		       <TELL
"The water spills over the " D ,PRSI " and evaporates." CR>)>
		<RTRUE>)
	       (T
		<TELL "You can't pour that." CR>)>>

<ROUTINE V-POUR-IN ("AUX" L)
	 <COND (<NOT <EQUAL? ,GAME-FLAG 3>>
		<PERFORM ,V?DROP ,PRSO ,PRSI>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSO ,WATER ,C-SAND>>
		<TELL "You can't pour that into anything." CR><RTRUE>)
	       (<NOT <FSET? ,PRSI ,CONTBIT>>
		<TELL "You'd have a lot of trouble pouring the " D ,PRSO
		      " into the " D ,PRSI "." CR>
		<RTRUE>)
	       (T
		<TELL "Why bother?" CR>)>>

<ROUTINE V-PRAY ()
	 <TELL
"If you pray enough, your prayers may be answered." CR>>

<ROUTINE V-PUMP ()
	 <TELL "It's really not clear how." CR>>

<ROUTINE V-PUSH () <HACK-HACK "Pushing the ">>

<ROUTINE V-PUSH-TO ()
	 <TELL "You can't push things to that." CR>>

<ROUTINE V-PUSH-UP () <HACK-HACK "Pushing up the ">>

<ROUTINE V-PUSH-DOWN () <HACK-HACK "Pushing down the ">>

<ROUTINE PRE-PUT ()
	 <PRE-GIVE>> ;"That's easy for you to say..."

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL "You can't do that." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "The " D ,PRSI " isn't open." CR>
		<THIS-IS-IT ,PRSI>)
	       (<EQUAL? ,PRSI ,PRSO>
		<TELL "How can you do that?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "The " D ,PRSO " is already in the " D ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <FSET? ,PRSO ,TRYTAKEBIT>>
		<TELL "You don't have the " D ,PRSO "." CR>
		<RTRUE>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <EQUAL? <ITAKE> <> ,M-FATAL>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<SCORE-OBJ ,PRSO>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSI ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>
	        <TELL "You can't do that." CR>)
	       (T
		<TELL "There's no good surface on the " D ,PRSI "." CR>)>>

<ROUTINE V-PUT-UNDER ()
	 <TELL "You can't do that." CR>>

<ROUTINE V-RAISE ()
	 <V-LOWER>>

<ROUTINE V-RAPE ()
	 <TELL "What a (ahem!) strange idea." CR>>

<ROUTINE V-REACH ()
	 <COND (<FIRST? ,PRSO>
		<TELL "There is something">)
	       (T
		<TELL "There is nothing">)>
	 <TELL " inside the " D ,PRSO "." CR>>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT>
		<TELL "It is impossible to read in the dark." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "How does one look through " A ,PRSI "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
		<TELL "How does one read " A ,PRSO "?" CR>)
	       (T
		<TELL <GETP ,PRSO ,P?TEXT> CR>)>>

<ROUTINE V-READ-PAGE ()
	 <PERFORM ,V?READ ,PRSO>
	 <RTRUE>>

<ROUTINE V-REPENT ()
	 <TELL "It could very well be too late!" CR>>

<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that the " D ,PRSO " is interested." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-RING ()
	 <TELL "How, exactly, can you ring that?" CR>>

<ROUTINE V-RUB () <HACK-HACK "Fiddling with the ">>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<NOT <EQUAL? ,GAME-FLAG 2>>
		<PROG () 
	              <COND (<NOT ,P-CONT>
		             <TELL "Say what?" CR>
		             <RTRUE>)
		            (T
		             <SETG QUOTE-FLAG <>>
		             <RTRUE>)>>)>
	 <COND (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "You must address the " D .V " directly." CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>)
	       (<EQUAL? <GET ,P-LEXV ,P-CONT> ,W?HELLO>
		<SETG QUOTE-FLAG <>>
		<RTRUE>)
	       (T
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)>>

<ROUTINE V-SCOLD ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"For some reason, the " D, PRSO " doesn't seem too chagrined." CR>)>>

<ROUTINE V-SEARCH ()
	 <TELL "You find nothing unusual." CR>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Why would you send for the " D ,PRSO "?" CR>)
	       (T
		<TELL "That doesn't make sends." CR>)>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SGIVE ()
	 <TELL "Foo!" CR>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "This seems to have no effect." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "You can't take it; thus, you can't shake it!" CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<AND <EQUAL? ,PRSO ,FOOD-KIT>
				   <OR <IN? ,RED-GOO ,FOOD-KIT>
				       <IN? ,GREEN-GOO ,FOOD-KIT>
				       <IN? ,BROWN-GOO ,FOOD-KIT>>>
			      <REMOVE ,RED-GOO>
			      <REMOVE ,GREEN-GOO>
			      <REMOVE ,BROWN-GOO>
			      <TELL
"Colored goo flies all over everything. Yechh!" CR>)
			     (<FIRST? ,PRSO>
			      <SHAKE-LOOP>
			      <TELL "The contents of the " D, PRSO " spills ">
	                      <COND (<NOT <FSET? ,HERE ,RLANDBIT>>
		                     <TELL "out and disappears">)
	                            (T
		                     <TELL "to the ground">)>
	                      <TELL "." CR>)
			     (T
			      <TELL "Shaken." CR>)>)
		      (T
		       <COND (<FIRST? ,PRSO>
			      <TELL
"It sounds like there is something inside the " D ,PRSO "." CR>)
			     (T
			      <TELL "The " D, PRSO " sounds empty." CR>)>)>)
	       (T
		<TELL "Shaken." CR>)>>

<ROUTINE SHAKE-LOOP ("AUX" X)
	 <REPEAT ()
		 <COND (<SET X <FIRST? ,PRSO>>
			<FSET .X ,TOUCHBIT>
			<MOVE .X
			      <COND (<EQUAL? ,HERE ,UP-A-TREE>
				              ,PATH)
				             (<NOT <FSET? ,HERE ,RLANDBIT>>
				              ,PSEUDO-OBJECT)
				             (T
				              ,HERE)>>)
		       (T
			<RETURN>)>>>

<ROUTINE V-SHOW ()
	 <COND (<NOT <HELD? ,PRSO>>
		<NOT-HOLDING ,PRSO>)
	       (<EQUAL? ,PRSI ,ME>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,ACTORBIT>
		<TELL
"The " D ,PRSI " looks at the " D ,PRSO "." CR>)
	       (T
		<TELL
"Why would you want to show something to " A ,PRSO "?" CR>)>>

<ROUTINE V-SIT ()
	 <COND (<EQUAL? ,GAME-FLAG 3>
		<TELL "No lying around on the job." CR>)
	       (T
		<SETG C-ELAPSED 31>
		<TELL
"You recline on the floor for a bit, and then stand up again." CR>)>>

<ROUTINE V-SIT-DOWN ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<PERFORM ,V?SIT>
		<RTRUE>)
	       (T
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SKIP ()
	 <TELL <PICK-ONE ,WHEEEEE> CR>>

<GLOBAL WHEEEEE
	<LTABLE 0 "Very good. Now you can go to the second grade."
	       "Are you enjoying yourself?"
	       "Wheeeeeeeeee!!!!!"
	       "Do you expect me to applaud?">>

<ROUTINE V-SMELL ()
	 <TELL "It smells like " A ,PRSO "." CR>>

<ROUTINE V-SPAN ()
	 <TELL "You can't." CR>>

<ROUTINE V-SPIN ()
	 <TELL "You can't spin that!" CR>>

<ROUTINE V-SPRAY ()
	 <V-SQUEEZE>>

<ROUTINE V-SQUEEZE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "The " D ,PRSO " does not understand this.">)
	       (T
		<TELL "How singularly useless.">)>
	 <CRLF>>

<ROUTINE V-SSPRAY ()
	 <PERFORM ,V?SPRAY ,PRSI ,PRSO>>

<ROUTINE V-STAB ("AUX" W)
	 <COND (<SET W <FIND-WEAPON ,WINNER>>
		<PERFORM ,V?ATTACK ,PRSO .W>
		<RTRUE>)
	       (T
		<TELL
"No doubt you propose to stab the " D ,PRSO " with your pinky?" CR>)>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (T
		<TELL "You are already standing, I think." CR>)>>

<ROUTINE V-STAY ()
	 <TELL "You will be lost without me!" CR>>

<ROUTINE V-STRIKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL
"Since you aren't versed in hand-to-hand combat, you'd better attack the "
D ,PRSO " with a weapon." CR>)
	       (T
		<PERFORM ,V?LAMP-ON ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SWIM ()
	 <COND (<EQUAL? ,HERE ,RIVER-BANK>
		<JIGS-UP .CROC-STR>
		<RFATAL>)
	       (<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
		<TELL "Swimming isn't usually allowed in the ">
		<COND (,PRSO
		       <TELL D ,PRSO ".">)
		      (T
		       <TELL "dungeon.">)>
		<CRLF>)
	       (T
		<TELL "Go jump in a lake!" CR>)>>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Whoosh!" CR>)
	       (T
		<PERFORM ,V?ATTACK ,PRSI ,PRSO>)>>

<ROUTINE PRE-TAKE ()
	 <COND (<EQUAL? ,GAME-FLAG 3>
		<COND (<PRSO? ,NOT-HERE-OBJECT>
		       <RFALSE>)>
		<COND (<IN? ,PRSO ,WINNER>
		       <COND (<FSET? ,PRSO ,WEARBIT>
			      <COND (<EQUAL? ,PRSO ,KNAPSACK>
				     <RFALSE>)
				    (T
				     <TELL "You are already wearing it." CR>)>)
			     (<EQUAL? ,PRSO ,ONE-MATCH>
			      <TELL "You already have one. One at a time, now!" CR>)
			     (T <TELL "You already have it." CR>)>)
		      (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
			    <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		       <TELL "You can't reach that." CR>
		       <RTRUE>)
		      (,PRSI
		       <COND (<NOT <==? ,PRSI <LOC ,PRSO>>>
			      <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
					  <FSET? ,PRSI ,CONTBIT>
					  <NOT <FSET? ,PRSI ,OPENBIT>>>
				     <TELL "You'd better open the " D ,PRSI 
					   " first." CR>
				     <THIS-IS-IT ,PRSI>
				     <RTRUE>)
				    (<EQUAL? ,PRSO ,LOCK>
				     <RFALSE>)
				    (<AND <EQUAL? ,PRSO ,SHOVEL>
					  <EQUAL? ,PRSI ,SAND>>
				     <SETG PRSI <>>
				     <RFALSE>)
				    (ELSE
				     <TELL "The " D ,PRSO
					   " isn't in the " D ,PRSI "." CR>)>)
			     (T
			      <SETG PRSI <>>
			      <RFALSE>)>)
		      (<==? ,PRSO <LOC ,WINNER>> <TELL "You are in it, loser!" CR>)>)
	       (<EQUAL? ,GAME-FLAG 1>
		<COND (<IN? ,PRSO ,WINNER>
		       <COND (<FSET? ,PRSO ,WEARBIT>
			      <TELL "You are already wearing it." CR>)
			     (T
			      <TELL "You already have that!" CR>)>)
		      (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
			    <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		       <TELL
			"You can't reach something that's inside a closed container." CR>
		       <RTRUE>)
		      (,PRSI
		       <COND (<EQUAL? ,PRSI ,GROUND>
			      <SETG PRSI <>>
			      <RFALSE>)
			     (<NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
			      <TELL
			       "The " D ,PRSO " isn't in the " D ,PRSI "." CR>)
			     (T
			      <SETG PRSI <>>
			      <RFALSE>)>)
		      (<EQUAL? ,PRSO <LOC ,WINNER>>
		       <TELL "You're inside of it!" CR>)>)
	       (T
		<COND (<IN? ,PRSO ,ADVENTURER>
		       <TELL "You already have it." CR>)
		      (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
			    <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		       <TELL "You can't reach into a closed container." CR>
		       <RTRUE>)
		      (,PRSI
		       <COND (<NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
			      <TELL "It's not in that!" CR>)
			     (T
			      <SETG PRSI <>>
			      <RFALSE>)>)
		      (<==? ,PRSO <LOC ,WINNER>>
		       <TELL "You are in it, asteroid-brain!" CR>)>)>>

<ROUTINE V-TAKE ("AUX" V)
	 <COND (<SET V <ITAKE>>
		<COND (<EQUAL? .V ,M-FATAL>
		       <RTRUE>)
		      (<AND <FSET? ,PRSO ,WEARBIT>
			    <NOT <EQUAL? ,GAME-FLAG 2>>>
		       <TELL "You are now wearing the " D ,PRSO "." CR>)
		      (T
		       <TELL "Taken." CR>)>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <TELL
"The " D ,PRSO " pauses for a moment, perhaps thinking that you should re-read
the instructions." CR>)>)
	       (<NOT <EQUAL? ,GAME-FLAG 2>>
		<TELL "You can't talk to the " D ,PRSO "!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)
	       (T
		<TELL
"Talking to " A ,PRSO "? Dr. Quarnsboggle, the Feinstein's
psychiatrist, would have been fascinated to hear that." CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE V-THROUGH ("OPTIONAL" (OBJ <>) "AUX" M)
	#DECL ((OBJ) <OR OBJECT FALSE> (M) <PRIMTYPE VECTOR>)
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<AND <NOT .OBJ> <FSET? ,PRSO ,VEHBIT>>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<EQUAL? ,PRSO ,GLOBAL-WATER>
	       <PERFORM ,V?SWIM>
	       <RTRUE>)
	      (<AND <NOT .OBJ> <NOT <FSET? ,PRSO ,TAKEBIT>>>
	       <TELL
"You hit your head against the " D ,PRSO " as you attempt this feat." CR>)
	      (.OBJ
	       <TELL "You can't do that!" CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "That would involve quite a contortion!" CR>)
	      (T
	       <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<COND (<EQUAL? ,PRSI ,ME>
		       <TELL
"A terrific throw! The " D ,PRSO>
		       <JIGS-UP " hits you squarely in the head. Normally,
this wouldn't do much damage, but by incredible mischance, you fall over
backwards trying to duck, and break your neck, justice being swift and
merciful in this genre.">)
		      (<FSET? ,PRSI ,ACTORBIT>
		       <TELL
"The " D ,PRSI " has the presence of mind to duck as the " D ,PRSO " flies by
and crashes to the ground." CR>)
		      (T
		       <TELL
"The thrown " D ,PRSO " falls harmlessly to the ground." CR>)>)>>

<ROUTINE V-THROW-OFF ()
	 <TELL "You can't throw anything off of that!" CR>>

<ROUTINE V-TIE ()
	 <COND (<EQUAL? ,PRSI ,WINNER>
		<TELL "You can't tie anything to yourself." CR>)
	       (T
		<TELL "You can't tie the " D ,PRSO " to that." CR>)>>

<ROUTINE V-TIE-UP ()
	 <TELL "You could certainly never tie it with that!" CR>>

<ROUTINE V-TREASURE ()
	 <TELL "Nothing happens." CR>>

<ROUTINE PRE-TURN ()
	 <COND (<NOT <FSET? ,PRSO ,TURNBIT>>
		<TELL "You can't turn that!" CR>)>>

<ROUTINE V-TURN ()
	 <TELL "This has no effect." CR>>

<ROUTINE V-UNLOCK ()
	 <V-LOCK>>

<ROUTINE V-UNTIE ()
	 <TELL "This cannot be tied, so it cannot be untied!" CR>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <SETG C-ELAPSED 40>
	 <TELL "Time passes..." CR>
	 <COND (<NOT <EQUAL? ,GAME-FLAG 2>>
		<REPEAT ()
			<COND (<L? <SET NUM <- .NUM 1>> 0>
			       <RETURN>)
			      (<CLOCKER>
			       <RETURN>)>>
		<SETG CLOCK-WAIT T>)>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL ,CANT-GO CR>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "The " D .OBJ " is closed." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (<NOT ,LIT>
		<COND (,TUTORIAL-MODE
		       <TELL
"You don't want to walk around in the dark like that, since you might be set
upon by lurking grues." CR>)
		      (<PROB 80>
		       <JIGS-UP
"Oh, no! You have walked into the slavering fangs of a lurking grue!">)
		      (T <TELL ,CANT-GO CR>)>
		<RFATAL>)
	       (T
		<TELL ,CANT-GO CR>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Use compass directions for movement." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<COND (<PRSO? ,TENT-OBJ>
		       <TELL "There are a few of them around">)
		      (<PRSO? ,NASTY-CROC>
		       <TELL "They're">)
		      (T
		       <TELL "It's">)>
		<TELL " here!" CR>)
	       (T
		<TELL "You should supply a direction!" CR>)>>

<ROUTINE V-WAVE ()
	 <HACK-HACK "Waving the ">>

<ROUTINE V-WEAR ()
	 <COND (<EQUAL? ,GAME-FLAG 1 3>
		<COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		       <TELL "You can't wear the " D ,PRSO "." CR>)
		      (T
		       <PERFORM ,V?TAKE ,PRSO>
		       <RTRUE>)>)
	       (<NOT <HELD? ,PRSO>>
		<NOT-HOLDING ,PRSO>)
	       (<FSET? ,PRSO ,WEARBIT> 
		<TELL "You are wearing the " D ,PRSO "." CR>		
		<SETG C-ELAPSED 18>
		<MOVE ,PRSO ,PLAYER>
		<FSET ,PRSO ,WORNBIT>)
	       (T
		<TELL
"They're out of fashion, and besides, it wouldn't fit." CR>)>>

<ROUTINE V-WIN ()
	 <TELL "Naturally!" CR>>

<ROUTINE V-WIND ()
	 <TELL "You cannot wind up " A ,PRSO "." CR>>

<ROUTINE V-WISH ()
	 <TELL "With luck, your wish will come true." CR>>

<ROUTINE V-YELL ()
	 <TELL "Aaaarrrrgggghhhh!" CR>>

<ROUTINE PRE-SZAP ()
	 <PERFORM ,V?ZAP ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE PRE-ZAP ()
	 <COND (,PRSI
		<RFALSE>)
	       (<EQUAL? ,PRSO ,LASER>
		<RFALSE>)
	       (<IN? ,LASER ,ADVENTURER>
		<PERFORM ,V?ZAP ,LASER ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You have nothing to shoot it with." CR>)>>

<ROUTINE V-ZAP ()
	 <COND (<NOT <HELD? ,PRSO>>
		<NOT-HOLDING ,PRSO>)
	       (<NOT <EQUAL? ,PRSO ,LASER>>
		<TELL "You can't shoot that." CR>)
	       (<NOT ,PRSI>
		<TELL "At what?">)
	       (T
		<TELL "Nothing happens." CR>)>>

<ROUTINE V-SZAP ()
	 <TELL "Zap!" CR>>

<ROUTINE V-ZORK ()
	 <COND (<==? ,GAME-FLAG 1> <TELL "At your service!" CR>)
	       (T <TELL "A fine game, but it's not this one!" CR>)>>

^L

"Verb-Associated Routines"

"Descriptions"

<GLOBAL LIT <>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF>
		       <DESCRIBE-OBJECTS>)>)>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL
"It is pitch black. You are likely to be eaten by a grue.">
		<CRLF>
		<RETURN <>>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<IN? ,HERE ,ROOMS>
		;"Was <TELL D ,HERE CR>"
		<TELL D ,HERE>
		<COND (<FSET? <SET AV <LOC ,WINNER>> ,VEHBIT>
		       <TELL ", in the " D .AV>)>
		<CRLF>)>
	 <COND (<OR .LOOK? <NOT ,SUPER-BRIEF>>
		<SET AV <LOC ,WINNER>>
		;<COND (<FSET? .AV ,VEHBIT>
		       <TELL "(You are in the " D .AV ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T
		       <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <EQUAL? ,HERE .AV>> <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (T
		<TELL "Only bats can see in the dark. And you're not one." CR>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<GLOBAL DESC-OBJECT <>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<EQUAL? .OBJ ,SPOUT-PLACED>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<TELL "There is " A .OBJ " here">
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (providing light)">)>
		<TELL ".">)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL "A">
		<COND (<FSET? .OBJ ,VOWELBIT>
		       <TELL "n">)>
		<TELL " " D .OBJ>
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (providing light)">)
		      (<AND <FSET? .OBJ ,WEARBIT>
			    <NOT <EQUAL? ,GAME-FLAG 2>>>
		       <TELL " (being worn)">)
		      (<AND <FSET? .OBJ ,WORNBIT>
			    <EQUAL? ,GAME-FLAG 2>>
		       <TELL " (being worn)">)>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside the " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (ELSE
			       <TELL ", ">
			       <COND (<NOT .N> <TELL "and ">)>)>
			<TELL A .F>
			<COND (<AND <NOT .IT?> <NOT .TWO?>>
			       <SET IT? .F>)
			      (ELSE
			       <SET TWO? T>
			       <SET IT? <>>)>
			<SET F .N>
			<COND (<NOT .F>
			       <COND (<AND .IT? <NOT .TWO?>>
				      <THIS-IS-IT .IT?>)>
			       <RTRUE>)>>)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? AV STR (PV? <>) (INV? <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>> <RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
		T)
	       (ELSE <SET AV <>>)>
	 <SET 1ST? T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (ELSE
		<REPEAT ()
			<COND (<NOT .Y> <RETURN <NOT .1ST?>>)
			      (<EQUAL? .Y .AV> <SET PV? T>)
			      (<EQUAL? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>
				      ;<SET 1ST? <>>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <COND (<PRINT-CONT .Y .V? 0>
					     <SET 1ST? <>>)>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <SET LEVEL <+ .LEVEL 1>> ;"not in Zork III"
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV ,ADVENTURER>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <COND (<L? .LEVEL 0> <SET LEVEL 0>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <SET LEVEL <+ .LEVEL 1>> ;"not in Zork III"
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<EQUAL? .OBJ ,WINNER>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ " is: " CR>)
		      (<FSET? .OBJ ,ACTORBIT>
		       <TELL "The " D .OBJ " is holding: " CR>)
		      (T
		       <TELL "The " D .OBJ " contains:" CR>)>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT> <FSET? .OBJ ,OPENBIT>>>>

"Scoring"

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL BASE-SCORE 0>

<ROUTINE SCORE-UPD (NUM)
	 <SETG BASE-SCORE <+ ,BASE-SCORE .NUM>>
	 <SETG SCORE <+ ,SCORE .NUM>>
	 T>

<ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)
	 <COND (<G? <SET TEMP <GETP .OBJ ,P?VALUE>> 0>
		<SCORE-UPD .TEMP>
		<PUTP .OBJ ,P?VALUE 0>)>>

<ROUTINE FINISH ("OPTIONAL" (SCR T))
	 <COND (.SCR <V-SCORE>)>
	 <CRLF>
	 <CRLF>
	 <COND (.SCR <TELL "Thanks for playing! ">)>
	 <TELL
"Now, press the RETURN (or ENTER) key to go back to the beginning." CR>
	 <READ ,P-LEXV ,P-INBUF>	;"Why is order of args reversed? --SWG"
	 <RESTART>>

<ROUTINE YES? ()
	 <REPEAT ()
		 <PRINTI ">">
		 <READ ,P-INBUF ,P-LEXV>
		 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
			<RTRUE>)
		       (<EQUAL? <GET ,P-LEXV 1> ,W?N ,W?NO>
			<RFALSE>)
		       (T
			<CRLF>
			<TELL
"Please type \"YES\" or \"NO\" and then hit the RETURN key ">)>>>

"Death"

<GLOBAL DEAD <>>

<GLOBAL DEATHS 0>

<GLOBAL LUCKY 1>

;"JIGS-UP is in ACTIONS.ZIL"

;"RANDOMIZE-OBJECTS is in ACTIONS.ZIL"

;"KILL-INTERRUPTS is in ACTIONS.ZIL"

"Object Manipulation"

<GLOBAL FUMBLE-NUMBER 7>

<GLOBAL FUMBLE-PROB 8>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 #DECL ((VB) <OR ATOM FALSE> (CNT) FIX (OBJ) OBJECT)
	 <COND (,DEAD
		<COND (.VB
		       <TELL "Your hand passes through its object." CR>)>
		<RFALSE>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		;"Kludge for parser calling itake"
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Your load is too heavy">
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL", especially in light of your condition.">)
			     (T
			      <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<AND <VERB? TAKE>
		     <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		<TELL
		 "You're holding too many things already!" CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FSET ,PRSO ,TOUCHBIT>
		<FCLEAR ,PRSO ,NDESCBIT>
		<SCORE-OBJ ,PRSO>
		<COND (<EQUAL? ,PRSO ,SPOUT-PLACED>
		       <SETG SPOUT-PLACED ,GROUND>)>
		<RTRUE>)>>

<ROUTINE IDROP ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL "You're not carrying the " D ,PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "The " D ,PRSO " is closed." CR>
		<RFALSE>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TAKE-IT-OFF>
		<RFALSE>)
	       (T
		<MOVE ,PRSO <LOC ,WINNER>>
		<RTRUE>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WEARBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <EQUAL? .OBJ ,PLAYER>
				    <FSET? .CONT ,WEARBIT>>
			       <SET WT <+ .WT 1>>)
			      (T
			       <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

"Miscellaneous"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<GLOBAL INDENTS
	<TABLE ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

<ROUTINE HACK-HACK (STR)
	 <COND (<AND <IN? ,PRSO ,GLOBAL-OBJECTS>
		     <VERB? WAVE RAISE LOWER>>
		<TELL "The " D ,PRSO " isn't here!" CR>)
	       (T
		<TELL .STR D ,PRSO <PICK-ONE ,HO-HUM> CR>)>>

<GLOBAL HO-HUM
	<LTABLE
	 0
	 " doesn't seem to work."
	 " isn't notably helpful."
	 " has no effect.">>

<ROUTINE NO-GO-TELL (AV WLOC)
	 <COND (.AV
		<TELL "You can't go there in " A .WLOC ".">)
	       (T
		<TELL "You can't go there without a vehicle.">)>
	 <CRLF>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T)
	       "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <LOC ,WINNER>)
	             (AV <>) OLIT TEMP-ELAPSED)
	 <COND (<EQUAL? ,GAME-FLAG 2>
		<SET TEMP-ELAPSED <GET <GETP ,HERE ,P?C-MOVE> 
				       <- ,PRSO ,LOW-DIRECTION>>>
		<COND (<G? .TEMP-ELAPSED 0>
		       <SETG C-ELAPSED .TEMP-ELAPSED>)
		      (T
		       <SETG C-ELAPSED 20>)>)>
	 <SET OLIT ,LIT>
	 <COND (<FSET? .WLOC ,VEHBIT>
		<SET AV <GETP .WLOC ,P?VTYPE>>)>
	 <COND (<AND <NOT .LB>
		     <NOT .AV>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<AND <NOT .LB>
		     <NOT <FSET? .RM .AV>>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<AND <FSET? ,HERE ,RLANDBIT>
		     .LB
		     .AV
		     <NOT <EQUAL? .AV ,RLANDBIT>>
		     <NOT <FSET? .RM .AV>>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<FSET? .RM ,RMUNGBIT>
		<TELL <GETP .RM ,P?LDESC> CR>
		<RFALSE>)
	       (T
		<COND (.AV
		       <MOVE .WLOC .RM>)
		      (T
		       <MOVE ,WINNER .RM>)>
		<SETG HERE .RM>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT>
			    <NOT ,LIT>
			    <PROB 80>>
		       <JIGS-UP
"Oh, no! A lurking grue slithered into the room and devoured you.">
		       <RFATAL>)>
		<COND (<AND <NOT ,LIT>
			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <TELL "You have moved into a dark place." CR>
		       <SETG P-CONT <>>)>
		<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
		<SCORE-OBJ .RM>
		<COND (<NOT <EQUAL? ,HERE .RM>> <RTRUE>)
		      (<NOT <EQUAL? ,ADVENTURER ,WINNER>>
		       <TELL "The " D ,WINNER " leaves the room." CR>)
		      (.V? <V-FIRST-LOOK>)>
		<RTRUE>)>>

<ROUTINE GO-NEXT (TBL "AUX" VAL)
	 <COND (<SET VAL <LKP ,HERE .TBL>>
		<GOTO .VAL>)>>

<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<EQUAL? <GET .TBL .CNT> .ITM>
			<COND (<EQUAL? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

;<ROUTINE WORD-TYPE (OBJ WORD "AUX" SYNS)
	  ;"not referenced, removed 2/27/85 by SEM"
	 <ZMEMQ .WORD
		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
		<- </ <PTSIZE .SYNS> 2> 1>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" T)
	 <COND (<SET T <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .T <- <PTSIZE .T> 1>>)>> 

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .W .WHAT>
			     <NOT <EQUAL? .W ,ADVENTURER>>>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>>
			<RETURN <>>)>>>

;<ROUTINE IN-HERE? (OBJ) ;"not referenced, removed 2/27/85 by SEM"
	 <OR <IN? .OBJ ,HERE>
	     <GLOBAL-IN? .OBJ ,HERE>>>

<ROUTINE HELD? (CAN)
	 <REPEAT ()
		 <SET CAN <LOC .CAN>>
		 <COND (<NOT .CAN> <RFALSE>)
		       (<EQUAL? .CAN ,WINNER> <RTRUE>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) T) ;"finds room beyond given door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (ELSE
			<SET T <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .T> ,DEXIT>
				    <EQUAL? <GETB .T ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

;<ROUTINE MUNG-ROOM (RM STR) ;"not referenced, removed 2/27/85 by SEM"
	 <FSET .RM ,RMUNGBIT>
	 <PUTP .RM ,P?LDESC .STR>>

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>
	 <SETG P-IT-LOC ,HERE>>

<GLOBAL HELLOS
	<LTABLE 0 "Hello."
	       "Good day."
	       "Nice weather we've been having lately."
	       "Goodbye.">>

<GLOBAL YUKS
	<LTABLE
	 0
	 "A valiant attempt."
	 "You can't be serious."
	 ;"Not bloody likely."
	 "An interesting idea..."
	 "What a concept!">>

<GLOBAL DUMMY
	<LTABLE 0 
		"Look around."
	        "Too late for that."
	        "Have your eyes checked.">>

<GLOBAL CANT-GO "You can't go that way.">

;<ROUTINE V-SIT-ON () ;"not referenced, removed 2/27/85 by SEM"
	 <COND (<EQUAL? ,PRSO ,CRATE>
		<TELL
"You easily weigh enough to make the crate's life-cycle far shorter than it
would have liked. Needless to say, after having been crushed flat by your
heartless attempt, it decides to move on, find what the next life-cycle has in
store for it, and vanishes into the mystical unknown." CR>
		<REMOVE ,CRATE>
		<SETG P-IT-LOC <>>
		<RTRUE>)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?CLIMB-ON ,PRSO>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,GROUND ,SAND>
		<TELL "No sitting down on the job, now." CR>)
	       (T
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE TBL-TO-INSIDE (OBJ TBL "OPTIONAL" STR "AUX" (OFFS 0) MAX)
	 <COND (<NOT <FSET? .OBJ ,SURFACEBIT>>
		<TELL "The " D .OBJ " is already open." CR>
		<RTRUE>)>
	 <COND (<FIRST? .OBJ>
		<OBJS-SLIDE-OFF .OBJ>)>
	 <SET MAX <GET .TBL 0>>
	 <COND (<NOT .STR>
		<TELL "Opened.">)
	       (T <TELL .STR>)>
	 <FCLEAR .OBJ ,SURFACEBIT>
	 <REPEAT ()
		 <SET OFFS <+ .OFFS 1>>
		 <COND (<G? .OFFS .MAX>
			<RETURN>)
		       (<NOT <EQUAL? <GET .TBL .OFFS> 0>>
			<MOVE <GET .TBL .OFFS> .OBJ>
			<PUT .TBL .OFFS 0>)>>
	 <COND (<FIRST? .OBJ>
		<TELL " Opening the " D .OBJ " reveals ">
		<PRINT-CONTENTS .OBJ>
		<TELL ".">)>
	 <CRLF>>

<ROUTINE INSIDE-OBJ-TO (TBL OBJ "AUX" (OFFS 0) F N)
	 <COND (<FSET? .OBJ ,SURFACEBIT>
		<TELL "The " D .OBJ " is already closed." CR>
		<RTRUE>)>
	 <FSET .OBJ ,SURFACEBIT>
	 <TELL "Closed." CR>
	 <COND (<NOT <FIRST? .OBJ>>
		<RTRUE>)>
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<REMOVE .N>
			<REPEAT ()
				<SET OFFS <+ .OFFS 1>>
				<COND (<EQUAL? <GET .TBL .OFFS> 0>
				       <PUT .TBL .OFFS .N>
				       <RETURN>)>>)>>>
	       
<ROUTINE OBJS-SLIDE-OFF (OBJ "AUX" F N THERE)
	 <SET THERE <LOC .OBJ>>
	 <COND (<EQUAL? .THERE ,WINNER>
		<SET THERE ,HERE>)>
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<MOVE .N .THERE>)>>
	 <TELL "Everything on the " D .OBJ " slides off its top." CR>
	 <CRLF>>

;<ROUTINE V-FILL-IN () ;"not referenced, removed 2/27/85 by SEM"
	 <COND (<NOT <EQUAL? ,PRSO ,HOLE ,MANUAL>>
		<TELL "I don't know how to fill in the " D ,PRSO "." CR>)
	       (<PRSO? ,HOLE>
		<TELL "Let time and Mother Nature take care of that." CR>)
	       (T
		<PERFORM ,V?FILL-OUT ,MANUAL>
		<RTRUE>)>>

<ROUTINE V-SLEEP ()
	 <COND (<EQUAL? ,GAME-FLAG 2>
		<COND (<EQUAL? ,SLEEPY-LEVEL 0>
		       <TELL "You're not tired!" CR>)
		      (<GET <INT I-FALL-ASLEEP> ,C-ENABLED?>
		       <TELL
"You'll probably be asleep before you know it." CR>)
		      (T
		       <TELL
"Civilized members of society usually sleep in beds." CR>)>)
	       (<IN? ,WINNER ,COT>
		<TELL 
"You close your eyes, but your mind is too active to let you sleep." CR>)
	       (<IN? ,COT ,HERE>
		<MOVE ,WINNER ,COT>
		<TELL "You get into the cot and try to get comfy. ">
		<V-SLEEP>
		<RTRUE>)
	       (,PRSO
		<TELL "That doesn't sound too comfortable to me." CR>)
	       (T
		<TELL "Better find a good place to lie down." CR>)>>

<ROUTINE V-SLIDE ()
	 <TELL <PICK-ONE ,YUKS> CR>>

<ROUTINE V-STAND-UNDER ()
	 <COND (<NOT <EQUAL? ,GAME-FLAG 3>>
		<TELL "You can't do that in this game." CR>)
	       (<AND <EQUAL? ,PRSO ,CRATE ,PLANE ,PARACHUTE>
		     <IN? ,PRSO ,GLOBAL-OBJECTS>>
		<COND (<NOT <IN-A-TENT?>>
		       <TELL "It looks like that's just where you are." CR>)
		      (T
		       <TELL "Better get out of the tent first." CR>)>)
	       (T
		<TELL "You can't stand under that!" CR>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<NOT <EQUAL? ,GAME-FLAG 3>>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<AND <L? ,MOVES 8>
		     <NOT <IN-A-TENT?>>>
		<TELL "You see a pretty plane. Oh boy!" CR>)
	       (<EQUAL? <LOC ,WINNER> ,COT>
		<MOVE ,WINNER ,HERE>
		<PERFORM ,V?LOOK-UP>
		<MOVE ,WINNER ,COT>
		<RTRUE>)
	       (<IN-A-TENT?>
		<TELL "You see canvas. What else?" CR>)
	       (T
		<TELL "You see a blue sky with wisps of billowy clouds." CR>)>>

<ROUTINE V-FILL-OUT ()
	 <COND (<NOT <EQUAL? ,PRSO ,MANUAL>>
		<TELL "There's no need for filling that out." CR>)
	       (T
		<TELL
"Okay. Find me a pen or a pencil and I'll do the best I can." CR>)>>

<ROUTINE PRE-COMPARE ("AUX" (FLG <>))
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT <GETP ,PRSO ,P?VTYPE>>
		<SET FLG T>)
	       (<NOT <EQUAL? <GETP ,PRSO ,P?VTYPE>
			     <GETP ,PRSI ,P?VTYPE>>>
		<SET FLG T>)>
	 <COND (.FLG
		<TELL "Comparisons between the " D ,PRSO " and the " D ,PRSI
		      " would not really help." CR>
		<RTRUE>)
	       (ELSE
		<RFALSE>)>>

<ROUTINE V-COMPARE ()
	 <COND (<PRSO? ,ROCK-LOCK ,STONE-KEY>
		<TELL 
"It looks as if the small cube would fit into the opening almost exactly." CR>)
	       (T
		<TELL "The " D ,PRSO " and the " D ,PRSI " are the same size."
		      CR>)>>

<ROUTINE V-FOO-COMPARE ()
	 <COND (<L? <GET ,P-PRSO 0> 2>
		<TELL "You have to compare the " D ,PRSO " to something else."
		      CR>
		<RTRUE>)
	       (T
	        <PERFORM ,V?COMPARE <GET ,P-PRSO 1> <GET ,P-PRSO 2>>
		<RFATAL>)>>

<ROUTINE V-READ-INSIDE ()
	 <TELL "There's nothing to read there." CR>>

<ROUTINE V-UNFOLD ()
	 <COND (<EQUAL? ,PRSO ,LADDER>
		<PERFORM ,V?OPEN ,LADDER>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSO ,MAP>>
		<HOW? ,PRSO>)
	       (T
		<PERFORM ,V?OPEN ,MAP>
		<RTRUE>)>>

<ROUTINE V-FOLD ()
	 <COND (<EQUAL? ,PRSO ,LADDER>
		<PERFORM ,V?CLOSE ,LADDER>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSO ,MAP>>
		<HOW? ,PRSO>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "It's already folded up." CR>
		<RTRUE>)
	       (T
		<TELL "Okay. The map has been folded." CR>
		<FCLEAR ,MAP ,OPENBIT>
		<RTRUE>)>>

<GLOBAL CROC-STR
"You manage to wade a few feet into the river, but this makes the crocodiles
spring into action -- they advance far more quickly than you thought possible.
You panic and turn to the bank, attempting to flee. Your splashing about makes
the beasts double their efforts and reach you just as you are about to step on
shore. The last thought you have is a slight amazement at how many teeth a
crocodile has and just how sharp they are.">

<ROUTINE HOW? (OBJ)
	 <TELL "I don't know how to do that to " A .OBJ "." CR>>

<ROUTINE HUH? ("OPTIONAL" (RARG <>))
	 <COND (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)>>

<ROUTINE V-PUSH-THROUGH ()
	 <TELL
"Pushing the " D ,PRSO " in that way isn't particularly helpful." CR>>

<ROUTINE V-DRINK-FROM ("AUX" OBJ)
	 <COND (<NOT <EQUAL? ,GAME-FLAG 3>>
		<TELL "How peculiar!" CR>)
	       (<NOT ,PRSI>
		<COND (<EQUAL? ,PRSO ,NILE-RIBBAH>
		       <SET OBJ ,GLOBAL-WATER>)
		      (<EQUAL? ,PRSO ,CANTEEN>
		       <COND (<AND <OR <IN? ,CANTEEN ,PLAYER>
				       <IN? ,CANTEEN ,HERE>>
				   <0? ,WATER-LEFT>>
			      <TELL
"There's nothing to drink in the canteen." CR>
			      <RTRUE>)
			     (T <SET OBJ ,WATER>)>)
		      (T
		       <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
			      <TELL "How peculiar!" CR>
			      <RTRUE>)
			     (<NOT <FIRST? ,PRSO>>
			      <TELL "There's nothing to drink in the " D ,PRSO
				    "." CR>
			      <RTRUE>)
			     (T
			      <SET OBJ <FIRST? ,PRSO>>
			      <COND (<NOT <FSET? .OBJ ,DRINKBIT>>
				     <TELL
"I don't think there's anything worth drinking in the " D ,PRSO "." CR>
				     <RTRUE>)>)>)>
		<PERFORM ,V?DRINK .OBJ>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSO ,GLOBAL-WATER ,WATER>
		     <EQUAL? ,PRSI ,NILE-RIBBAH>>
		<COND (<NOT <EQUAL? ,HERE ,RIVER-BANK>>
		       <TELL "I see no " D ,PRSO " here." CR>
		       <RTRUE>)
		      (ELSE
		       <PERFORM ,V?DRINK ,PRSO>
		       <RTRUE>)>)
	       (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "Better open the " D ,PRSI " first." CR>)
	       (<NOT <IN? ,PRSO ,PRSI>>
		<TELL "I can't see any " D ,PRSO " in the " D ,PRSI "." CR>)
	       (T
		<PERFORM ,V?DRINK ,PRSO>
		<RTRUE>)>>

<ROUTINE NOT-HOLDING (OBJ)
	 <TELL "You're not holding the " D .OBJ "." CR>>