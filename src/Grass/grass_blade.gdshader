// NOTE: Shader automatically converted from Godot Engine 4.0.beta3's StandardMaterial3D.

shader_type spatial;
render_mode cull_disabled;
uniform vec3 scale = vec3(1.0);

global uniform vec3 player_pos;
varying float dist_to_player;
void vertex() {
	NORMAL = vec3(0,1,0);
	// scale the vertex by scale factor, lets us dynamically change later
	VERTEX = (MODEL_MATRIX * vec4((VERTEX * scale),0.0)).xyz;
	dist_to_player = distance(player_pos, (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz); 

	// move in the "wind" as time progresses
	VERTEX += vec3(sin(TIME * INSTANCE_CUSTOM.w) * 0.2 
	,0,0) * VERTEX.y;
	
	// apply stuff from texture
	VERTEX.y *= 1.0 - INSTANCE_CUSTOM.b;
	VERTEX.x += (INSTANCE_CUSTOM.r * 2.0 - 1.0) * VERTEX.y * 1.0;
	VERTEX.z += (INSTANCE_CUSTOM.g * 2.0 - 1.0) * VERTEX.y * 1.0;
}



void fragment() {
	float side = FRONT_FACING ? 1.0 : -1.0;
	NORMAL = NORMAL * side;
	ALBEDO = vec3(0.2,0.6,0.2);
	ROUGHNESS = 1.0;
	// show texture
//	ALBEDO = COLOR.rgb;
}
