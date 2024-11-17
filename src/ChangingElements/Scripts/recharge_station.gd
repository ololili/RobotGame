extends Area2D


var is_active: bool = false

func _process(_delta):
	if is_active != Globals.is_timing:
		is_active = Globals.is_timing
		if is_active:
			$animation_player.play("active")
		else:
			$animation_player.play("inactive")

func _on_body_entered(body):
	if body.name == "robot":
		print("should start charging")
		Globals.entered_charge_station()


func _on_body_exited(body):
	if body.name == "robot":
		print("should stop charging")
		Globals.left_charge_station()
