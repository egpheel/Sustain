extends Node

var tile_types = {
	"grass" : {
		"health" : 100,
		"decay_others" : 6,
		"help_others" : 6,
		"tiles_to_decay": [],
		"tiles_to_help": [ "dirt", "grass" ],
		"probability" : 5, # 100 / this value
		"tile_range" : 1,
		"max_health": 150,
		"min_health": 0,
		"death_state": "dirt",
		"evolve_state": "forest"
	},
	"forest" : {
		"health" : 100,
		"decay_others" : 8,
		"help_others" : 8,
		"tiles_to_decay": [],
		"tiles_to_help": [ "grass", "forest" ],
		"probability" : 5, # 100 / this value
		"tile_range" : 1,
		"max_health": 110,
		"min_health": 0,
		"death_state": "dying_forest3", # grass or dying_forest3?
		"evolve_state": "forest2"
	},
	"forest2" : {
		"health" : 100,
		"decay_others" : 8,
		"help_others" : 8,
		"tiles_to_decay": [],
		"tiles_to_help": [ "forest", "forest2" ],
		"probability" : 5, # 100 / this value
		"tile_range" : 1,
		"max_health": 120,
		"min_health": 0,
		"death_state": "dying_forest3",
		"evolve_state": "forest3"
	},
	"forest3" : {
		"health" : 100,
		"decay_others" : 8,
		"help_others" : 8,
		"tiles_to_decay": [],
		"tiles_to_help": [ "forest2", "forest3" ],
		"probability" : 5, # 100 / this value
		"tile_range" : 1,
		"max_health": 130,
		"min_health": 0,
		"death_state": "dying_forest2",
		"evolve_state": "forest4"
	},
	"forest4" : {
		"health" : 100,
		"decay_others" : 8,
		"help_others" : 8,
		"tiles_to_decay": [],
		"tiles_to_help": [ "forest3", "forest4" ],
		"probability" : 5, # 100 / this value
		"tile_range" : 1,
		"max_health": 140,
		"min_health": 0,
		"death_state": "dying_forest2",
		"evolve_state": "forest5"
	},
	"forest5" : {
		"health" : 100,
		"decay_others" : 8,
		"help_others" : 8,
		"tiles_to_decay": [],
		"tiles_to_help": [ "forest4", "forest5" ],
		"probability" : 5, # 100 / this value
		"tile_range" : 1,
		"max_health": 150,
		"min_health": 0,
		"death_state": "dying_forest",
		"evolve_state": "forest6"
	},
	"forest6" : {
		"health" : 100,
		"decay_others" : 8,
		"help_others" : 8,
		"tiles_to_decay": [],
		"tiles_to_help": [ "forest5", "forest6" ],
		"probability" : 5, # 100 / this value
		"tile_range" : 1,
		"max_health": 160,
		"min_health": 0,
		"death_state": "dying_forest",
		"evolve_state": "forest6"
	},
	"dying_forest" : {
		"health" : 200,
		"decay_others" : 8,
		"help_others" : 8,
		"tiles_to_decay": [],
		"tiles_to_help": [ "dying_forest" ],
		"probability" : 5, # 100 / this value
		"tile_range" : 1,
		"max_health": 250,
		"min_health": 0,
		"death_state": "dying_forest2",
		"evolve_state": "dying_forest2"
	},
	"dying_forest2" : {
		"health" : 200,
		"decay_others" : 8,
		"help_others" : 8,
		"tiles_to_decay": [],
		"tiles_to_help": [ "dying_forest2" ],
		"probability" : 5, # 100 / this value
		"tile_range" : 1,
		"max_health": 250,
		"min_health": 0,
		"death_state": "dying_forest3",
		"evolve_state": "dying_forest3"
	},
	"dying_forest3" : {
		"health" : 200,
		"decay_others" : 8,
		"help_others" : 8,
		"tiles_to_decay": [],
		"tiles_to_help": [ "dying_forest3" ],
		"probability" : 5, # 100 / this value
		"tile_range" : 1,
		"max_health": 250,
		"min_health": 0,
		"death_state": "sand2",
		"evolve_state": "grass"
	},
	"dirt" : {
		"health" : 100,
		"decay_others" : 5,
		"help_others" : 5,
		"tiles_to_decay": [],
		"tiles_to_help": [ "dirt", "sand2" ],
		"probability" : 5,
		"tile_range" : 1,
		"max_health": 150,
		"min_health": 0,
		"death_state": "sand2",
		"evolve_state": "grass"
	},
	"sand" : {
		"health" : 100,
		"decay_others" : 15,
		"help_others" : 8,
		"tiles_to_decay": [ "dirt", "grass", "forest", "forest2", "forest3", "forest4", "forest5", "forest6" ],
		"tiles_to_help": [],
		"probability" : 5,
		"tile_range" : 1,
		"max_health": 150,
		"min_health": 0,
		"death_state": "sand",
		"evolve_state": "sand2"
	},
	"sand2" : {
		"health" : 100,
		"decay_others" : 8,
		"help_others" : 8,
		"tiles_to_decay": [],
		"tiles_to_help": [ ],
		"probability" : 5,
		"tile_range" : 1,
		"max_health": 150,
		"min_health": 0,
		"death_state": "sand",
		"evolve_state": "dirt"
	},
	"water" : {
		"health" : 100,
		"decay_others" : 0,
		"help_others" : 20,
		"tiles_to_decay": [],
		"tiles_to_help": [ "dirt", "sand", "sand2" ],
		"probability" : 750,
		"tile_range" : 2,
		"max_health": 150,
		"min_health": 0,
		"death_state": "water",
		"evolve_state": "water"
	}
}