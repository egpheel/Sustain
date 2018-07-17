extends Control

signal tile_changed

var tile

func _on_GrassButton_button_down():
	tile = "grass"
	emit_signal("tile_changed", tile)


func _on_SandButton_button_down():
	tile = "sand"
	emit_signal("tile_changed", tile)


func _on_WaterButton_button_down():
	tile = "water"
	emit_signal("tile_changed", tile)


func _on_DirtButton_button_down():
	tile = "dirt"
	emit_signal("tile_changed", tile)