@tool
extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	DisplacementBuffer.add_player(self)

func _physics_process(delta):
	if Engine.is_editor_hint():
		RenderingServer.global_shader_parameter_set("player_pos", global_position)
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	var _a = move_and_slide()
	RenderingServer.global_shader_parameter_set("player_pos", global_position)






func _on_object_area_body_entered(body):
	print('aaaaaaaa')
	DisplacementBuffer.add_object(body, 1)


func _on_object_area_body_exited(body):
	DisplacementBuffer.remove_object(body)
