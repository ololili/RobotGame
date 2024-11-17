extends Area2D

signal button_pressed

@export var is_main_button: bool = false
@export var max_timer: float = 60.0

var sprite: Sprite2D
var is_down: bool = false

func _ready():
	sprite = $sprite_2d
	if is_main_button:
		Globals.timer = max_timer


func _process(delta):
	if is_main_button:
		handle_timing(delta)

func handle_timing(delta):
	if Globals.is_timing:
		Globals.timer -= delta
		if Globals.timer < 0:
			Globals.is_timing = false
			Globals.timer = max_timer
			is_down = false
			sprite.frame = 0


func _on_body_entered(body):
	if body.name == "robot" and not is_down:
		button_pressed.emit()
		is_down = true
		sprite.frame = 1
		if is_main_button:
			Globals.is_timing = true
			Globals.timer = max_timer
