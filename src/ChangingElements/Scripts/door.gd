extends StaticBody2D

@export var is_main_door: bool = false

var is_open: bool = false
var sprite: Sprite2D
var collision: CollisionShape2D

func _ready():
	collision = $collision_shape_2d
	sprite = $sprite_2d

func _process(_delta):
	
	if is_main_door and Globals.is_timing:
		open_door()
	if is_main_door and not Globals.is_timing:
		close_door()

func close_door():
	if is_open:
		is_open = false
		sprite.frame = 0
		collision.disabled = false


func open_door():
	if not is_open:
		is_open = true
		sprite.frame = 1
		collision.disabled = true


func _on_button_button_pressed():
	open_door.call_deferred()
