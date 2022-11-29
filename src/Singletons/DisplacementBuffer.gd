@tool
extends Node

var objects = {
	
}

var texture: Image
var previous_frame
# Called when the node enters the scene tree for the first time.
func _ready():
	texture = Image.create(1024, 1024, false, Image.FORMAT_RGBA8)
	texture.fill(Color(0.5, 0.0, 0.5, 1.0))

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var should_change = false
	for object in objects.keys():
		# keeps a reference to the node so we're able to constantly poll for positions
		print(objects[object].global_position)
	# do cool stuff to make a texture that moves and adds these objects to the game?
	if should_change:
		print('a')
	# go through every pixel and conver it to -1 to 1 and then bring towards 0
	
	
func add_object(object: Node):
	objects[object.name] = object
	print(objects)

func remove_object(object: Node):
	objects.erase(object.name)
	print(objects)
