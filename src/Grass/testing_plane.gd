@tool
extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	var t = get_surface_override_material(0)
	t.set_shader_parameter('displace', DisplacementBuffer.get_texture())
	set_surface_override_material(0,t)
