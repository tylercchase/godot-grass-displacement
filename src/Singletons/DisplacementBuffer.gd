@tool
extends Node

var objects = {
	
}
var player
var texture: Image
var previous_frame

var size = 1024
# Called when the node enters the scene tree for the first time.
func _ready():
	texture = Image.create(size, size, false, Image.FORMAT_RGBA8)
	texture.fill(Color(0.5, 0.5, 0.0, 1.0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var should_change = false
	
	var things = []
	for object in objects.keys():
		# keeps a reference to the node so we're able to constantly poll for positions
		print(objects[object].ref.global_position)
		var relative = player.global_position - objects[object].ref.global_position
		things.push_back({"x": relative.y, "y": relative.y, "r": 3})
	# do cool stuff to make a texture that moves and adds these objects to the game?
	if should_change:
		print('a')
		# maybe store old texture and then make a new one pulling from coordinates above?
		texture.fill(Color(0.5, 0.5, 0.0, 1.0))
		for thing in things:
			print(thing)
			draw_circle(thing.x,thing.y,thing.r)
	draw_circle(0,0,20) # player draw constant for now
	# go through every pixel and conver it to -1 to 1 and then bring towards 0
	
func draw_circle(_x,_y,radius):
	# center of screen should be 0,0
	var center = 512
	var point = Vector2(512 + _x, 512 + _y)
	for x in range(point.x - radius, point.x + radius):
		for y in range(point.y - radius, point.y + radius):
			if Vector2(x,y).distance_to(point):
				texture.set_pixel(x,y,Color.BLUE)
			pass
#	print('drawing circle', x,y,radius)
func add_player(object: Node):
	player = object
func add_object(object: Node, r):
	objects[object.name] = { "ref": object, "r": r}
	print(objects)

func remove_object(object: Node):
	objects.erase(object.name)
	print(objects)

func get_texture() -> ImageTexture:
	return ImageTexture.create_from_image(texture)
