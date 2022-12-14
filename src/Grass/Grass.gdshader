shader_type particles;
uniform float rows = 4;
uniform float spacing = 1.0;

uniform float wind_speed = 1.0;



uniform sampler2D wind_noise;

global uniform vec3 player_pos;
uniform sampler2D displace;
uniform sampler2D move_noise;

void process() {
	vec3 pos = vec3(0.0, 0.0, 0.0);
	pos.z = float(INDEX);
	pos.x = mod(pos.z, rows);
	pos.z = (pos.z - pos.x) / rows;

	vec2 displace_uv = pos.xz;

	displace_uv *= 0.003;
	displace_uv.x -= 0.03;
	displace_uv.y -= 0.05;



	// center this
	pos.x -= rows * 0.5;
	pos.z -= rows * 0.5;

	// and now apply our spacing
	pos *= spacing;

	//add particle emitter transform
	pos.x += EMISSION_TRANSFORM[3][0] - mod(EMISSION_TRANSFORM[3][0], spacing);
	pos.z += EMISSION_TRANSFORM[3][2] - mod(EMISSION_TRANSFORM[3][2], spacing);

	vec2 diffa = (player_pos - pos).xz;


	diffa *= 0.02;

	// Move to the center of the texture
	diffa += vec2(0.5,0.5);

	vec4 displacement;
	if(diffa.x > 1.0 || diffa.y > 1.0 || diffa.x < 0.0 || diffa.y < 0.0) {
		displacement = vec4(0.5,0.5,0,1.0);
	} else {
		 displacement = texture(displace,
		 diffa
		);
	}
	vec3 noise = texture(move_noise, pos.xz).rgb;

	// Add noise to spacing of grass
	pos.x += noise.x * spacing;
	pos.z += noise.y * spacing;

	TRANSFORM[3][0] = pos.x;
	TRANSFORM[3][1] = pos.y;
	TRANSFORM[3][2] = pos.z;
	CUSTOM = vec4(displacement.rgb, 1.0);
}
