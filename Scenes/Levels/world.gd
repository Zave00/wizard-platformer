extends Node2D


func _ready() -> void:
	$AirStep.body_entered.connect(air_step_collected)
	
	
func air_step_collected(_body: Node2D) -> void:
	$Player.has_air_step = true
	$AirStep.queue_free()
	
