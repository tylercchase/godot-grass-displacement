shader_type particles;
uniform float rows = 4;
uniform float spacing = 1.0;

uniform sampler2D rotation_noise;

uniform sampler2D displace;
global uniform vec3 player_pos;
uniform sampler2D move_noise;
void start() {
	// Place start code here.
}

void process() {
	vec3 pos = vec3(0.0, 0.0, 0.0);
	pos.z = float(INDEX);
	pos.x = mod(pos.z, rows);
	pos.z = (pos.z - pos.x) / rows;
	
	// figuring out what the heck positioning is for this displacement texture
	// this needs a much better method but works for a temporary solution
	vec2 displace_uv = pos.xz;
//	displace_uv *= 0.002;

	displace_uv *= 0.003;
	displace_uv.x -= 0.03;
	displace_uv.y -= 0.05;
	vec4 displacement = texture(displace, displace_uv);
	
	// center this
	pos.x -= rows * 0.5;
	pos.z -= rows * 0.5;
	
	// grab before adding in our particle node's position
	// and now apply our spacing
	pos *= spacing;
	//add particle emitter transform
	pos.x += EMISSION_TRANSFORM[3][0] - mod(EMISSION_TRANSFORM[3][0], spacing);
	pos.z += EMISSION_TRANSFORM[3][2] - mod(EMISSION_TRANSFORM[3][2], spacing);
	

	vec3 noise = texture(move_noise, pos.xz * 0.1).rgb;

	// add some spice to the positions of the grass
	pos.x += noise.x * spacing;
	pos.z += noise.y * spacing;
	
	COLOR = vec4(displacement.rgb, 1.0);
	// rotate blades randomly
	TRANSFORM[0][0] = cos(noise.z * 3.0);
	TRANSFORM[0][2] = -sin(noise.z * 3.0);
	TRANSFORM[2][0] = sin(noise.z * 3.0);
	TRANSFORM[2][2] = cos(noise.z * 3.0);
	
	TRANSFORM[3][0] = pos.x;
	TRANSFORM[3][1] = pos.y;
	TRANSFORM[3][2] = pos.z;
	
	CUSTOM = vec4(displacement.rgb, noise.b);
}

void vertex() {
}
