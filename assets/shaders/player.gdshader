shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 color = COLOR.rgb;
	if (color.r + color.g + color.b != 0.0) {
		color.r = (sin(TIME * 3.0) + 1.0) / 2.0;
		color.g = (cos(TIME * 1.5) + 1.0) / 2.0;
		color.b = (sin(-TIME * 1.5) + 1.0) / 2.0;
	}

	COLOR = vec4(color, COLOR.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
