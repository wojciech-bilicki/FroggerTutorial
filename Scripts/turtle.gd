extends Area2D

class_name Turtle

@onready var sprite_2d = $Sprite2D

func set_sprite_rotation_degrees(degrees):
	sprite_2d.rotation_degrees = degrees
