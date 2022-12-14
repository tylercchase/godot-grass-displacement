shader_type spatial;
render_mode unshaded;
render_mode shadows_disabled;
uniform sampler2D displace;
void fragment() {
	vec2 uv = vec2(1.0 - UV.x, 1.0 - UV.y);
	ALBEDO = texture(displace, uv).rgb;
}
