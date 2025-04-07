extends Area2D
#signal for body entering this area

func _on_body_entered(body):
	await get_tree().create_timer(0.1).timeout
	if body is player && GlobalVar.player_attacking == false:
		body.handle_danger()
