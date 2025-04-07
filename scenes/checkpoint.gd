extends Area2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_body_entered(body):
	if body is player:
		body.checkpointPos = global_position
