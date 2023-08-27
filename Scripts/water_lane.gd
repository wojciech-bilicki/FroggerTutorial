extends Node2D

class_name WaterLane

const HALF_LOG_LENGTH = 32

@export var logs_length = [4,4,4]
@export var distance_between_logs = 180
@export var speed = 200
@export var movement_x_limit = 720
@export var movement_direction = 1

@onready var log_scene = preload("res://Scenes/log.tscn")

var logs: Array[Log] = []

func _ready():
	var index = 0
	var start_position_x = -movement_x_limit + logs_length[0] * HALF_LOG_LENGTH * -movement_direction
	
	for log_length in logs_length:
		var log = log_scene.instantiate() as Log
		log.middle_section_length = log_length - 2
		add_child(log)
		
		var previous_log_position = -movement_x_limit if index == 0 else logs[index - 1].position.x
		log.position.x = (log_length * HALF_LOG_LENGTH + distance_between_logs) * -movement_direction + previous_log_position
		index += 1
		logs.append(log)
		
func _process(delta):
	for log in logs: 
		var new_position_x = speed * delta * movement_direction + log.position.x
		if abs(new_position_x - movement_x_limit) < 10:
			log.position.x = -movement_x_limit
		else:
			log.position.x = new_position_x
