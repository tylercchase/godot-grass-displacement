extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready():
	var coll = get_texture()

#	$Control/ColorRect.material.set_shader_parameter('self_reference', coll)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
