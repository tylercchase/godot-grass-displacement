shader_type canvas_item;
uniform sampler2D noise;
void fragment() {
	
	COLOR = texture(noise, UV);
	// Place fragment code here.
}
