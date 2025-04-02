shader_type canvas_item;

void fragment() {
    vec3 color = texture(TEXTURE, UV).rgb;
    float brightness = dot(color, vec3(0.299, 0.587, 0.114)); // Calcula o brilho da cor
    color = brightness > 0.5 ? vec3(1.0) : vec3(0.0); // Define preto ou branco
    COLOR = vec4(color, texture(TEXTURE, UV).a);
}