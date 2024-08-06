shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D noise_text : filter_nearest, repeat_enable;
uniform float anim_speed;
uniform float pixellation = 1.0;
uniform float y_offset = 1.0;
uniform float other_y_offset = 1.0;
uniform vec4 color;
uniform int iter_c = 5;
void fragment() {
	vec4 final_color_up;
	vec4 final_color_down;
	/*if (UV.y < 0.5) {
	vec2 uv = vec2(UV.x, UV.y);
	vec2  ires = 1.0 / SCREEN_PIXEL_SIZE;
	uv = 0.5 + uv/min(ires.x, ires.y)/2.0;
	uv = floor(uv * pixellation)/pixellation;

	uv = mix(UV, uv, tan(UV.y * TIME - tan(UV.x * TIME)));
	uv = vec2(uv.x, uv.y + TIME * anim_speed);
	uv = floor(uv * pixellation)/pixellation;
	vec4 noise_col = texture(noise_text, uv);
	vec4 final_col = noise_col;
	final_col.rgb += vec3(UV.y - y_offset);
	final_col.rgb = step(final_col.rgb, vec3(0.5));

	COLOR = vec4((1.0 - final_col.rgb) * color.rgb * (0.5 - UV.y), 1.0 -final_col.r);
	}*/
	{
	vec2 uv = vec2(UV.x, UV.y);
	vec2  ires = 1.0 / SCREEN_PIXEL_SIZE;
	uv = 0.5 + uv/max(ires.x, ires.y)/2.0;
	uv.x = (0.5 - (uv.x * 1.5)) / 2.0;
	for (int i=1; i<=iter_c; i++) {
	uv = mix(UV, uv, -tan(UV.y * cos(float(i)*TIME * (0.1 + 1.0/uv.y)) - tan(float(i) * UV.x * sin(TIME/float(i)))));
	}
	uv = floor(uv * pixellation)/pixellation;
	uv = vec2(uv.x - 10.5, uv.y - sin(TIME * anim_speed));

	vec4 noise_col = texture(noise_text, uv);
	vec4 final_col = noise_col;
	final_col.rgb -= vec3(UV.y +y_offset - 1.0);
	final_col.rgb = step(final_col.rgb, vec3(0.5));

	final_color_down.rgb = vec3(final_col.rgb);
	final_color_down.a = 1.0 - final_col.r;
	COLOR = vec4((1.0 - final_color_down.rgb) * color.rgb * (0.5 - uv.y), 1.0);
	}



}
