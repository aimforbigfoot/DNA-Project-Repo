extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_end"):
		print(":hello")
		$Control/Popup.visible = true
		$Control/Popup.popup(Rect2(100,100,100,100))
