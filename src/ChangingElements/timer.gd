extends Label


func _process(_delta):
	var time: String = str(roundf(Globals.timer))
	var num: int = time.length()
	if num == 1:
		time = "00" + time
	if num == 2:
		time = "0" + time
	text = time
