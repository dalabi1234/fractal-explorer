shader_type canvas_item;

uniform float seedReal;
uniform float seedImag;
uniform float viewReal;
uniform float viewImag;
uniform float viewZoom;
uniform float viewItter;


vec2 cMul(vec2 Z, vec2 W) {
	return vec2(Z.x*W.x - Z.y*W.y, Z.x*W.y + Z.y*W.x);}

vec2 cMod(vec2 Z) {
	return vec2 (length(Z),0.0);}

vec2 cSqrt(vec2 Z) {
	return vec2(cos(atan(Z.y,Z.x)/2.0),sin(atan(Z.y,Z.x)/2.0))*sqrt(length(Z));
}

void fragment() {
	// Defining z based on Transformed screen coordinates
	vec2 z = ((UV.xy - 0.5) * vec2(1.,-1.) / viewZoom) + vec2(viewReal,viewImag);
	
	vec2 s = vec2(seedReal,seedImag);
	vec2 c = z;
	z = cSqrt(z);
	//z += s;
	
	float Itter = 1.0;

	for (float i = 1.;i<viewItter+1.0;i++) {
		if (length(z)<2.0) {
			//z = abs(z);
			//z = cMul(z,z) - cMul(vec2(0.5,0.2),z);
			z = cMul(z,z);
			z += s;
			Itter = i;
		}
		
	}
	
	vec4 AxesAndUnitCircle = vec4(
		float((-0.002/viewZoom < c.x && c.x < 0.002/viewZoom) || (-0.002/viewZoom < c.y && c.y < 0.002/viewZoom)),
		step(1. - 0.003/viewZoom,length(c)) - step(1. + 0.003/viewZoom,length(c))+float(length(z)<2.0)/2.0,
		0,
		1.0);
	
	vec4 ItterationColorMapThing = vec4(
		float(bool(viewItter<Itter+1.0)),
		float(bool(viewItter<Itter+1.0)) + Itter/viewItter,
		float(bool(viewItter<Itter+1.0)) + fract(Itter/sqrt(viewItter)),
		1.0);
	
	
	COLOR = AxesAndUnitCircle + ItterationColorMapThing;
}
