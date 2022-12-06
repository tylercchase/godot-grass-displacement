extends Node

var objects = {
	
}
var player: CharacterBody3D
var texture: Image
var previous_frame


var size = 1024

var total_difference = Vector2()
var timer = Timer.new()
var player_last_pos = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	texture = Image.create(size, size, false, Image.FORMAT_RGBA8)
	texture.fill(Color(0.5, 0.5, 0.0, 1.0))
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	var scale_factor = 20
	
	texture.fill(Color(0.5, 0.5, 0.0, 1.0))
	
	var things = []
	for object in objects.keys():
		var relative = player.global_position - objects[object].ref.global_position
		things.push_back({"x": relative.x, "y": relative.z, "r": objects[object].r * 20})
	# do cool stuff to make a texture that moves and adds these objects to the game?
	
	# move the texture based off of how far the player has moved
	var difference = player_last_pos - Vector2(player.global_position.x,player.global_position.z)
	if difference != Vector2(0,0):
		player_last_pos = Vector2(player.global_position.x,player.global_position.z)
		total_difference += difference
		if !timer.is_stopped() && abs(total_difference.x) >= 1.0 || abs(total_difference.y) >= 1.0:
			# shift all the pixel now by however much
			# if it goes outside the bounds then just insert 0
			# this is ridiculously expensive...
			# compute shader???
			for x in range(0,size):
				for y in range(0,size):
					var shifted_coordinates = 1 #Vector2(x + total_difference.x, y + total_difference.y)
			total_difference = Vector2.ZERO
	# eventually shift all of the pixel
	
	# draw circles, will overwrite any shifts on constant objects
	for thing in things:
		draw_circle(thing.x * scale_factor,thing.y * scale_factor,thing.r)
	if player.is_on_floor():
		draw_circle(0,0,15)
	# go through every pixel and conver it to -1 to 1 and then bring towards 0
	
	timer.start()
	
func draw_circle(_x,_y,radius):
	# center of screen should be 0,0
	var point = Vector2(512 + _x, 512 + _y)
	for x in range(clamp(point.x - radius,0,1024), clamp(point.x + radius, 0,1024)):
		for y in range(clamp(point.y - radius,0,1024), clamp(point.y + radius,0,1024)):
			var distance = Vector2(x,y).distance_to(point) 
			if distance <= radius:
				# should draw the angle from the two points into the red and green channel and scale blue value based off of radius and distance from center
#				texture.set_pixel(x,y,Color.BLUE)
				var flattening = 0.0
				var x_rotation = 0.0
				var z_rotation = 0.0
		
				x_rotation = (x - point.x  + 1.0) / 2.0 
				z_rotation = (y - point.y + 1.0) / 2.0 
				
				flattening = 1.0 - distance / radius
				texture.set_pixel(x,y,Color(x_rotation, z_rotation, flattening))
				

func add_player(object: Node):
	player = object
	player_last_pos = Vector2(player.global_position.x,player.global_position.z)
func add_object(object: Node, r):
	# keeps a reference to the node so we're able to constantly poll for positions
	objects[object.get_instance_id()] = { "ref": object, "r": r}
	print(objects)

func remove_object(object: Node):
	objects.erase(object.get_instance_id())
	print(objects)

func get_texture() -> ImageTexture:
	return ImageTexture.create_from_image(texture)
