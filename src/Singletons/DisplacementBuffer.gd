extends Node

var objects = {
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# do cool stuff to make a texture that moves and adds these objects to the game?
	
	pass
	
func add_object(name: String, pos: Vector3, size=1):
	print(name)
	print(pos)
	objects[name] = {"position": pos, "size": size}

