extends Node

@onready var game_state_manager = $"../GameStateManager"

func _ready():
	var highway_lanes = get_children() as Array[HighwayLane]
	
	for lane in highway_lanes:
		lane.player_hit_by_vehicle.connect(on_player_hit_by_vehicle)
		

func on_player_hit_by_vehicle():
	game_state_manager.kill_player()
