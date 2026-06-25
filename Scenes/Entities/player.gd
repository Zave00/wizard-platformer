extends CharacterBody2D

@export var jump_force: int = 500
@export var gravity: int = 2000
@export var move_speed: int = 300

var has_air_step: bool = false
var jump_count: int = 0
var direction: float

func apply_gravity(delta: float):
	velocity.y += gravity * delta
	
func get_input():
	direction = Input.get_axis("left", "right")
	if Input.is_action_just_pressed("jump"):
		if has_air_step == true:
			if jump_count == 0:
				if is_on_floor():
					velocity.y -= jump_force
					jump_count = 1
				else:
					velocity.y = 0
					velocity.y -= jump_force
					jump_count = 2
			elif jump_count == 1:
				velocity.y = 0
				velocity.y -= jump_force
				jump_count = 2
		else:
			if is_on_floor():
				velocity.y -= jump_force
		

func _physics_process(delta: float) -> void:
	get_input()
	apply_gravity(delta)
	velocity.x = direction * move_speed
	if is_on_floor():
		jump_count = 0
	move_and_slide()
