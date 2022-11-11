extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var grass : GPUParticles3D = $Grass
	var coll = $abc.get_texture()

	grass.process_material.set_shader_parameter('displace', coll)

#func _process(_delta):
#	if Input.is_action_just_pressed("jump"):
#		var img = $abc.get_texture().get_data()
#		img.flip_y()
#		img.save_png("screenshot.png")
