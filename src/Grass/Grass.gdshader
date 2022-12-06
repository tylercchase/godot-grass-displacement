shader_type particles;
uniform float rows = 4;
uniform float spacing = 1.0;

uniform float wind_speed = 1.0;



uniform sampler2D wind_noise;

global uniform vec3 player_pos;
uniform sampler2D displace;
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
	

	
	// center this
	pos.x -= rows * 0.5;
	pos.z -= rows * 0.5;
	
	// grab before adding in our particle node's position
	// and now apply our spacing
	pos *= spacing;
	//add particle emitter transform
	pos.x += EMISSION_TRANSFORM[3][0] - mod(EMISSION_TRANSFORM[3][0], spacing);
	pos.z += EMISSION_TRANSFORM[3][2] - mod(EMISSION_TRANSFORM[3][2], spacing);
	
	// would be cool to pull texture from displacement from the posititon relative to the player
	vec2 diffa = (player_pos - pos).xz;


	// Magic number so far, needs to be more defien
	diffa *= 0.02;
	// Move to the center of the texture
	diffa += vec2(0.5,0.5);
	vec4 displacement;
	if(diffa.x > 1.0 || diffa.y > 1.0 || diffa.x < 0.0 || diffa.y < 0.0) {
		displacement = vec4(0.5,0.5,0,1.0);
//		COLOR = vec4(1.0,0,0,1.0);
		
	} else {
//		COLOR = vec4(0,1.0,0,1.0);
		 displacement = texture(displace,
		 diffa 
		);
	}
	vec3 noise = texture(move_noise, pos.xz).rgb;
	float wind = texture(wind_noise, pos.xz).b * wind_speed ;

	// add some spice to the positions of the grass
	pos.x += noise.x * spacing;
	pos.z += noise.y * spacing;
	
	
//	COLOR = vec4(displacement.rgb, 1.0);
//		TRANSFORM[0][0] = cos(noise.x * 3.0);
//		TRANSFORM[0][2] = -sin(noise.x * 3.0);
//		TRANSFORM[2][0] = sin(noise.y * 3.0);
//		TRANSFORM[2][2] = cos(noise.y * 3.0);
	
	TRANSFORM[3][0] = pos.x;
	TRANSFORM[3][1] = pos.y;
	TRANSFORM[3][2] = pos.z;
	
	CUSTOM = vec4(displacement.rgb, wind);
}

void vertex() {
}
