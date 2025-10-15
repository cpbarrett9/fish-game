shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform float contrast : hint_range(0.0, 4.0) = 1.5;
uniform vec4 tint_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Apply contrast
    tex_color.rgb = (tex_color.rgb - vec3(0.5)) * contrast + vec3(0.5);

    // Apply tint color (like modulate)
    COLOR.rgb = tex_color.rgb * tint_color.rgb;
    COLOR.a = tex_color.a * tint_color.a;
}