"TUTORIAL for
		     	      SAMPLER
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<ROUTINE INTRO ()
	 <TELL "|
In what follows, text in parentheses (here is an example) is part of the
Tutorial and not part of the story itself.  Infocom's interactive
fiction starts with a description of your location within a story.  At
the end of the description comes the prompting character \">\", which
indicates that the program is waiting for you to type in what to do
next.|
|
The Tutorial is designed to provide you with help as you move through
the sample scenario.  If you can't decide what to do at a prompt, type
HELP and press the RETURN (or ENTER) key.  Note that HELP is available
only in this Tutorial.  You'll have to use your own wits in the excerpts
from Zork I, Planetfall, and Infidel.|
|
Now press the RETURN (or ENTER) key to see the opening of the Tutorial
story.">
	 <READ ,P-LEXV ,P-INBUF>
	 <CRLF>
	 <CRLF>
	 <V-VERSION>
	 <CRLF>
	 <V-LOOK>
	 <TELL "|
>|
(Hit the RETURN key now to continue the tutorial.)">
	 <READ ,P-INBUF ,P-LEXV>
	 <TELL "|
(In order to proceed you need some idea of your purpose in the story. In one
fantasy game, for example, the goal is to obtain treasures; in a mystery game,
the goal is to arrest the murderer. The goal of each game is usually presented
in the game documentation. The goal for the Tutorial Game is:|
|
To trap the prized butterfly in the room to the south of the living room.|
|
Hit the RETURN key now to continue the tutorial.)">
	 <READ ,P-INBUF ,P-LEXV>
	 <TELL "|
(You indicate your desires within the story by typing English sentences.
A good rule of thumb in determining the kinds of sentences that will
be understood is to think of completing the following sentence: \"I want
to ... \" The three dots stand for the words you will type in. You will
often want to see the description of the place you're in: you can type
\"LOOK AROUND\" or, simply, \"LOOK\" to do just that. Try that now at the
prompt. Remember to end all of your typing by hitting the RETURN key.)|">
	 <PUTP ,ADVENTURER ,P?ACTION A-LOOK>>

<ROUTINE A-LOOK ("OPTIONAL" FOO)
	 <COND (<VERB? QUIT SAVE RESTORE RESTART ;HELP VERSION DEBUG> <RFALSE>)
	       (<AND <VERB? LOOK>
		     <EQUAL? ,PRSO ,ROOMS <>>>
		<ENABLE <QUEUE I-LOOK 1>>
		<RFALSE>)
	       (T
		<TELL
"(Please type \"LOOK\" or \"LOOK AROUND\" to get a description of your
surroundings.)" CR>)>>      
  
<GLOBAL LAST-COMMENT
"If you're having trouble, you might want to review the Tutorial. Type RESTART
to return to the menu.">

<ROUTINE COMMENT (STR "OPTIONAL" (BEF <>) (AFT <>))
	 <COND (.BEF <CRLF>)>
	 <SETG LAST-COMMENT .STR>
	 <TELL .STR>
	 <COND (.AFT <CRLF>)>
	 T>

<ROUTINE I-LOOK ()
	 <COMMENT
"(Good! You have now seen a description of the living room on your screen.
A few special commands should be noted. One, \"SCORE\", lets you know how
well you're doing in comparison to the best possible score. You might have
noticed the special line at the top of the screen. It is called the Status
Line, and always indicates your location in the game, your score, and the
number of turns (sometimes called moves) you have taken.|
|
Another useful command is \"INVENTORY\". It lets you know what objects you
are carrying. Try it now.)|
" T>
	 <SETG LAST-COMMENT
"(Try using the \"INVENTORY\" command to find out what you're carrying.)">
	 <PUTP ,WINNER ,P?ACTION A-INVENTORY>>

<ROUTINE A-INVENTORY ("OPTIONAL" FOO)
	 <COND (<VERB? QUIT SAVE RESTORE RESTART VERIFY HELP VERSION DEBUG>
		<RFALSE>)
	       (<VERB? LOOK SCORE>
		<RFALSE>)
	       (<VERB? INVENTORY>
		<ENABLE <QUEUE I-INVENTORY 1>>
		<RFALSE>)
	       (T
		<COMMENT
"(Please try typing \"INVENTORY\" to get a list of your possessions.)" <> T>)>>

<ROUTINE I-INVENTORY ()
	 <COMMENT
"(Oh, well. You weren't carrying anything to start with, but you might have
been, so it's good to have checked. For convenience \"I\" is a short form of
\"INVENTORY\" and \"L\" is a short form of \"LOOK AROUND\".|
|
To move around, you use compass directions. For example,
to walk to the east, you can type \"WALK EAST\". The stories often mention
passages, tunnels, roads, and the like in descriptions, but these are
mentioned for descriptive purposes only. Let's try going east.)" T T>
	 <PUTP ,WINNER ,P?ACTION A-WALK>>

<ROUTINE ENTER-CHECK ()
	 <COND (<VERB? THROUGH WALK-TO>
		<COND (<EQUAL? ,PRSO ,CLOSET-OBJ>
		       <COND (<EQUAL? ,HERE ,T-LIVING-ROOM>
			      <DO-WALK ,P?EAST>
			      <RTRUE>)>)
		      (<EQUAL? ,PRSO ,EAST-DOOR>
		       <COND (<EQUAL? ,HERE ,CLOSET>
			      <SETG PRSO ,P?WEST>)
			     (T <SETG PRSO ,P?EAST>)>
		       <DO-WALK ,PRSO>
		       <RTRUE>)
		      (<EQUAL? ,PRSO ,SOUTH-DOOR>
		       <COND (<EQUAL? ,HERE ,T-LIVING-ROOM>
			      <SETG PRSO ,P?SOUTH>)
			     (T
			      <SETG PRSO ,P?NORTH>)>
		       <DO-WALK ,PRSO>
		       <RTRUE>)>)
	       (<VERB? DROP>
		<COND (<EQUAL? ,PRSO ,CLOSET-OBJ>
		       <COND (<EQUAL? ,HERE ,CLOSET>
			      <DO-WALK ,P?WEST>
			      <RTRUE>)>)>)>>

<ROUTINE A-WALK ("OPTIONAL" FOO)
	 <COND (<AND <VERB? THROUGH DROP WALK-TO> <ENTER-CHECK>> <RTRUE>)>
	 <COND (<VERB? QUIT SAVE RESTORE WALK-TO RESTART VERIFY HELP
		       VERSION DEBUG>
		<RFALSE>)
	       (<VERB? WALK>
		<COND (<==? ,PRSO ,P?EAST>
		       <ENABLE <QUEUE I-WALK 1>>
		       <RFALSE>)
		      (T
		       <TELL
"(Try the other directions on your own time! It's more interesting to the
east. Trust me.)" CR>)>)
	       (<VERB? LOOK INVENTORY SCORE>
		<RFALSE>)
	       (T
		<TELL
"(Let's go east for now.)" CR>)>>

<ROUTINE I-WALK ()
	 <COMMENT 
"(Hmm. This illustrates two important points. First, don't believe
everything a computer tells you. Second, objects lying around like
tools, lights, and weapons can be useful and should probably be
carried around for situations like this. Luckily, we have seen a lantern
in the living room. As the man said, \"Go west!\")" T T>
	 <PUTP ,WINNER ,P?ACTION A-RETURN-LR>>
		
<ROUTINE A-RETURN-LR ("OPTIONAL" FOO)
	 <COND (<AND <VERB? THROUGH DROP WALK-TO> <ENTER-CHECK>> <RTRUE>)>
	 <COND (<VERB? QUIT SAVE RESTORE WALK-TO RESTART VERIFY
		       HELP VERSION DEBUG>
		<RFALSE>)
	       (<AND <VERB? WALK> <==? ,PRSO ,P?WEST>>
		<ENABLE <QUEUE I-RETURN-LR 1>>
		<RFALSE>)
	       (<AND <VERB? EXAMINE FIND> <==? ,PRSO ,GRUE>>
		<ENABLE <QUEUE I-FALSE-1 1>>
		<RFALSE>)
	       (<VERB? LOOK INVENTORY SCORE>
		<RFALSE>)
	       (T
		<COMMENT 
"(Type \"WALK WEST\", \"GO WEST\", or simply \"WEST\" to go back to
the living room from here.)" <> T>)>>

<ROUTINE I-FALSE-1 ()
	 <TELL CR
"(You couldn't wait to find out, could you.... Now try going back
to the living room.)" CR>>

<ROUTINE I-RETURN-LR ()
	 <TELL
"|
(We're back now and, from the look of things, in need of light.
There are many common verbs that are understood in Infocom's interactive
fiction. These include TAKE, DROP, PUT, TURN ON, TURN OFF, EXAMINE,
READ, BREAK, HIT, EAT and a host of others.  Rather than include a vocabulary
list, we build a large vocabulary into them and encourage you
to try anything you like.|
|
From now on, you're going to be more on your own. If you get stuck, though,
you can always type \"HELP\" for a nudge in the right direction.|
|
Using some of the verbs mentioned earlier, try to shed some light on the
broom closet.)|
">
	 <SETG LAST-COMMENT
"(In trying to shed some light on the broom closet, you will need to carry
something that is lighted into the closet with you. Some of the verbs you
might need are TAKE, TURN ON, and WALK.)">
	 <PUTP ,WINNER ,P?ACTION A-LAMP>>

<ROUTINE A-LAMP ("OPTIONAL" FOO)
	 <COND (<AND <VERB? THROUGH DROP WALK-TO> <ENTER-CHECK>> <RTRUE>)>
	 <COND (<VERB? QUIT SAVE RESTORE WALK-TO RESTART VERIFY
		       HELP VERSION DEBUG>
		<RFALSE>)
	       (<VERB? LOOK INVENTORY SCORE>
		<RFALSE>)
	       (<AND <VERB? LAMP-ON>
		     <EQUAL? ,PRSO ,T-LANTERN>
		     <NOT <FSET? ,PRSO ,ONBIT>>>
		<ENABLE <QUEUE I-LAMP-ON 1>>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,T-LANTERN>
		     <NOT <IN? ,PRSO ,WINNER>>>
		<ENABLE <QUEUE I-LAMP-TAKE 1>>
		<RFALSE>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,PRSO ,T-LANTERN>
		     <NOT <FSET? ,PRSO ,ONBIT>>>
		<ENABLE <QUEUE I-LAMP-EXAMINE 1>>
		<TELL "The lantern isn't lit." CR>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,PRSO ,T-LANTERN>>
		<ENABLE <QUEUE I-LAMP-EXAMINE-1 1>>
		<TELL "The lantern is lit." CR>)
	       (<VERB? WALK>
		<COND (<==? ,PRSO ,P?EAST>
		       <COND (<AND <FSET? ,T-LANTERN ,ONBIT>
				   <IN? ,T-LANTERN ,WINNER>
				   <EQUAL? ,HERE ,T-LIVING-ROOM>>
			      <ENABLE <QUEUE I-RETURN-CLOSET 1>>
			      <RFALSE>)
			     (<AND <IN? ,T-LANTERN ,WINNER>
				   <EQUAL? ,HERE ,T-LIVING-ROOM>>
			      <COMMENT
"(You had better light that lantern before going back into that
dark closet again.)" <> T>)
			     (T
			      <COMMENT
"(You should get something that gives off light before going into that
dark closet again. Remember, use \"INVENTORY\" to list your possessions
and \"LOOK AROUND\" to describe your location.)" <> T>)>)
		      (T
		       <TELL
"(Let's stick to going into the closet for now.)" CR>)>)
	       (<EQUAL? ,PRSO ,T-LANTERN>
		<COND (<AND <IN? ,T-LANTERN ,WINNER>
			    <FSET? ,T-LANTERN ,ONBIT>>
		       <TELL
"(You've done enough with the lantern. Why don't you try returning to
the closet to see what's inside?)" CR>)
		      (<AND <VERB? PUT>
			    <EQUAL? ,PRSI ,CLOSET-OBJ>>
		       <TELL
"(You can't do that without going into the closet yourself. Why don't
you try that?)" CR>)
		      (T
		       <TELL
"(Doing that to the lantern isn't very useful. Try doing something
with the lantern that will help you see what's in the closet.)" CR>)>)
	       (<AND <IN? ,T-LANTERN ,WINNER>
		     <FSET? ,T-LANTERN ,ONBIT>>
		<TELL
"(Try returning to the closet, now that you have the lighted
lantern.)" CR>)
	       (T
		<TELL
"(Try sticking to sentences dealing with the lantern, which is
useful if we're going to see anything in the closet.)" CR>)>>

<ROUTINE I-LAMP-ON ()
	 <TELL CR
"(That was a good idea. If you examined the lantern beforehand, you knew
for a fact that it wasn't lit. By the way, you could have typed \"LIGHT THE
SHINY BRASS LANTERN\", \"TURN ON THE BRASS LANTERN\", \"TURN THE LANTERN
ON\", etc. to turn it on. The large number of ways of expressing your desires
greatly enhances the playability of Infocom's interactive fiction.)" CR>
	 <SETG SCORE <+ ,SCORE 10>>>

<ROUTINE I-LAMP-TAKE ()
	 <TELL CR
"(Good move. You will need the lantern with you when you return to the
closet if you intend to see anything. You could have gotten the lamp
with \"TAKE LANTERN\", \"PICK UP THE LANTERN\", \"TAKE THE LANTERN FROM THE
TABLE\", \"GET THE LANTERN\", or anything similar. You could also
have called the lantern a lamp.)" CR>
	 <SETG SCORE <+ ,SCORE 10>>>

<ROUTINE I-LAMP-EXAMINE ()
	 <TELL CR
"(Examining the lantern revealed that it wasn't lit. This tells you
something that will need to be done before proceeding. \"LOOK AT
THE LANTERN\" and \"EXAMINE LANTERN\" are two ways of doing this.)" CR>>

<ROUTINE I-LAMP-EXAMINE-1 ()
	 <TELL CR
"(Examining the lantern revealed that it was lit. It never hurts
to be safe, especially when danger is nearby.)" CR>>

<ROUTINE I-RETURN-CLOSET ()
	 <COMMENT
"(With the lantern in your possession, you can see what's in the closet.
Two items of interest there are the net, which we will certainly need to
capture the prize butterfly, and a key. One never knows where a key will
be needed. Let's get those things and return to the living room with
them.)" T T>
	 <PUTP ,WINNER ,P?ACTION A-TAKE-STUFF>>  

<ROUTINE A-TAKE-STUFF ("OPTIONAL" FOO)
	 <COND (<AND <VERB? THROUGH DROP WALK-TO> <ENTER-CHECK>> <RTRUE>)>
	 <COND (<VERB? QUIT SAVE RESTORE WALK-TO RESTART VERIFY
		       HELP VERSION DEBUG> <RFALSE>)
	       (<VERB? LOOK INVENTORY SCORE>
		<RFALSE>)
	       (<VERB? TAKE>
		<ENABLE <QUEUE I-TAKE-STUFF 1>>
		<RFALSE>)
	       (<AND <VERB? WALK>
		     <EQUAL? ,PRSO ,P?WEST ,P?OUT>
		     <==? ,HERE ,CLOSET>>
		<COND (<AND <IN? ,KEY ,WINNER>
			    <IN? ,NET ,WINNER>>
		       <ENABLE <QUEUE I-TAKE-STUFF-1 1>>
		       <RFALSE>)>)
	       (<AND <VERB? LAMP-OFF>
		     <==? ,PRSO ,T-LANTERN>
		     <NOT <FSET? ,HERE ,ONBIT>>>
		<TELL
"(This is not a promising idea in an otherwise dark room.)" CR>)
	       (<VERB? WALK EAT EXAMINE LAMP-ON LAMP-OFF>
		<RFALSE>)
	       (<AND <IN? ,KEY ,WINNER> <IN? ,NET ,WINNER>>
		<COMMENT
"(Try returning to the living room.)" <> T>)
	       (T
		<COMMENT
"(Make sure you've taken all of the objects from the broom closet and
then return to the living room.)" <> T>)>>

<GLOBAL TOLD-ALREADY <>>

<ROUTINE I-TAKE-STUFF ()
	 <COND (,TOLD-ALREADY <RFALSE>)
	       (<AND <IN? ,KEY ,WINNER>
		     <IN? ,NET ,WINNER>>
		<SETG TOLD-ALREADY T>
		<COMMENT
"(It seems as if you have everything worth taking, since the dust
won't be of much help. By the way, Infocom's interactive fiction allows
you to mention more than one object at a time. For example, to take both
the net and the key, you may type \"TAKE THE NET AND THE KEY\".
Let's return now to the living room.)" <> T>
		<SETG SCORE <+ ,SCORE 10>>)>> 

<ROUTINE I-TAKE-STUFF-1 ()
	 <COMMENT
"(Great. Notice that the long description of the living room is not
being repeated when we return to it. This is for your convenience. You
can always get the description of your surroundings by typing \"LOOK\".
Now let's try to find those butterflies. There's only one direction that
doesn't return us to the closet and that's south. Oh, I just remembered.
There was a sign over the mahogany door. Like other reading materials
in our scenarios, it's likely to be helpful. Try to find out
what's written on it.)" T T>
	 <SETG LAST-COMMENT
"(Let's try reading the sign now.)">
	 <PUTP ,WINNER ,P?ACTION A-READ-SIGN>>

<ROUTINE A-READ-SIGN ("OPTIONAL" FOO)
	 <COND (<VERB? QUIT SAVE RESTORE WALK-TO RESTART VERIFY
		       HELP VERSION DEBUG> <RFALSE>)
	       (<VERB? INVENTORY LOOK SCORE>
		<RFALSE>)
	       (<AND <VERB? READ EXAMINE>
		     <EQUAL? ,PRSO ,SIGN>>
		<ENABLE <QUEUE I-READ-SIGN 1>>
		<RFALSE>)
	       (T
		<COMMENT
"(To see what's written on the sign, try simply typing \"READ THE SIGN\" or
\"EXAMINE THE SIGN\".)" <> T>)>>

<ROUTINE I-READ-SIGN ()
	 <TELL CR
"(This confirms what we had suspected. Now let's get going.)" CR>
	 <SETG LAST-COMMENT
"(The butterfly is in the room on the other side of the mahogany door. Let's
open it up!)">
	 <PUTP ,WINNER ,P?ACTION A-GO-SOUTH>>

;<ROUTINE I-UNLOCK-DOOR () ;"not referenced, removed 2/27/85 by SEM"
	 <TELL CR
"(Makes sense. Let's see what's to the south.)" CR>
	 <SETG LAST-COMMENT
"(Now that the door's unlocked, let's open it up and go through it.)">
	 <PUTP ,WINNER ,P?ACTION A-GO-SOUTH>>

<ROUTINE A-GO-SOUTH ("OPTIONAL" FOO)
	 <COND (<AND <VERB? THROUGH DROP WALK-TO> <ENTER-CHECK>> <RTRUE>)>
	 <COND (<VERB? QUIT SAVE RESTORE WALK-TO RESTART VERIFY
		       HELP VERSION DEBUG>
		 <RFALSE>)
	       (<VERB? LOOK INVENTORY SCORE>
		<RFALSE>)
	       (<AND <VERB? READ EXAMINE>
		     <EQUAL? ,PRSO ,SIGN>>
		<RFALSE>)
	       (<AND <VERB? THROUGH> <EQUAL? ,PRSO ,SOUTH-DOOR>>
		<TELL
"(This is a reasonable thing to try, although few of our stories will
understand this method of movement. It's always easier to simply use
\"WALK direction\" or just \"direction\" to move around.)" CR>)
	       (<VERB? WALK>
		<COND (<==? ,PRSO ,P?SOUTH>
		       <COND (<NOT <FSET? ,SOUTH-DOOR ,OPENBIT>>
			      <ENABLE <QUEUE I-TRY-SOUTH 1>>
			      <RFALSE>)
			     (T
			      <ENABLE <QUEUE I-THROUGH-DOOR 1>>
			      <RFALSE>)>)
		      (T
		       <COMMENT
"(We've been everyplace else in this little universe already. Concentrate
on going to the south.)" <> T>)>)
	       (<AND <VERB? DROP> <IN? ,PRSO ,WINNER>>
		<TELL
"(Be careful! You may need everything you are carrying!)" CR>)
	       (<AND <VERB? UNLOCK>
		     <EQUAL? ,PRSO ,SOUTH-DOOR>>
		<COND (,DOOR-LOCKED
		       <ENABLE <QUEUE I-TRY-UNLOCK 1>>)>
		<RFALSE>)
	       (<AND <VERB? OPEN> <EQUAL? ,PRSO ,SOUTH-DOOR>>
		<ENABLE <QUEUE I-TRY-OPEN 1>>
		<RFALSE>)
	       (<VERB? SCORE LOOK INVENTORY EXAMINE TAKE DROP EAT MUNG>
		<RFALSE>)
	       (T
		<COMMENT
"(Try something relevant to going through the mahogany door.)" <> T>)>>

<ROUTINE I-TRY-UNLOCK ()
	 <COND (,DOOR-LOCKED
		<COMMENT
"(Try unlocking the south door with the key....)" T T>)
	       (T
		<TELL CR
"(Great! You're on your way.)" CR>)>>

<ROUTINE I-TRY-OPEN ()
	 <COND (,DOOR-LOCKED
		<TELL CR
"(It's a lucky thing that you just happened to take that key, isn't it?)" CR>)
	       (<FSET? ,SOUTH-DOOR ,OPENBIT>
		<COMMENT
"(Let's go south and get 'em!)" T T>
		<SETG SCORE <+ ,SCORE 10>>)
	       (T
		<TELL CR
"(Maybe you should have tried opening the south door?)" CR>)>>
		   
<ROUTINE I-TRY-SOUTH ()
	 <COND (,DOOR-LOCKED
		<TELL CR
"(Since it's closed, we might as well open it.)" CR>)
	       (T
		<TELL CR
"(It's not locked anymore, but it's still closed....)" CR>)>>

<ROUTINE I-THROUGH-DOOR ()
	 <COMMENT
"(Congratulations. You're practically finished. All that's left is
to catch that butterfly! Be VERY careful, though. Don't let it get
away!)" T T>
	 <SETG LAST-COMMENT
"(All that's left is to catch the butterfly! Be very careful, though,
or it'll get away!)">
	 <PUTP ,WINNER ,P?ACTION A-CLOSE-DOOR>>

<ROUTINE A-CLOSE-DOOR ("OPTIONAL" FOO)
	 <COND (<VERB? QUIT SAVE RESTORE WALK-TO RESTART VERIFY
		       HELP VERSION DEBUG> <RFALSE>)
	       (<VERB? SAVE>
		<TELL
"(Not a bad idea. If this weren't the Tutorial, it might be a good
idea to save the game here in case something unexpected happens at
this crucial time. Sadly, you will have to think of something else.)" CR>)
	       (<AND <VERB? CLOSE> <==? ,PRSO ,SOUTH-DOOR>>
		<ENABLE <QUEUE I-CLOSE-DOOR 1>>
		<RFALSE>)
	       (T
		<TELL
"Before you can even start, the butterfly flies gaily through the door
and out of your life. As tears well up in your eyes, you ponder
the glory that was yours had you only closed the door first." CR>
		<ENABLE <QUEUE I-LOST 1>>
		<RTRUE>)>>

<ROUTINE I-LOST ()
	 <TELL CR
"(Oh, well, you can't win them all. This brings up another important
feature of Infocom's interactive fiction: the ability to suspend your play
at any time and continue from that point at a later time, much like placing a
bookmark in a book that you are reading. In an actual game, you might
have suspended the game prior to entering the Butterfly Room, thus
making it easier for you to go back and try another approach without
restarting the game from scratch. Live and learn.|
|
Another important point: the solution to catching the butterfly involved
using a complex sentence like \"CATCH THE BUTTERFLY IN THE NET\" or
\"PLACE THE NET OVER THE BUTTERFLY\". The ability to understand sentences
of this kind is an integral part of Infocom's interactive fiction.)" CR>
	 <FINIS>>

<ROUTINE FINIS ()
	 <SETG LAST-COMMENT
"In the complete versions of these stories you're on your own. Don't spend
too much time working on any one obstacle. Go on and try other things. If you
ever become completely stuck, we offer hint booklets and maps at a nominal
cost.">
	 <FINISH>>		  

<ROUTINE V-HELP ()
	 <TELL ,LAST-COMMENT CR>>

<ROUTINE I-CLOSE-DOOR ()
	 <COMMENT
"(Your instinct was correct. The butterfly, no mental midget,
headed straight for the open door --  but you were quicker. Had you
not closed the door right away, it would have flown the coop. Let's
get it!)" T T>
	 <PUTP ,WINNER ,P?ACTION A-CATCH>> 
		     
<ROUTINE A-CATCH ("OPTIONAL" FOO)
	 <COND (<VERB? QUIT SAVE RESTORE WALK-TO RESTART VERIFY
		       HELP VERSION DEBUG>
		<RFALSE>)
	       (<AND <EQUAL? ,PRSO ,BUTTERFLY>
		     <EQUAL? ,PRSI ,NET>
		     <VERB? CATCH PUT>>
		<COND (<NOT <IN? ,NET ,WINNER>>
		       <TELL
"You don't have the net, I'm afraid." CR>
		       <RTRUE>)>
		<SETG SCORE <+ ,SCORE 10>>
		<TELL ,WINNAGE CR>
		<FINIS>)
	       (<AND <EQUAL? ,PRSO ,NET>
		     <EQUAL? ,PRSI ,BUTTERFLY>
		     <VERB? SWING ATTRACT>>
		<COND (<NOT <IN? ,NET ,WINNER>>
		       <TELL
"You don't have the net, I'm afraid." CR>)>
		<TELL ,WINNAGE CR>
		<FINIS>)
	       (<AND <VERB? CATCH PUT>
		     <EQUAL? ,PRSO ,BUTTERFLY>>
		<TELL
"You would catch it in that?!?" CR>)
	       (<VERB? EXAMINE INVENTORY LOOK SCORE>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,BUTTERFLY>>
		<TELL
"You grab for the butterfly, but it's too quick! It continues
to flutter gracefully about the room." CR>)
	       (<VERB? TAKE DROP PUT>
		<ENABLE <QUEUE I-COME-ON 1>>
		<RFALSE>)
	       (T
		<TELL
"(How about trying something more in line with catching the butterfly?)" CR>)>>

<GLOBAL WINNAGE
"With a deft motion of your arm, the butterfly is trapped within
the net.|
|
(You might have typed anything like the following to have
trapped the butterfly: \"TRAP THE BUTTERFLY IN THE NET\", \"CATCH
THE BUTTERFLY WITH THE NET\", \"SWING THE NET OVER THE BUTTERFLY\",
or anything similar. With Infocom's interactive fiction, you are
encouraged to try whatever comes to your mind. If it doesn't work, try
something similar. Half of the fun is in trying unusual things!)|
|
Congratulations! You have completed your goal of catching the prized
butterfly. You're now ready for the innovative challenges of Infocom's
line of interactive fiction.">

<ROUTINE I-COME-ON ()
	 <TELL CR
"(All right, all right. Now let's catch the butterfly.)" CR>>

<OBJECT CLOSET-OBJ
	(IN LOCAL-GLOBALS)
	(DESC "closet")
	(SYNONYM CLOSET)
	(ADJECTIVE BROOM)
	(FLAGS NDESCBIT)>

<OBJECT DUST
	(IN CLOSET)
	(DESC "dust")
	(SYNONYM DUST)
	(FLAGS NDESCBIT)
	(ACTION DUST-F)>

;"DUST-F is in the PLANETFALL file"

<OBJECT SIGN
	(IN T-LIVING-ROOM)
	(DESC "sign")
	(SYNONYM SIGN LETTER)
	(ADJECTIVE FADED)
	(FLAGS READBIT NDESCBIT)
	(TEXT
"The sign says: \"Butterflies are free. Bring your net.\"")>

<OBJECT LIVING-ROOM-O
	(IN GLOBAL-OBJECTS)
	(DESC "living room")
	(SYNONYM ROOM)
	(ADJECTIVE LIVING)
	(ACTION ROOM-OBJECT-F)>

<OBJECT BROOM-CLOSET-O
	(IN GLOBAL-OBJECTS)
	(DESC "broom closet")
	(SYNONYM CLOSET)
	(ADJECTIVE BROOM)
	(ACTION ROOM-OBJECT-F)>

<ROUTINE ROOM-OBJECT-F ()
	 <COND (<VERB? WALK-TO>
		<TELL
"(In most stories of this type, you move around by indicating the direction in
which you wish to travel, rather than referring to the place by name.)" CR>)
	       (<VERB? EXAMINE>
		<TELL
"(To examine your surroundings, type \"LOOK AROUND\" or something like
that.)" CR>)
	       (T
		<TELL
"(You usually can't refer to rooms by their names.)" CR>)>>

<ROOM T-LIVING-ROOM
      (IN ROOMS)
      (DESC "Living Room")
      (SOUTH TO BUTTERFLY-ROOM IF SOUTH-DOOR IS OPEN)
      (EAST TO CLOSET IF EAST-DOOR IS OPEN)
      (FLAGS ONBIT RLANDBIT)
      (ACTION T-LIVING-ROOM-F)
      (GLOBAL EAST-DOOR SOUTH-DOOR CLOSET-OBJ)>

<ROUTINE T-LIVING-ROOM-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are standing in the living room of a large house. The room is bare
except for a small, square table in the center of the room." CR>
		<COND (<FSET? ,EAST-DOOR ,OPENBIT>
		       <TELL
"An oak door to the east opens into a darkened area">)
		      (T
		       <TELL
"An oak door to the east is closed">)>
		<TELL " and a mahogany door to the south is ">
		<COND (<FSET? ,SOUTH-DOOR ,OPENBIT>
		       <TELL "wide open">)
		      (T <TELL "closed">)>
		<TELL "." CR>
		<TELL
"Above the mahogany door is an old sign with some faded lettering." CR>)>>

<OBJECT T-LANTERN
	(IN XTABLE)
	(DESC "shiny brass lantern")
	(FDESC "A shiny brass lantern is sitting in the center of the table.")
	(SYNONYM LANTERN LAMP)
	(ADJECTIVE SHINY BRASS)
	(FLAGS LIGHTBIT TAKEBIT)
	(SIZE 10)
	(ACTION T-LANTERN-F)>

<ROUTINE T-LANTERN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The lantern is ">
		<COND (<NOT <FSET? ,T-LANTERN ,ONBIT>>
		       <TELL "not ">)>
		<TELL "lit." CR>)>>

<OBJECT XTABLE
	(IN T-LIVING-ROOM)
	(DESC "table")
	(SYNONYM TABLE)
	(ADJECTIVE SMALL SQUARE)
	(FLAGS CONTBIT SURFACEBIT OPENBIT NDESCBIT)
	(CAPACITY 20)
	(ACTION XTABLE-F)>

<ROUTINE XTABLE-F ()
	 <COND (<VERB? TAKE>
		<TELL
"It seems to be firmly attached to the floor." CR>)>>

<ROOM CLOSET
      (IN ROOMS)
      (DESC "Broom Closet")
      (LDESC
"This rather undistinguished place seems to be a broom closet. Oddly
enough, there is no broom here, although there is enough dust and dirt
on the ground to merit a few dozen.")
      (FLAGS RLANDBIT)
      (WEST TO T-LIVING-ROOM IF EAST-DOOR IS OPEN)
      (OUT TO T-LIVING-ROOM IF EAST-DOOR IS OPEN)
      (GLOBAL EAST-DOOR CLOSET-OBJ)>

<OBJECT KEY
	(IN CLOSET)
	(DESC "skeleton key")
	(LDESC
"Amidst the grime, a small skeleton key can be seen on the ground.")
	(SYNONYM KEY)
	(ADJECTIVE SKELETON SMALL)
	(FLAGS TAKEBIT TOOLBIT)
	(ACTION KEY-F)>

<ROUTINE KEY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The key isn't very interesting, except that it might unlock the mahogany
door in the living room." CR>)>>

<OBJECT NET
	(IN CLOSET)
	(DESC "net")
	(LDESC
"A net, suitable for catching butterflies, is sitting in the corner.")
	(SYNONYM NET)
	(FLAGS TAKEBIT)
	(ACTION NET-F)>

<ROUTINE NET-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The net is a typical butterfly net (quite a lucky find)." CR>)>>

<OBJECT EAST-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "oak door")
	(SYNONYM DOOR)
	(ADJECTIVE EAST EASTERN OAK)
	(FLAGS DOORBIT CONTBIT OPENBIT)>

<OBJECT SOUTH-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "mahogany door")
	(SYNONYM DOOR)
	(ADJECTIVE MAHOGANY SOUTH SOUTHE)
	(FLAGS DOORBIT CONTBIT)
	(ACTION SOUTH-DOOR-F)>

<GLOBAL DOOR-LOCKED T>

<ROUTINE SOUTH-DOOR-F ()
	 <COND (<VERB? UNLOCK>
		<COND (<NOT ,DOOR-LOCKED>
		       <TELL
"The door is already unlocked, or don't you remember!" CR>)
		      (<EQUAL? ,PRSI ,KEY>
		       <TELL
"Fortunately for you, the key was the correct one and the door unlocks." CR>
		       <SETG DOOR-LOCKED <>>
		       <RTRUE>)
		      (T
		       <TELL
"That wasn't a very smart thing to try; " D ,PRSI "s are rarely used
in unlocking doors." CR>)>)
	       (<VERB? LOCK>
		<COND (,DOOR-LOCKED
		       <TELL
"The door is sufficiently locked without your help.">)
		      (<EQUAL? ,PRSI ,KEY>
		       <TELL
"Very well. The door is now locked." CR>
		       <SETG DOOR-LOCKED T>)
		      (T
		       <TELL
"Dear, dear. What will you think of next?" CR>)>)
	       (<AND <VERB? OPEN> ,DOOR-LOCKED>
		<TELL
"It seems to be locked!" CR>)
	       (<VERB? KNOCK>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"Why are you knocking on an open door?" CR>)
		      (T
		       <TELL
"Nobody answers." CR>)>)
	       (<VERB? MUNG>
		<TELL
"Besides hurting your shoulder, the effort gets you nowhere." CR>)
	       (<VERB? LISTEN>
		<TELL
"You hear nothing through the door." CR>)>>  

<ROOM BUTTERFLY-ROOM
      (IN ROOMS)
      (DESC "Butterfly Room")
      (NORTH TO T-LIVING-ROOM IF SOUTH-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (ACTION BUTTERFLY-ROOM-F)
      (GLOBAL SOUTH-DOOR)>

<ROUTINE BUTTERFLY-ROOM-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"This is a smaller room than one would expect for the storage of
butterflies, but then again, one doesn't expect rooms to be used for
storing butterflies. The only way out is through a door to the north
that is ">
		<COND (<FSET? ,SOUTH-DOOR ,OPENBIT>
		       <TELL "open">)
		      (T <TELL "closed">)>
		<TELL "." CR>)>> 

<OBJECT BUTTERFLY
	(IN BUTTERFLY-ROOM)
	(DESC "beautiful butterfly")
	(LDESC
"Flying around the room in graceful arcs is the most beautiful butterfly
you have ever seen. Catching it will enhance your reputation as the world's
foremost collector of rare butterflies.")
	(SYNONYM BUTTERFLY INSECT)
	(ADJECTIVE MOST BEAUTI)
	(FLAGS TAKEBIT)
	(ACTION BUTTERFLY-F)> 
	
<ROUTINE BUTTERFLY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is, without doubt, the most beautiful butterfly you have ever
seen. Your collection would be greatly enhanced by its presence." CR>)>>

<ROUTINE V-CATCH ()
	 <TELL "Why would you want to catch that!" CR>>

<ROOM WELCOME-MAT
      (IN ROOMS)
      (DESC "Welcome to Infocom")>
      
<ROOM WITNESS-ROOM
      (IN ROOMS)
      (DESC "Witness")>