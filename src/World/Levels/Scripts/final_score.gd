extends Label


func _process(_delta):
	text = pad_zeros(Globals.total_score)

func pad_zeros(num):
	var t = str(num)
	if t.length() == 1:
		t = "00" + t
	elif t.length() == 2:
		t = "0" + t
	return t
