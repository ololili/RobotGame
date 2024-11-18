extends Node

signal timer_started
signal timer_ended
signal score_ended(next_level: bool)
signal level_ended

var energy: float = 100.0
var recharge_rate: float
var max_timer: float
var timer: float
var total_score: int = 0
var previous_score: int = 0
var is_charging: bool

var is_timing: bool = false


func _process(delta):
	if is_timing:
		timer -= delta
		if timer < 0:
			stop_timer()
	else:
		is_charging = true
	if is_charging and energy < 100.0:
		energy += recharge_rate * delta

func entered_charge_station():
	is_charging = true

func left_charge_station():
	is_charging = false

func start_timer():
	timer_started.emit()
	is_charging = false
	timer = max_timer
	is_timing = true

func stop_timer():
	timer_ended.emit()
	timer = max_timer
	is_timing = false

func end_level():
	is_timing = false
	level_ended.emit()

func end_score(next_level: bool):
	score_ended.emit(next_level)
