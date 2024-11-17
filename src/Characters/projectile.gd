extends CharacterBody2D

var move_direction: Vector2
var speed: float
var animation_player: AnimationPlayer


func _ready():
	animation_player = $animation_player
	animation_player.play("standard")
	animation_player.speed_scale = 5
	

func start(direction: Vector2, _speed: float):
	move_direction = direction
	speed = _speed
	

func _physics_process(delta):
	velocity.x = move_direction.x * speed
	velocity.y = move_direction.y * speed
	var collision = move_and_collide(velocity * delta) as KinematicCollision2D
	if collision:
		var collider = collision.get_collider() as Node
		if collider.name == "barrier":
			collider.break_door()
		queue_free()
