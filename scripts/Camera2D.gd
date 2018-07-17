extends Camera2D

var drag_origin

func _process(delta):
	if Input.is_action_just_pressed("mouse_middle_click"):
		drag_origin = get_global_mouse_position()
	if Input.is_action_pressed("mouse_middle_click"):
		position -= get_global_mouse_position() - drag_origin
