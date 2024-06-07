extends CharacterBody2D
@onready var area_2d = %Area2D


func _on_body_entered(body):
	if (body.name == area_2d):
		print("yay")
