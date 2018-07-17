extends Node

var tilemap
var tileset
var map_node
var tile_types

func _ready():
	randomize()
	tilemap = $"../../TileMap"
	tileset = $"../../TileMap".tile_set
	map_node = $"../../../Map"
	tile_types = $"../TileTypes".tile_types
	$AutoPropagateTimer.start()

func _do_auto_propagation():
	for t in tilemap.get_used_cells():
#		if tile_name(tile_index(t)) == "grass":
#			_auto_propagate(t, "grass", "dirt", true)
#		if tile_name(tile_index(t)) == "water":
#			_auto_propagate(t, "dirt", "sand", true)
#		if tile_name(tile_index(t)) == "dirt":
#			var can_propagate = false
#			for x in range(t.x - map_node.tile_types["dirt"].range, t.x + 1 + map_node.tile_types["dirt"].range):
#				for y in range(t.y - map_node.tile_types["dirt"].range, t.y + 1 + map_node.tile_types["dirt"].range):
#					if tile_index(Vector2(x, y)) != -1 && tile_name(tile_index(Vector2(x, y))) == "water":
#						can_propagate = true
#			_auto_propagate(t, "dirt", "sand", can_propagate)
		if tile_name(tile_index(t)) == "water":
			var probability
			for tile in map_node.map:
				if tile.properties.x == t.x && tile.properties.y == t.y:
					probability = tile.properties.probability
			_auto_propagate(t, "water", null, true, 1, probability + 350) # temporary value (150) to lower probability of propagation

func _auto_propagate(t, tile_to_propagate, neighbour, can_propagate, propagation_range, probability):
	for x in range(t.x - propagation_range, t.x + 1 + propagation_range):
		for y in range(t.y - propagation_range, t.y + 1 + propagation_range):
#			var propagate = randi() % map_node.tile_types[tile_to_propagate].probability
			var propagate = randi() % probability
			if propagate == 0:
				var neighbour_tile = tile_index(Vector2(x, y))
				if neighbour != null:
					if neighbour_tile != -1 && tile_name(neighbour_tile) == neighbour && can_propagate:
						tilemap.set_cellv(Vector2(x, y), tile_index_by_name(tile_to_propagate))
						map_node.remove_tile_from_map(Vector2(x, y))
						map_node.add_tile_to_map(Vector2(x, y), tileset.find_tile_by_name(tile_to_propagate), probability)
						print(propagate, " in ", probability)
				else:
					if neighbour_tile != -1:
						tilemap.set_cellv(Vector2(x, y), tile_index_by_name(tile_to_propagate))
						map_node.remove_tile_from_map(Vector2(x, y))
						map_node.add_tile_to_map(Vector2(x, y), tileset.find_tile_by_name(tile_to_propagate), probability)
						print(propagate, " in ", probability)

func _on_AutoPropagateTimer_timeout():
	_do_auto_propagation()

func tile_name(index):
	return tileset.tile_get_name(index)

func tile_index(pos):
	return tilemap.get_cellv(pos)
	
func tile_index_by_name(name):
	return tileset.find_tile_by_name(name)