
<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 #DECL ((ASK?) <OR ATOM <PRIMTYPE LIST>> (SCOR) FIX)
	 <V-SCORE>
	 <COND (.ASK?
		<SAY-SURE>
		<TELL "leave the story now?">
		<COND (<YES?>
		       <QUIT>)
		      (T
		       <TELL ,OKAY "the story continues..." CR>)>)
	       (T
		<QUIT>)>>