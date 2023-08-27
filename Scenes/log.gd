extends Node2D

class_name Log

const LOG_SECTION_LENGTH = 64

@export var middle_section_length = 3

@onready var log_start_scene = preload("res://Scenes/log_start.tscn")
@onready var log_middle_scene = preload("res://Scenes/log_middle.tscn")
@onready var log_end_scene = preload("res://Scenes/log_end.tscn")

var speed 

func _ready():
	var log_start = log_start_scene.instantiate()
	log_start.scale = Vector2(4, 4)
	add_child(log_start)
	var log_start_x = -middle_section_length / 2 - LOG_SECTION_LENGTH / 2
	log_start.position.x = log_start_x
	
	for i in middle_section_length:
		var log_mid_section = log_middle_scene.instantiate()
		log_mid_section.scale = Vector2(4,4)
		add_child(log_mid_section)
		log_mid_section.position.x = log_start_x + (i + 1) * LOG_SECTION_LENGTH
	
	var log_end = log_end_scene.instantiate()
	log_end.scale = Vector2(4,4)
	add_child(log_end)
	var log_end_position = log_start_x + LOG_SECTION_LENGTH * middle_section_length + LOG_SECTION_LENGTH / 2
	log_end.position.x = log_end_position
