extends TextureProgressBar

@export var recharge_rate: float = 10.0

func _process(delta):
	value = Globals.energy
	if not Globals.is_timing and value < max_value:
		Globals.energy += delta * recharge_rate
