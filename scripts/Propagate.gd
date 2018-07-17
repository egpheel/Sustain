extends Node

var _tile_index
var _propagates_to
var _tile_position

func propagate(tile_index, propagates_to, tile_position):
	_tile_index = tile_index
	_propagates_to = propagates_to
	_tile_position = tile_position
	
	$PropagateTimer.start()

func _do_propagation():
	var tilemap = $"../../TileMap"
	var tileset = $"../../TileMap".tile_set
	
	for x in range(_tile_position.x - 1, _tile_position.x + 2):
		for y in range(_tile_position.y - 1, _tile_position.y + 2):
			var neighbour_tile = tilemap.get_cellv(Vector2(x, y))
			if neighbour_tile != -1:
				match tileset.tile_get_name(neighbour_tile):
					_propagates_to:
						tilemap.set_cellv(Vector2(x, y), _tile_index)

func _on_PropagateTimer_timeout():
	_do_propagation()
