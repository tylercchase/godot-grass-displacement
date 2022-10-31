shader_type particles;
uniform float rows = 4;
uniform float spacing = 1.0;

uniform sampler2D rotation_noise;

uniform sampler2D displace;
global uniform vec3 player_pos;
void start() {
	// Place start code here.
}

void process() {
	vec3 pos = vec3(0.0, 0.0, 0.0);
	pos.z = float(INDEX);
	pos.x = mod(pos.z, rows);
	pos.z = (pos.z - pos.x) / rows;
	
	// center this
	pos.x -= rows * 0.5;
	pos.z -= rows * 0.5;
	
	// grab before adding in our particle node's position
	vec4 di = texture(displace, pos.xz * 0.001);
	
	// and now apply our spacing
	pos *= spacing;
	//add particle emitter transform
	pos.x += EMISSION_TRANSFORM[3][0] - mod(EMISSION_TRANSFORM[3][0], spacing);
	pos.z += EMISSION_TRANSFORM[3][2] - mod(EMISSION_TRANSFORM[3][2], spacing);
	

	vec4 noise = texture(rotation_noise, pos.xz * 0.01);
	
	

	
	
	COLOR = vec4(di.rgb, 1.0);
	// rotate blades randomly
	TRANSFORM[0][0] = cos(noise.z * 3.0);
	TRANSFORM[0][2] = -sin(noise.z * 3.0);
	TRANSFORM[2][0] = sin(noise.z * 3.0);
	TRANSFORM[2][2] = cos(noise.z * 3.0);
	
	TRANSFORM[3][0] = pos.x;
	TRANSFORM[3][1] = pos.y;
	TRANSFORM[3][2] = pos.z;
	
	CUSTOM = di;
}

void vertex() {
}
