extends CharacterBody2D

@export var jump_force: int
@export var gravity: int
@export var move_speed: int
var direction: float

func apply_gravity(delta: float):
	velocity.y += gravity * delta
	
func get_input():
	direction = Input.get_axis("left", "right")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_force
		
	

func _physics_process(delta: float) -> void:
	get_input()
	apply_gravity(delta)
	velocity.x = direction * move_speed
	move_and_slide()
