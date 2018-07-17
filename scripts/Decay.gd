extends Node

var tilemap
var tileset
var map_node

func _ready():
	randomize()
	tilemap = $"../../TileMap"
	tileset = $"../../TileMap".tile_set
	map_node = $"../../../Map"
	$DecayTimer.start()

func _do_apply_decay():
	for t in tilemap.get_used_cells():
#		print(map_node.tile_types[tile_name(tile_index(t))])
		if map_node.tile_types[tile_name(tile_index(t))].tile_range != 0:
			_apply_decay(t)

func _apply_decay(t):
	var health_effect_applied = 0
	var tile_range = map_node.tile_types[tile_name(tile_index(t))].tile_range
	
	for x in range(t.x - tile_range, t.x + 1 + tile_range):
		for y in range(t.y - tile_range, t.y + 1 + tile_range):
			for tile in map_node.map:
				if tile.properties.x == x && tile.properties.y == y:
#					print(map_node.tile_types[tile_name(tile_index(t))].tiles_to_help)
					for ti in map_node.tile_types[tile_name(tile_index(t))].tiles_to_help:
#						print(tile_name(tile_index(Vector2(x, y))))
						if ti == tile_name(tile_index(Vector2(x, y))):
							var propagate = randi() % tile.properties.probability
#							print(propagate)
							if propagate == 0:
								health_effect_applied += tile.properties.help_others
#								print(health_effect_applied)
					for ti in map_node.tile_types[tile_name(tile_index(t))].tiles_to_decay:
						if ti == tile_name(tile_index(Vector2(x, y))):
							var propagate = randi() % tile.properties.probability
							if propagate == 0:
								health_effect_applied -= tile.properties.decay_others
	
#	for tile in map_node.map:
#		if tile.properties.x == t.x && tile.properties.y == t.y:
					tile.properties.health += health_effect_applied
					
					if tile.properties.health >= tile.properties.max_health:
						tilemap.set_cellv(Vector2(x, y), tile_index_by_name(tile.properties.evolve_state))
						map_node.remove_tile_from_map(Vector2(x, y))
						map_node.add_tile_to_map(Vector2(x, y), tileset.find_tile_by_name(tile.properties.evolve_state))
					if tile.properties.health <= tile.properties.min_health:
						tilemap.set_cellv(Vector2(x, y), tile_index_by_name(tile.properties.death_state))
						map_node.remove_tile_from_map(Vector2(x, y))
						map_node.add_tile_to_map(Vector2(x, y), tileset.find_tile_by_name(tile.properties.death_state))

func _on_DecayTimer_timeout():
	_do_apply_decay()

func tile_name(index):
	return tileset.tile_get_name(index)

func tile_index(pos):
	return tilemap.get_cellv(pos)
	
func tile_index_by_name(name):
	return tileset.find_tile_by_name(name)
