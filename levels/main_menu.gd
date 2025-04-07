extends Node2D
var password = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_pressed():
	if(GlobalVar.show_text == false):
		get_tree().change_scene_to_file("res://levels/opening.tscn")
	elif(GlobalVar.show_text == true):
		get_tree().change_scene_to_file("res://levels/intro_note.tscn")
	

func _on_line_edit_text_changed(new_text):
	print("Text: " + $LineEdit.text)

func _input(event):
	if(Input.is_key_pressed(KEY_ENTER)):
		password = $LineEdit.text
		if(password == "pookiewookie"):
			GlobalVar.show_text = true
			$Label.text = "Success! Have fun, Logan :)"
		else:
			GlobalVar.show_text = false
			$Label.text = "Click Start!"
