shader_type spatial;
render_mode unshaded, blend_mix, cull_disabled;

uniform sampler2D cloud_tex;
uniform vec2 scroll_speed = vec2(0.01, 0.005);

void fragment() {
	vec2 uv = UV + TIME * scroll_speed;
	vec4 tex = texture(cloud_tex, uv);
	ALBEDO = tex.rgb;
	ALPHA = tex.a;
}