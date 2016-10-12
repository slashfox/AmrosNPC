BEGIN ~SFAMROS~

IF ~NumTimesTalkedTo(0)~ THEN
BEGIN Introduction
	SAY @1000
	
	IF ~Class([PC], "PALADIN")~ THEN
		REPLY @1001
		GOTO IntroductionPaladin
		
	IF ~ReputationGT([PC], 11)~ THEN
		REPLY @1005
		GOTO IntroductionGoodRep
		
	IF ~~ THEN
		REPLY @1007
		GOTO IntroductionLowRep
		
	IF ~~ THEN
		REPLY @1010
		EXIT
		
END

IF ~~ THEN
BEGIN IntroductionPaladin
	SAY @1002
	
	IF ~~ THEN
        REPLY @1003
        DO ~SetGlobal("KickedOut", "LOCALS", 0)
            JoinParty()~
        EXIT
        
    IF ~~ THEN
        REPLY @1004
        EXIT

END

IF ~~ THEN
BEGIN IntroductionGoodRep
	SAY @1006
    
    IF ~~ THEN
        REPLY @1003
        DO ~SetGlobal("KickedOut", "LOCALS", 0)
            JoinParty()~
        EXIT
        
    IF ~~ THEN
        REPLY @1004
        EXIT
END

IF ~~ THEN
BEGIN IntroductionLowRep
	SAY @1008
	IF ~~ THEN
		REPLY @1009
		EXIT
END

IF ~NumTimesTalkedToGT(0) ReputationGT([PC], 15)~ THEN
BEGIN IntroductionLater
    SAY @1011
    
    IF ~~ THEN
        REPLY @1012
        DO ~SetGlobal("KickedOut", "LOCALS", 0)
            JoinParty()~
        EXIT
        
    IF ~~ THEN
        REPLY @1013
        EXIT

END


BEGIN ~SFAMROSP~

IF ~Global("KickedOut", "LOCALS", 0)~ THEN
BEGIN Kickout
    SAY @1014
    
    IF ~~ THEN
        REPLY @1015
        DO ~JoinParty()~
        EXIT
        
    IF ~~ THEN
        REPLY @1016
        GOTO KickoutFinal
    
END

IF ~~ THEN
BEGIN KickoutFinal
    SAY @1017
    
    IF ~~ THEN
        DO ~SetGlobal("KickedOut", "LOCALS", 1)
            EscapeAreaMove("AR2300", 3326, 2528, 14)~
        EXIT

END

IF ~Global("KickedOut", "LOCALS", 1)~ THEN
BEGIN Rejoin
    SAY @1018
    
    IF ~~ THEN
        REPLY @1019
        DO ~SetGlobal("KickedOut", "LOCALS", 0)
            JoinParty()~
        EXIT
        
    IF ~~ THEN
        REPLY @1020
        EXIT
END
