shader_type canvas_item;

// Color Modes:
// - 0: normal
// - 1: retro
// - 2: grayscale
// - 3: colorblind

// Colorblind Modes:
// - 0: Protanopia
// - 1: Deuteranopia
// - 2: Tritanopia

uniform int type = 0;
uniform int cbmode = 0;

uniform vec4 darkest : hint_color;
uniform vec4 dark : hint_color;
uniform vec4 light : hint_color;
uniform vec4 lightest : hint_color;

void fragment() {
	if (type == 0) {
		COLOR = vec4(0.0, 0.0, 0.0, 0.0);
	} else if (type == 1) {
		// To be fixed
		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
		float rgb_avg = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
		if (rgb_avg < 0.25) {
			COLOR = darkest;
		} else if (rgb_avg < 0.5) {
			COLOR = dark;
		} else if (rgb_avg < 0.75) {
			COLOR = light;
		} else {
			COLOR = lightest;
		}
	} else if (type == 2) {
		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
		float rgb_avg = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
		COLOR = vec4(rgb_avg, rgb_avg, rgb_avg, 1.0);
	} else if (type == 3) {
		vec3 rgb = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
		if (cbmode == 0) { // Protanopia
			float luminance = dot(rgb, vec3(0.2126, 0.7152, 0.0722));
			COLOR.rgb = vec3(luminance, luminance * 0.769, luminance * 0.189);
		} else if (cbmode == 1) { // Deuteranopia
			float luminance = dot(rgb, vec3(0.2126, 0.7152, 0.0722));
			COLOR.rgb = vec3(luminance * 0.625, luminance, luminance * 0.125);
		} else if (cbmode == 2) { // Tritanopia
			float luminance = dot(rgb, vec3(0.2126, 0.7152, 0.0722));
			COLOR.rgb = vec3(luminance * 0.95, luminance * 0.05, luminance);
		}
	}
}