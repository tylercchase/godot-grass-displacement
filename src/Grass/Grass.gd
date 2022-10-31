extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var grass : GPUParticles3D = $Grass
	var coll = $abc.get_texture()

	grass.process_material.set_shader_parameter('displace', coll)


