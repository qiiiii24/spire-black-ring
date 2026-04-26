shader_type canvas_item;

uniform bool is_open = false;

uniform float outline_width1 = 0.0;
uniform float outline_width2 = 1.0;
uniform float outline_width3 = 2.0;

uniform vec4 outline_color1 : source_color = vec4(0, 0, 0, 1);
uniform vec4 outline_color2 : source_color = vec4(0, 0, 0, 1);
uniform vec4 outline_color3 : source_color = vec4(0, 0, 0, 1);

uniform float anim_speed = 3.0;
uniform float anim_strength = 0.5;

void fragment() {
	vec2 uv = UV;

	// 三层浮动宽度
	// 第一层：0 ~ 1
	float width1 = clamp(
		0.5 + ((sin(TIME * anim_speed) + 1.0) * 0.5) * 0.5,
		0.5,
		1.0
	);

	// 第二层：1 ~ 2
	float width2 = clamp(
		outline_width2 + (sin(TIME * anim_speed ) + 1.0) * 0.5 * anim_strength * 2.0,
		1.0,
		2.0
	);

	// 第三层：2 ~ 3
	float width3 = clamp(
		outline_width3 + (sin(TIME * anim_speed) + 1.0) * 0.5 * anim_strength * 2.0,
		2.0,
		3.0
	);

	// ===== 第1层 =====
	vec2 px1 = TEXTURE_PIXEL_SIZE * width1;

	vec4 color_up1    = texture(TEXTURE, uv + vec2(0.0,  px1.y));
	vec4 color_down1  = texture(TEXTURE, uv + vec2(0.0, -px1.y));
	vec4 color_left1  = texture(TEXTURE, uv + vec2(-px1.x, 0.0));
	vec4 color_right1 = texture(TEXTURE, uv + vec2( px1.x, 0.0));

	vec4 color_ul1 = texture(TEXTURE, uv + vec2(-px1.x,  px1.y));
	vec4 color_ur1 = texture(TEXTURE, uv + vec2( px1.x,  px1.y));
	vec4 color_dl1 = texture(TEXTURE, uv + vec2(-px1.x, -px1.y));
	vec4 color_dr1 = texture(TEXTURE, uv + vec2( px1.x, -px1.y));

	vec4 outline1 = color_up1 + color_down1 + color_left1 + color_right1
		+ color_ul1 + color_ur1 + color_dl1 + color_dr1;
	outline1.rgb = outline_color1.rgb;
	outline1.a = clamp(outline1.a, 0.0, 1.0) * outline_color1.a;

	// ===== 第2层 =====
	vec2 px2 = TEXTURE_PIXEL_SIZE * width2;

	vec4 color_up2    = texture(TEXTURE, uv + vec2(0.0,  px2.y));
	vec4 color_down2  = texture(TEXTURE, uv + vec2(0.0, -px2.y));
	vec4 color_left2  = texture(TEXTURE, uv + vec2(-px2.x, 0.0));
	vec4 color_right2 = texture(TEXTURE, uv + vec2( px2.x, 0.0));

	vec4 color_ul2 = texture(TEXTURE, uv + vec2(-px2.x,  px2.y));
	vec4 color_ur2 = texture(TEXTURE, uv + vec2( px2.x,  px2.y));
	vec4 color_dl2 = texture(TEXTURE, uv + vec2(-px2.x, -px2.y));
	vec4 color_dr2 = texture(TEXTURE, uv + vec2( px2.x, -px2.y));

	vec4 outline2 = color_up2 + color_down2 + color_left2 + color_right2
		+ color_ul2 + color_ur2 + color_dl2 + color_dr2;
	outline2.rgb = outline_color2.rgb;
	outline2.a = clamp(outline2.a, 0.0, 1.0) * outline_color2.a;

	// ===== 第3层 =====
	vec2 px3 = TEXTURE_PIXEL_SIZE * width3;

	vec4 color_up3    = texture(TEXTURE, uv + vec2(0.0,  px3.y));
	vec4 color_down3  = texture(TEXTURE, uv + vec2(0.0, -px3.y));
	vec4 color_left3  = texture(TEXTURE, uv + vec2(-px3.x, 0.0));
	vec4 color_right3 = texture(TEXTURE, uv + vec2( px3.x, 0.0));

	vec4 color_ul3 = texture(TEXTURE, uv + vec2(-px3.x,  px3.y));
	vec4 color_ur3 = texture(TEXTURE, uv + vec2( px3.x,  px3.y));
	vec4 color_dl3 = texture(TEXTURE, uv + vec2(-px3.x, -px3.y));
	vec4 color_dr3 = texture(TEXTURE, uv + vec2( px3.x, -px3.y));

	vec4 outline3 = color_up3 + color_down3 + color_left3 + color_right3
		+ color_ul3 + color_ur3 + color_dl3 + color_dr3;
	outline3.rgb = outline_color3.rgb;
	outline3.a = clamp(outline3.a, 0.0, 1.0) * outline_color3.a;

	vec4 original_color = texture(TEXTURE, uv);

	vec4 mix_color1 = mix(outline2, outline1, outline1.a);
	vec4 mix_color2 = mix(outline3, mix_color1, mix_color1.a);
	
	if(is_open){
		COLOR = mix(mix_color2, original_color, original_color.a);
	}
	
}