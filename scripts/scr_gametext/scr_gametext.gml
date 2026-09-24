/// @param text_id
function scr_gametext(_text_id)
{

	switch(_text_id){
	
	// ------------------------- Home ------------------------- //
		// -------------------- Bedroom -------------------- //
		case "intr_desk_home_bed":
			scr_text("* It's your desk.")
			scr_text("> It's my desk.", "Player")
			break;
		
		#region NPC_test
		case "NPC 1":
			scr_text("> I am NPC 1.", "NPC");
			scr_text("> I am the original NPC.", "NPC");
			scr_text("> The rest are posers.", "NPC");
			break;
			
		case "NPC 2":
			scr_text("> I am NPC 2.", "NPC");
			scr_text("> I came second. And for good reason, too.", "NPC");
			scr_text("> Did you know PAC-MAN's original name was going to be PUC-MAN?", "NPC");
				scr_option("Are you autistic?", "NPC 2 Autism")
				scr_option("Ok, cool", "NPC 2 Dismiss")
				scr_option("Go on.", "NPC 2 Elaborate")
			break;
			case "NPC 2 Autism":
				scr_text("> long text test long text test long text test long text test long text test long text test long text test long text test long text test ", "NPC")
				break;
			case "NPC 2 Dismiss":
				scr_text("> Thanks for listening.", "NPC")
				break;
			case "NPC 2 Elaborate":
				scr_text("> I know where he hides the bodies.", "NPC")
					scr_option("What?", "NPC 2 Bodies")
				break;
				case "NPC 2 Bodies":
					scr_text("> See ya!", "NPC")
					break;
		
		case "NPC 3":
			scr_text("> I am NPC 3.", "NPC");
			scr_text("> What is NPC 2 talking about?", "NPC");
			scr_text("> He's a really weird one, y'know?", "NPC");
			break;
			
		case "NPC 4":
			scr_text("> I am NPC 1.", "NPC");
			scr_text("> I am the original NPC.", "NPC");
			scr_text("> The other one is lying.", "NPC");
				scr_option("No, you are.", "NPC 4 Disagree")
				scr_option("I noticed.", "NPC 4 Agree")
			break;
			case "NPC 4 Disagree":
				scr_text("> WHAT!?", "NPC")
				scr_text("> You DARE to call me a poser??", "NPC")
				scr_text("> LEAVE my sight!", "NPC")
				break;
			case "NPC 4 Agree":
				scr_text("> Ah, finally.", "NPC")
				scr_text("> Someone with a FUNCTIONAL cervix.", "NPC")
					scr_option("Thank you.", "NPC 4 Thanks")
					scr_option("You mean cortex?", "NPC 4 Disagree")
				break;
				case "NPC 4 Thanks":
					scr_text("Thanks!", "Player Emotive")
					scr_text("You are very welcome.", "NPC")
					break;
		#endregion
		
	}

}