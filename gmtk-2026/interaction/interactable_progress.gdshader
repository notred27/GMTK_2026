shader_type spatial;
render_mode unshaded, cull_disabled, blend_mix, depth_draw_never;

uniform vec4 fill_color : source_color = vec4(1.0);
uniform vec4 empty_color : source_color = vec4(1.0, 1.0, 1.0, 0.2);
uniform float fill_amount : hint_range(0.0, 1.0) = 0.0;
uniform float ring_radius : hint_range(0.0, 0.5) = 0.4;
uniform float ring_thickness : hint_range(0.0, 0.2) = 0.05;

void fragment() {
	vec2 centered = UV - vec2(0.5);
	float dist = length(centered);

	// Circle calc
	float outer = ring_radius + ring_thickness * 0.5;
	float inner = ring_radius - ring_thickness * 0.5;
	if (dist > outer || dist < inner) discard;

	float angle = degrees(atan(centered.y, centered.x)) + 180.0;
	angle = mod(angle - 90.0 + 360.0, 360.0); // Rotate fill

	vec4 col = angle <= fill_amount * 360.0 ? fill_color : empty_color;
	ALBEDO = col.rgb;
	ALPHA = col.a;
}