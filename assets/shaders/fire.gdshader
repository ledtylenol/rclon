shader_type canvas_item;


uniform sampler2D noise_text : filter_nearest, repeat_enable;
uniform float anim_speed;
uniform float pixellation = 1.0;
uniform float y_offset = 1.0;
uniform float zoom = 1.0;
uniform sampler2D text: repeat_enable, filter_nearest;
uniform sampler2D texts: repeat_enable, filter_nearest;
uniform sampler2D screen_texture: hint_screen_texture;
uniform float opacity: hint_range(0.0, 1.0, 0.1);
vec2 polar_coords(vec2 uv, vec2 Center, float RadialScale, float LengthScale )
{
    vec2 delta = uv - Center;
    float radius = length(delta) * 2.0 * RadialScale;
    float angle = atan(delta.y, delta.x) * 1.0/6.28 * LengthScale;
    return vec2(radius, angle);
}
void fragment() {
	vec4 screen_tex = texture(screen_texture, SCREEN_UV);
	vec4 final_color_up;
	vec4 final_color_down;
	vec2 uv = vec2(UV.x, UV.y) * zoom;
	uv = floor(uv * pixellation)/pixellation;

	//uv = mix(UV, uv, cos(tan(sin(uv.y + TIME*2.0 * anim_speed) - tan(cos(uv.x + 5.0 *TIME * anim_speed))/2.0)));
	uv = mix(UV, uv, cos(sin(uv.y + TIME*2.0 * anim_speed) - tan(cos(uv.x + 5.0 *TIME * anim_speed)/2.0)));

	uv = vec2(uv.x, uv.y + TIME * anim_speed);
	//uv = floor(uv * pixellation)/pixellation;
	vec4 noise_col = texture(noise_text, uv);
	vec4 final_col = noise_col;
	final_col.rgb += vec3(UV.y - y_offset);
	final_col.rgb = step(final_col.rgb, vec3(0.5));
	vec2 text_uv = vec2(UV.x, UV.y - TIME * anim_speed * 0.1);
	vec2 texts_uv = vec2(UV.x, UV.y + TIME * 0.1*anim_speed);
	//text_uv = polar_coords(text_uv, vec2(0.5), 1.0, 1.0);
	//texts_uv = polar_coords(texts_uv, vec2(0.5), 0.5, 1.0);

	float x = texture(texts, text_uv).r;
	texts_uv.y += anim_speed * x / 2.0;
	texts_uv.x += sin(x + TIME * anim_speed);
	vec4 textures = texture(text, texts_uv);
	textures = vec4((1.0 - final_col.rgb) *(textures.rgb), (1.0 -final_col.r));
	COLOR.rgb = mix(textures.rgb, screen_tex.rgb, opacity);
	COLOR.a = textures.a;



}
