#version 330

in vec2 position;
in vec3 color;

out vec3 frag_color;

void main()
{
	frag_olor = color;
    gl_Position = vec4(position, 0.0, 1.0);
}
