extends Node

var objects := {}
var player: CharacterBody3D
var texture: Image
var previous_frame


var size = 1024

var total_difference := Vector2()
var timer := Timer.new()
var player_last_pos := Vector2()

var trail := []

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = Image.create(size, size, false, Image.FORMAT_RGBA8)
	texture.fill(Color(0.5, 0.5, 0.0, 1.0))
	timer.one_shot = true
	timer.wait_time = 1
	add_child(timer)

# Called every frame. Creates the texture
func _process(_delta):

	var scale_factor = 20

	texture.fill(Color(0.5, 0.5, 0.0, 1.0))

	var relative_positions = []
	for object in objects.keys():
		var relative = player.global_position - objects[object].ref.global_position
		relative_positions.push_back({"x": relative.x, "y": relative.z, "r": objects[object].r * 20})


	# Create the trail behind the player
	var i = 0
	while i < trail.size():
		var piece_difference = trail[i][0] - Vector2(player.global_position.x,player.global_position.z)
		trail[i][1] -= 0.01
		draw_circle(-piece_difference.x * 20,-piece_difference.y * 20, 15, trail[i][1])
		if trail[i][1] <= 0:
			trail.remove_at(i)
			i -= 1
		i += 1

	# draw objects, will overwrite everything else
	for object in relative_positions:
		draw_circle(object.x * scale_factor,object.y * scale_factor,object.r)
	if player.is_on_floor():
		# Check if the player has moved and if so add to trail
		var difference = player_last_pos - Vector2(player.global_position.x,player.global_position.z)
		if difference != Vector2(0,0):
			total_difference += difference
			if timer.is_stopped() && abs(total_difference.x) >= 1.0 || abs(total_difference.y) >= 1.0:
				trail.push_back([player_last_pos, 1.0])
				player_last_pos = Vector2(player.global_position.x,player.global_position.z)
		# draw in center for player
		draw_circle(0,0,15)
	player_last_pos = Vector2(player.global_position.x,player.global_position.z)

	timer.start()


func draw_circle(_x,_y,radius, scale=1.0):
	var point = Vector2(512 + _x, 512 + _y)
	for x in range(clamp(point.x - radius,0,1024), clamp(point.x + radius, 0,1024)):
		for y in range(clamp(point.y - radius,0,1024), clamp(point.y + radius,0,1024)):
			var distance = Vector2(x,y).distance_to(point) 
			if distance <= radius:
				var flattening = 0.0
				var x_change = 0.0
				var z_change = 0.0
				x_change = ((x - point.x) * scale  + 1.0) / 2.0 
				z_change = ((y - point.y) * scale + 1.0) / 2.0 

				flattening = 1.0 * scale - (distance / radius) 
				texture.set_pixel(x,y,Color(x_change, z_change, flattening))


func add_player(object: Node):
	player = object
	player_last_pos = Vector2(player.global_position.x,player.global_position.z)

func add_object(object: Node, r):
	# keeps a reference to the node so we're able to constantly poll for positions
	objects[object.get_instance_id()] = { "ref": object, "r": r}

func remove_object(object: Node):
	objects.erase(object.get_instance_id())

func get_texture() -> ImageTexture:
	return ImageTexture.create_from_image(texture)
