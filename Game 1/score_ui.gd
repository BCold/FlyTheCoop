extends Node

func update_score() -> void:
	#print("Scored")
	Globals.score += 1
	
	if Globals.score > Globals.high_score:
		Globals.high_score = Globals.score
	
