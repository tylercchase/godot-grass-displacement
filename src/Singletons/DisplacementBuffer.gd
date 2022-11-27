extends Node

var objects = {
	
}

var texture
var previous_frame
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for object in objects.keys():
		# keeps a reference to the node so we're able to constantly poll for positions
		print(objects[object].global_position)
	# do cool stuff to make a texture that moves and adds these objects to the game?
	
func add_object(object: Node):
	objects[object.name] = object
	print(objects)

func remove_object(object: Node):
	objects.erase(object.name)
	print(objects)
