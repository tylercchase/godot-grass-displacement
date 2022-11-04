shader_type canvas_item;

global uniform vec3 player_pos;
varying vec3 player_last_pos;


// take a uniform of ourselves to get access to a place

void fragment() {
	vec2 uv = UV - 0.5;
	float d = length(uv);
	float r = 0.03;
	vec4 c = vec4(0);
	if (d < r) {
		COLOR = vec4(0,0.0,1.0,1.0);
	} else {
		if(d < 0.05) {
//			COLOR = vec4(1.0,0,0,1.0);
		} else {
			COLOR = vec4(0.0,1.0,0,1.0);
		}
	}
	if((player_last_pos - player_pos).x == 0.0 ) {
		COLOR = vec4(1.0,1.0,1.0,1.0);
	}
	player_last_pos = player_pos;
//	COLOR = vec4(UV.x); //vec4(vec3( 1.0 - length(UV)), 1.0);
	// Place fragment code here.
}
