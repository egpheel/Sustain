extends Node2D

var tileset
var tile
var map = []
onready var tile_types = $Functionality/TileTypes.tile_types

func _ready():
	tileset = $TileMap.tile_set
	tile = tile_index_by_name("water")
	scan_tile_map()

func _unhandled_input(event):
	if event.is_action_pressed("mouse_left_click"):
		create_tile(get_global_mouse_position())
	if event.is_action_pressed("mouse_right_click"):
		remove_tile(get_global_mouse_position())

func _process(delta):
	pass

func _on_UI_tile_changed(new_tile):
	tile = tileset.find_tile_by_name(new_tile)

func create_tile(mouse_pos):
	$TileMap.set_cellv($TileMap.world_to_map(mouse_pos), tile)
	add_tile_to_map($TileMap.world_to_map(mouse_pos), tile)

func remove_tile(mouse_pos):
	$TileMap.set_cellv($TileMap.world_to_map(mouse_pos), -1)
	remove_tile_from_map($TileMap.world_to_map(mouse_pos))

func scan_tile_map():
	for t in $TileMap.get_used_cells():
		add_tile_to_map(t, $TileMap.get_cellv(t))

func add_tile_to_map(pos, tile_to_add, probability = tile_types[tileset.tile_get_name(tile_to_add)].probability):
	var this_tile = {}
	this_tile.properties = {
		"name": tileset.tile_get_name(tile_to_add),
		"health": tile_types[tileset.tile_get_name(tile_to_add)].health,
		"decay_others": tile_types[tileset.tile_get_name(tile_to_add)].decay_others,
		"help_others": tile_types[tileset.tile_get_name(tile_to_add)].help_others,
		"tiles_to_decay": tile_types[tileset.tile_get_name(tile_to_add)].tiles_to_decay,
		"tiles_to_help": tile_types[tileset.tile_get_name(tile_to_add)].tiles_to_help,
		"probability": probability,
		"tile_range": tile_types[tileset.tile_get_name(tile_to_add)].tile_range,
		"max_health": tile_types[tileset.tile_get_name(tile_to_add)].max_health,
		"min_health": tile_types[tileset.tile_get_name(tile_to_add)].min_health,
		"death_state": tile_types[tileset.tile_get_name(tile_to_add)].death_state,
		"evolve_state": tile_types[tileset.tile_get_name(tile_to_add)].evolve_state,
		"x": pos.x,
		"y": pos.y
	}
	# check if any tile exists in the same coordinates
	remove_tile_from_map(pos)
	
	map.append(this_tile)
#	print("added: ", map[map.size() - 1], " - total: ", map.size())

func remove_tile_from_map(pos):
	var i = 0
	for t in map:
		if t.properties.x == pos.x && t.properties.y == pos.y:
#			print("removed: ", map[i], " - total: ", map.size())
			map.remove(i)
		i = i + 1
		
func tile_index_by_name(name):
	return tileset.find_tile_by_name(name)