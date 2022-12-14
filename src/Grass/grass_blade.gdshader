shader_type spatial;
render_mode cull_disabled;
uniform vec3 scale = vec3(1.0);

global uniform vec3 player_pos;

void vertex() {
	NORMAL = vec3(0,1,0);
	// scale the vertex by scale factor, lets us dynamically change later
	VERTEX = (MODEL_MATRIX * vec4((VERTEX * scale),0.0)).xyz;

	// apply displacement from texture
	VERTEX.y *= 1.0 - INSTANCE_CUSTOM.b;
	VERTEX.x -= (INSTANCE_CUSTOM.r * 2.0 - 1.0) * VERTEX.y * 0.2;
	VERTEX.z -= (INSTANCE_CUSTOM.g * 2.0 - 1.0) * VERTEX.y * 0.2;
}



void fragment() {
	float side = FRONT_FACING ? 1.0 : -1.0;
	NORMAL = NORMAL * side;
	ALBEDO = vec3(0.2,0.6,0.2);
	ROUGHNESS = 1.0;
}
