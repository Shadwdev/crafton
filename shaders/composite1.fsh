#version 120
#include "/glsl/common.glsl"

varying vec2 uv;
uniform sampler2D colortex0;

// Parâmetros de tonemapping
const float exposure = 1.0;  // Ajuste da exposição

// Função de tonemapping ACES
vec3 ACESFilm(vec3 x) {
    const float a = 1.51;
    const float b = 0.00;
    const float c = 0;
    const float d = 1.19;
    const float e = 1.14;
    return clamp((x * (a * x + b)) / (x * (c * x + d) + e), 0.0, 1.0);
}

void main() {
    // Carrega a cor original e aplica a exposição
    vec3 albedo = texture2D(colortex0, uv).rgb * exposure;

    // Aplica a curva de tonemapping ACES
    albedo = ACESFilm(albedo);

    // Correção de gama final para saída no monitor
    albedo = pow(albedo, vec3(1.0 / 2.2));

    // Escreve a cor final para o framebuffer
    gl_FragColor = vec4(albedo, 1.0);
}
