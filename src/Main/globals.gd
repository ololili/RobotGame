extends Node

var energy: float = 100.0
var max_timer: float
var timer: float
var score: int = 0

var is_timing: bool = false

func _process(delta):
	if is_timing:
		timer -= delta
		if timer < 0:
			stop_timer()


func start_timer():
	timer = max_timer
	is_timing = true

func stop_timer():
	timer = max_timer
	is_timing = false
