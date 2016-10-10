BEGIN ~SFAMROS~ // Initial dialog file

// New Dialog State (named "Introduction")
IF ~NumTimesTalkedTo(0)~ THEN
BEGIN Introduction
	// Dialog contents go in here
	SAY ~Greetings, my <LADYLORD>. I'm Amros, servant of Kelemvor.~
	
	// First transition
	IF ~ReputationGT([PC], 10)~ THEN
		// This is your first reply
		REPLY ~I'm <CHARNAME>. It's an honor to meet you.~
		GOTO IntroductionGood
		
	IF ~ReputationLT([PC], 11)~ THEN
		REPLY ~I'm <CHARNAME>. What are you doing here?~
		GOTO IntroductionNormal
		
	IF ~~ THEN
		REPLY ~Get off, paladin!~
		EXIT
		
END // End Introduction

IF ~~ THEN
BEGIN IntroductionGood
	SAY ~<CHARNAME>? The honor is mine. I heard something... about you. I think you need my assistance.~
    
    IF ~~ THEN
        REPLY ~I'd be happy to have you in my party.~
        DO ~SetGlobal("KickedOut", "LOCALS", 0)
            JoinParty()~
        EXIT
        
    IF ~~ THEN
        REPLY ~No, thanks.~
        EXIT
END

IF ~~ THEN
BEGIN IntroductionNormal
	SAY ~I have nothing to tell you.~
	IF ~~ THEN
		REPLY ~Nor I.~
		EXIT
END

IF ~NumTimesTalkedToGT(0) ReputationGT([PC], 15)~ THEN
BEGIN IntroductionLater
    SAY ~You're back. Are you ready to apologise?~
    
    IF ~~ THEN
        REPLY ~Yes, I'm sorry. Do you want to join my party?~
        DO ~SetGlobal("KickedOut", "LOCALS", 0)
            JoinParty()~
        EXIT
        
    IF ~~ THEN
        REPLY ~Bugger off.~
        EXIT

END

BEGIN ~SFAMROSP~

IF ~Global("KickedOut", "LOCALS", 0)~ THEN
BEGIN Kickout
    SAY ~Oh, you don't need me no more?~
    
    IF ~~ THEN
        REPLY ~No, I made a mistake. Please stay.~
        DO ~JoinParty()~
        EXIT
        
    IF ~~ THEN
        REPLY ~Yes, it's time to part ways.~
        GOTO KickoutFinal
    
END

IF ~~ THEN
BEGIN KickoutFinal
    SAY ~Very well. I'll travel back to the Friendly Arms Inn.~
    
    IF ~~ THEN
        DO ~SetGlobal("KickedOut", "LOCALS", 1)
            EscapeAreaMove("AR2300", 3326, 2528, 14)~
        EXIT

END

IF ~Global("KickedOut", "LOCALS", 1)~ THEN
BEGIN Rejoin
    SAY ~You want me back in the party?~
    
    IF ~~ THEN
        REPLY ~Yes, I need your services again.~
        DO ~SetGlobal("KickedOut", "LOCALS", 0)
            JoinParty()~
        EXIT
        
    IF ~~ THEN
        REPLY ~I don't think so.~
        EXIT
END
