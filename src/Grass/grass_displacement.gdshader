shader_type canvas_item;

void fragment() {
	
	COLOR = vec4(1.0,0,0,1.0);
	vec2 uv = UV - 0.4;
	float d = length(uv);
	float r = 0.5;
	float c = 0.0;
	if (d < r) {
		c = 1.0;
	}
	COLOR = vec4(vec3(c), 1.0);
//	COLOR = vec4(UV.x); //vec4(vec3( 1.0 - length(UV)), 1.0);
	// Place fragment code here.
}
