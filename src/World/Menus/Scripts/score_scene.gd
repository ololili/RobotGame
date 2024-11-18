extends Node2D


var score
var score_text
var timer = 0

func _ready():
	score = round(Globals.timer)
	score_text = zero_padder(str(score))
	$remaining_time.text = score_text
	$previous_score.text = zero_padder(str(Globals.previous_score))
	$new_score.text = score_text
	$new_total.text = zero_padder(str(Globals.total_score + score))

func _process(delta):
	timer += delta
	if timer > 1:
		if Input.is_action_just_pressed("left"):
			Globals.end_score(false)
			Globals.previous_score = score
		if Input.is_action_just_pressed("right"):
			Globals.end_score(true)
			Globals.total_score += score
			print(str(Globals.total_score))
			Globals.previous_score = 0

func zero_padder(text: String):
	if text.length() == 1:
		text = "\n00" + text
		return text
	if text.length() == 2:
		text = "\n0" + text
	else:
		text = "\n" + text
	return text
