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
func _process(_delta):
	var should_change = false
	
	var things = []
	for object in objects.keys():
		# keeps a reference to the node so we're able to constantly poll for positions
		var relative = player.global_position - objects[object].ref.global_position
		things.push_back({"x": relative.x, "y": relative.z, "r": 3})
	# do cool stuff to make a texture that moves and adds these objects to the game?
	for thing in things:
#		print(thing.x,thing.y,thing.r)
		draw_circle(thing.x * 30,thing.y * 30,25)
	draw_circle(0,0,20) # player draw constant for now, should probably check if player is on ground
	# should really move the canvas while doing this
	
	# go through every pixel and conver it to -1 to 1 and then bring towards 0
	
func draw_circle(_x,_y,radius):
	# center of screen should be 0,0
	var point = Vector2(512 + _x, 512 + _y)
	for x in range(clamp(point.x - radius,0,1024), clamp(point.x + radius, 0,1024)):
		for y in range(clamp(point.y - radius,0,1024), clamp(point.y + radius,0,1024)):
			if Vector2(x,y).distance_to(point) <= radius:
				texture.set_pixel(x,y,Color.BLUE)
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
