@tool
extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Grass.process_material.set_shader_parameter('displace', DisplacementBuffer.get_texture())
	
func _process(_delta):
	$Grass.process_material.set_shader_parameter('displace', DisplacementBuffer.get_texture())
	
