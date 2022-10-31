// NOTE: Shader automatically converted from Godot Engine 4.0.beta3's StandardMaterial3D.

shader_type spatial;
render_mode cull_disabled;

uniform vec3 scale = vec3(1.0);

global uniform vec3 player_pos;
varying float dist_to_player;
void vertex() {
	// TODO: normals are being weird, need to fix 
	NORMAL = vec3(0,1,0);
	// scale the vertex by scale factor, lets us dynamically change later
	VERTEX = (MODEL_MATRIX * vec4((VERTEX * scale),0.0)).xyz;
	dist_to_player = distance(player_pos, (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz); 
//	if( dist_to_player < 1.0) {
//		VERTEX = VERTEX + vec3(0, dist_to_player ,0);
//	}
	// vertex is the tip of the grass blade
	if (VERTEX.y > 0.0) {
		// move in the "wind" as time progresses
		VERTEX -= vec3(sin(TIME) * 0.2,0,0);
		
		// test displacement of grass tips
		if(dist_to_player < 3.0) {
			VERTEX -= normalize((MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz - player_pos);
		}
		if(INSTANCE_CUSTOM.b > 0.0) {
			VERTEX = vec3(0.1);
		}
	}
}






void fragment() {
	float side = FRONT_FACING ? 1.0 : -1.0;
	NORMAL = NORMAL * side;
//	ALBEDO = vec3(0,1.0,0);
	ALBEDO = COLOR.rgb;
}
