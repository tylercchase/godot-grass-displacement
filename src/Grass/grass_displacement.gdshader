shader_type canvas_item;

global uniform vec3 player_pos;
varying vec3 player_last_pos;

uniform sampler2D self_reference;


void fragment() {
	// the whole texture needs to shift by the player's moved distance eventually, will be weird to figure out. 
	// may need to pass in texture of self?
	vec2 uv = UV - 0.5;
	float d = length(uv);
	float r = 0.01;
	vec4 c = vec4(0);
	
	// should pull from other parts of the canvas
	vec4 color = vec4(0.5,0.5,0.0,1.0);
	// should pull from previous color that was there;
//	color = texture(self_reference, SCREEN_UV);

	if(d < 0.05 /*replace with dynamic radius?*/) {
		color.b += clamp(1.0 - d * 40.0 * player_pos.y,0.0,1.0);
		// get angle
		float angle = atan(UV.y/UV.x);
		
		// the stuff close by that should get rotated, this is the big stuff
		// I know how far from the center I am, and probably have some stuff to deal with things
		
		// _should_ be able to just pipe in UV?
		
		// angle's not quite right, grass blade or texture side?
		color.r = (uv.x * 30.0 + 1.0) / 2.0;
		color.g = (uv.y * 30.0 + 1.0) / 2.0;
	}
	
	

	
	COLOR = color;
	
//	player_last_pos = player_pos;
//	COLOR = vec4(UV.x); //vec4(vec3( 1.0 - length(UV)), 1.0);
	// Place fragment code here.
}
