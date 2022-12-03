shader_type spatial;

uniform sampler2D displace;
void fragment() {
	ALBEDO = texture(displace, UV).rgb;
}
