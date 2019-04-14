"MISC for
				SAMPLER
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

;"former MACROS file"

<SETG C-ENABLED? 0>
<SETG C-ENABLED 1>
<SETG C-DISABLED 0>

<DEFMAC TELL ("ARGS" A)
	<FORM PROG ()
	      !<MAPF ,LIST
		     <FUNCTION ("AUX" E P O)
			  <COND (<EMPTY? .A> <MAPSTOP>)
				(<SET E <NTH .A 1>>
				 <SET A <REST .A>>)>
			  <COND (<TYPE? .E ATOM>
				 <COND (<OR <=? <SET P <SPNAME .E>>
						"CRLF">
					    <=? .P "CR">>
					<MAPRET '<CRLF>>)
				       (<EMPTY? .A>
					<ERROR INDICATOR-AT-END? .E>)
				       (ELSE
					<SET O <NTH .A 1>>
					<SET A <REST .A>>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "DESC">
						   <=? .P "D">
						   <=? .P "OBJ">
						   <=? .P "O">>
					       <MAPRET <FORM PRINTD .O>>)
					      (<OR <=? .P "A">
						   <=? .P "AN">>
					       <MAPRET <FORM PRINTA .O>>)
					      (<OR <=? .P "NUM">
						   <=? .P "N">>
					       <MAPRET <FORM PRINTN .O>>)
					      (<OR <=? .P "CHAR">
						   <=? .P "CHR">
						   <=? .P "C">>
					       <MAPRET <FORM PRINTC .O>>)
					      (ELSE
					       <MAPRET
						 <FORM PRINT
						       <FORM GETP .O .E>>>)>)>)
				(<TYPE? .E STRING ZSTRING>
				 <MAPRET <FORM PRINTI .E>>)
				(<TYPE? .E FORM LVAL GVAL>
				 <MAPRET <FORM PRINT .E>>)
				(ELSE <ERROR UNKNOWN-TYPE .E>)>>>>>

<ROUTINE PRINTA (O)
	 <COND (<FSET? .O ,VOWELBIT>
		<TELL "an " D .O>)
	       (T
		<TELL "a " D .O>)>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <FORM GVAL
					   <COND (<==? .X PRSA>
						  <PARSE
						    <STRING "V?"
							    <SPNAME .ATM>>>)
						 (ELSE .ATM)>>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O (<FORM EQUAL? <FORM GVAL .X> !.L>)>>>
		<SET L ()>>>

<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (<==? .X FSET?> <FORM OR !.O>)
				       (ELSE <FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM> .ATM)
				  (ELSE <FORM GVAL .ATM>)>>
		      !.O)>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<DEFMAC PROB ('BASE? "OPTIONAL" 'LOSER?)
	<COND (<ASSIGNED? LOSER?> <FORM ZPROB .BASE?>)
	      (ELSE <FORM G? .BASE? '<RANDOM 100>>)>>

<ROUTINE ZPROB
	 (BASE)
	 <COND (,LUCKY <G? .BASE <RANDOM 100>>)
	       (ELSE <G? .BASE <RANDOM 300>>)>>

<ROUTINE RANDOM-ELEMENT (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

<ROUTINE PICK-ONE (FROB
		   "AUX" (L <GET .FROB 0>) (CNT <GET .FROB 1>) RND MSG RFROB)
	 <SET L <- .L 1>>
	 <SET FROB <REST .FROB 2>>
	 <SET RFROB <REST .FROB <* .CNT 2>>>
	 <SET RND <RANDOM <- .L .CNT>>>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .L> <SET CNT 0>)>
	 <PUT .FROB 0 .CNT>
	 .MSG>

<DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>

<DEFMAC DISABLE ('INT) <FORM PUT .INT ,C-ENABLED? 0>>

<ROUTINE FLAMING? (OBJ)
	<AND <FSET? .OBJ ,FLAMEBIT> <FSET? .OBJ ,ONBIT>>>

<DEFMAC OPENABLE? ('OBJ)
	<FORM OR <FORM FSET? .OBJ ',DOORBIT>
	         <FORM FSET? .OBJ ',CONTBIT>>> 

<DEFMAC ABS ('NUM)
	<FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>)
	           (T .NUM)>>

;"former MAIN file"

<GLOBAL C-ELAPSED 0>

<GLOBAL PLAYER <>>

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>
 
<CONSTANT M-HANDLED 1>   
 
<CONSTANT M-NOT-HANDLED <>>   
 
<CONSTANT M-OBJECT <>>

<CONSTANT M-BEG 1>  
 
<CONSTANT M-END 6> 
 
<CONSTANT M-ENTER 2>
 
<CONSTANT M-LOOK 3> 
 
<CONSTANT M-FLASH 4>

<CONSTANT M-OBJDESC 5>

<GLOBAL DEBUG <>>    

<ROUTINE MAIN-LOOP ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP) 
  <REPEAT ()
     <SETG C-ELAPSED 7>
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
            <SET NUM
		 <COND (<0? <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>> .OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<0? .ICNT>
			       <SET OBJ <>>)
			      (T
			       <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T 1)>>
            <COND (<AND <NOT .OBJ> <1? .ICNT>>
		   <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<==? ,PRSA ,V?WALK>
		   <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<0? .NUM>
		   <COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<NOT ,LIT>
			  <TELL "It's too dark to see." CR>)
			 (T
			  <TELL "It's not clear what you're referring to." CR>
			  <SET V <>>)>)
		  (T
		   <SETG P-NOT-HERE 0>
		   <SETG P-MULT <>>
		   <COND (<G? .NUM 1>
			  <SETG P-MULT T>)>
		   <SET TMP <>>
		   <REPEAT ()
		      <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			     <COND (<G? ,P-NOT-HERE 0>
				    <TELL "The ">
				    <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
					   <TELL "other ">)>
				    <TELL "object">
				    <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
					   <TELL "s">)>
				    <TELL " that you mentioned ">
				    <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
					   <TELL "are">)
					  (T
					   <TELL "is">)>
				    <TELL "n't here." CR>)
				   (<NOT .TMP>
				    <TELL
				     "There's nothing here you can take." CR>)>
				    <RETURN>)
			    (T
			     <COND (.PTBL
				    <SET OBJ1 <GET ,P-PRSO .CNT>>)
				   (T
				    <SET OBJ1 <GET ,P-PRSI .CNT>>)>
			     <SETG PRSO <COND (.PTBL .OBJ1)
					      (T .OBJ)>>
			     <SETG PRSI <COND (.PTBL .OBJ)
					      (T .OBJ1)>>
			     <COND (<OR <G? .NUM 1>
				        <EQUAL?
					 <GET <GET ,P-ITBL ,P-NC1> 0> ,W?ALL>>
				    <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
					   <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
					   <AGAIN>)
					  (<AND <VERB? TAKE>
						,PRSI
						<EQUAL?
						 <GET <GET ,P-ITBL ,P-NC1> 0>
						 ,W?ALL>
						<NOT <IN? ,PRSO ,PRSI>>>
					   <AGAIN>)
					  (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
						<VERB? TAKE>
						<OR <AND <NOT <EQUAL?
							       <LOC .OBJ1>
							       ,WINNER
							       ,HERE>>
							 <NOT <FSET?
							       <LOC .OBJ1>
							       ,SURFACEBIT>>>
						    <NOT <OR <FSET?
							      .OBJ1
							      ,TAKEBIT>
							     <FSET?
							      .OBJ1
							      ,TRYTAKEBIT>>>>>
					   <AGAIN>)
					  (T
					   <COND (<EQUAL? .OBJ1 ,IT>
						  <PRINTD ,P-IT-OBJECT>)
						 (T
						  <PRINTD .OBJ1>)>
					   <TELL ": ">)>)>
			     <SET TMP T>
			     <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
			     <COND (<==? .V ,M-FATAL>
				    <RETURN>)>)>>)>
	    <COND (<NOT <==? .V ,M-FATAL>>
		   ;<COND (<==? <LOC ,WINNER> ,PRSO>
			  <SETG PRSO <>>)> ;"Retrofix 17"
		   <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	    <COND (<VERB? AGAIN ;WALK SAVE RESTORE SCORE VERSION ;WAIT>
		   T)
		  (T
		   <SETG L-PRSA ,PRSA>
		   <SETG L-PRSO ,PRSO>
		   <SETG L-PRSI ,PRSI>
		   <SETG PRSI <>>)> ;"attempted AGAIN patch"
	    <COND (<VERB? TELL BRIEF SUPER-BRIEF VERBOSE
			  SAVE RESTORE HELP VERSION SCORE SAY>
		   <SETG C-ELAPSED 0>)>
	    <SETG INTERNAL-MOVES <+ ,INTERNAL-MOVES ,C-ELAPSED>>
	    <COND (<==? .V ,M-FATAL>
		   <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (<EQUAL? ,GAME-FLAG 2>
	    <COND (<NOT <IN? ,CHRONOMETER ,ADVENTURER>>
		   <SETG MOVES 0>)
		  (T
		   <SETG MOVES ,INTERNAL-MOVES>)>)>
     <COND (,P-WON
	    <COND (<VERB? TELL BRIEF SUPER-BRIEF VERBOSE
			  HELP SAVE RESTORE VERSION SCORE SAY>
		   T)
		  (T
		   <SET V <CLOCKER>>)>)>>>

<GLOBAL L-PRSA <>>  
 
<GLOBAL L-PRSO <>>  
 
<GLOBAL L-PRSI <>>  

<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>



%<COND (<GASSIGNED? PREDGEN>

'<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	<COND (,DEBUG
	       <TELL "[Perform: ">
	       %<COND (<GASSIGNED? PREDGEN> '<TELL N .A>)
		      (T '<PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>)>
	       <COND (.O
		      <COND (<NOT <==? .A ,V?WALK>>
			     <TELL "/" D .O>)
			    (T <TELL "/" N .O>)>)>
	       <COND (.I <TELL "/" D .I>)>
	       <TELL "]" CR>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <NOT <==? .A ,V?WALK>>
		    <OR <EQUAL? ,IT .I .O>
			<EQUAL? ,NOT-HERE-OBJECT .I .O>>
		    <NOT <EQUAL? ,P-IT-LOC ,HERE>>>
	       <TELL "I don't see what you are referring to." CR>
	       <SETG P-WON <>> ;"to keep clock from running"
	       <RFATAL>)>
	<COND (<==? .A ,V?WALK> T)
	      (<==? .O ,IT> <SET O ,P-IT-OBJECT>)
	      (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <EQUAL? ,PRSI ,IT>> <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>
	       <SETG P-IT-LOC ,HERE>)>
	<SETG PRSI .I>
	<COND (<AND <NOT <VERB? WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>> ;"to keep clock from running"
	       .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND
		(<SET V <APPLY <GETP ,WINNER ,P?ACTION>>> .V)
		(<SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-BEG>> .V)
		(<SET V <APPLY <GET ,PREACTIONS .A>>> .V)
		(<AND .I <SET V <APPLY <GETP .I ,P?ACTION>>>> .V)
		(<AND .O
		      <NOT <==? .A ,V?WALK>>
		      <LOC .O>
		      <SET V <APPLY <GETP <LOC .O> ,P?CONTFCN>>>>
		 .V)
		(<AND .O
		      <NOT <==? .A ,V?WALK>>
		      <SET V <APPLY <GETP .O ,P?ACTION>>>>
		 .V)
		(<SET V <APPLY <GET ,ACTIONS .A>>> .V)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>)
       (T
	
'<PROG ()

<SETG DEBUG <>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT> (V) ANY)
	<COND (,DEBUG
	       <TELL "** PERFORM: PRSA = ">
	       <PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>
	       <COND (.O
		      <COND (<==? .A ,V?WALK>
			     <TELL " | DIR = " N .O>)
			    (T <TELL " | PRSO = " D .O>)>)>
	       <COND (.I <TELL " | PRSI = " D .I>)>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <NOT <==? .A ,V?WALK>>
		    <EQUAL? ,IT .I .O>
		    <NOT <EQUAL? ,P-IT-LOC ,HERE>>>
	       <TELL "I don't see what you are referring to." CR>
	       <RFATAL>)>
	<COND (<==? .A ,V?WALK> T)
	      (<==? .O ,IT> <SET O ,P-IT-OBJECT>)
	      (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>
	       <SETG P-IT-LOC ,HERE>)>
	<SETG PRSI .I>
	<COND (<AND <NOT <VERB? WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>> .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND (<SET V <DD-APPLY "Actor" ,WINNER
				      <GETP ,WINNER ,P?ACTION>>> .V)
		     (<SET V <D-APPLY "Room (M-BEG)"
				      <GETP <LOC ,WINNER> ,P?ACTION>
				      ,M-BEG>> .V)
		     (<SET V <D-APPLY "Preaction"
				      <GET ,PREACTIONS .A>>> .V)
		     (<AND .I <SET V <D-APPLY "PRSI"
					      <GETP .I ,P?ACTION>>>> .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <LOC .O>
			   <GETP <LOC .O> ,P?CONTFCN>
			   <SET V <DD-APPLY "Container" <LOC .O>
					   <GETP <LOC .O> ,P?CONTFCN>>>>
		      .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <SET V <D-APPLY "PRSO"
					   <GETP .O ,P?ACTION>>>>
		      .V)
		     (<SET V <D-APPLY <>
				      <GET ,ACTIONS .A>>> .V)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<DEFINE D-APPLY (STR FCN "OPTIONAL" FOO "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       <COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL CR "  Default ->" CR>)
			    (T <TELL CR "  " .STR " -> ">)>)>
	       <SET RES
		    <COND (<ASSIGNED? FOO>
			   <APPLY .FCN .FOO>)
			  (T <APPLY .FCN>)>>
	       <COND (<AND ,DEBUG .STR>
		      <COND (<==? .RES 2>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>

<ROUTINE DD-APPLY (STR OBJ FCN "OPTIONAL" (FOO <>))
	<COND (,DEBUG <TELL "[" D .OBJ "=]">)>
	<D-APPLY .STR .FCN .FOO>>
>)>

;"former CLOCK file"

<CONSTANT C-TABLELEN 180>

<GLOBAL C-TABLE <ITABLE NONE 180>>

<GLOBAL C-DEMONS 180>

<GLOBAL C-INTS 180>

<CONSTANT C-INTLEN 6>

<CONSTANT C-ENABLED? 0>

<CONSTANT C-TICK 1>

<CONSTANT C-RTN 2>

;<ROUTINE DEMON (RTN TICK "AUX" CINT) ;"not referenced, removed 2/27/85 by SEM"
	 #DECL ((RTN) ATOM (TICK) FIX (CINT) <PRIMTYPE VECTOR>)
	 <PUT <SET CINT <INT .RTN T>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE QUEUE (RTN TICK "AUX" CINT)
	 #DECL ((RTN) ATOM (TICK) FIX (CINT) <PRIMTYPE VECTOR>)
	 <PUT <SET CINT <INT .RTN>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE INT (RTN "OPTIONAL" (DEMON <>) E C INT)
	 #DECL ((RTN) ATOM (DEMON) <OR ATOM FALSE> (E C INT) <PRIMTYPE
							      VECTOR>)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			<AND .DEMON <SETG C-DEMONS <- ,C-DEMONS ,C-INTLEN>>>
			<SET INT <REST ,C-TABLE ,C-INTS>>
			<PUT .INT ,C-RTN .RTN>
			<RETURN .INT>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN> <RETURN .C>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<GLOBAL CLOCK-WAIT <>>

<ROUTINE CLOCKER ("AUX" C E TICK (FLG <>))
	 #DECL ((C E) <PRIMTYPE VECTOR> (TICK) FIX (FLG) <OR FALSE ATOM>)
	 <COND (,CLOCK-WAIT
		<SETG CLOCK-WAIT <>>
		<RFALSE>)>
	 <SET C <REST ,C-TABLE <COND (,P-WON ,C-INTS) (T ,C-DEMONS)>>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<COND (<AND <NOT <EQUAL? ,GAME-FLAG 2>>
				    <G? <SETG MOVES <+ ,MOVES 1>> 999>>
			       <SETG MOVES 0>)>
			<RETURN .FLG>)
		       (<NOT <0? <GET .C ,C-ENABLED?>>>
			<SET TICK <GET .C ,C-TICK>>
			<COND (<0? .TICK>)
			      (<AND <EQUAL? ,GAME-FLAG 2>
				    <==? .TICK -1>>
			       <COND (<APPLY <GET .C ,C-RTN>>
				      <SET FLG T>)>)
			      (T
			       <COND (<EQUAL? ,GAME-FLAG 2>
				      <PUT .C ,C-TICK
					   <SET TICK <- .TICK ,C-ELAPSED>>>)
				     (T
				      <PUT .C ,C-TICK <- .TICK 1>>)>
			       <COND (<NOT <G? .TICK 1>>
				      <COND (<EQUAL? ,GAME-FLAG 2>
					     <PUT .C ,C-TICK 0>)>
				      <COND (<APPLY <GET .C ,C-RTN>>
					     <SET FLG T>)>)>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>