extends Node2D

class_name HighwayLane

signal player_hit_by_vehicle

@onready var vehicle_scene: PackedScene = preload("res://Scenes/vehicle.tscn")


#1 for left to right, -1 for right to left
@export var direction = 1
@export var vehicle_texture: Texture2D
@export var vehicle_count = 3
@export var distance_between_vehicles = 100
@export var speed = 200
@export var movement_x_limit = 480

var vehicles = []

func _ready():
	var start_point_x = movement_x_limit * direction
	
	for i in vehicle_count:
		var vehicle = vehicle_scene.instantiate() as Vehicle
		vehicle.position = Vector2(-movement_x_limit + distance_between_vehicles * i * - direction, 0)
		vehicle.scale = Vector2(4,4)
		vehicle.area_entered.connect(on_player_enter_vehicle)
		add_child(vehicle)
		vehicle.set_texture(vehicle_texture)
		vehicles.append(vehicle)

func _process(delta):
	for vehicle in vehicles:
		var new_position_x = speed * delta * direction + vehicle.position.x
		if abs(new_position_x - movement_x_limit) < 10:
			vehicle.position.x = -movement_x_limit
		else: 
			vehicle.position.x = new_position_x

func on_player_enter_vehicle(area: Area2D):
	if area is Player:
		player_hit_by_vehicle.emit()
