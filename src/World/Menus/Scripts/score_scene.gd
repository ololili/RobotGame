extends Node2D

func _ready():
	$remaining_time.text = zero_padder(str(round(Globals.timer)))
	$previous_score.text = zero_padder(str(Globals.score))
	var new_score = round(Globals.timer) + Globals.score
	$new_score.text = zero_padder(str(new_score))
	Globals.score = new_score

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		Globals.end_score()

func zero_padder(text: String):
	if text.length() == 1:
		text = "\n00" + text
		return text
	if text.length() == 2:
		text = "\n0" + text
	else:
		text = "\n" + text
	return text
