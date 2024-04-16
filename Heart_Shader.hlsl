float dot2( in vec2 v ) { return dot(v,v); }

float sdHeart( in vec2 p )
{
    p.x = abs(p.x);

    if( p.y+p.x>1.0 )
        return sqrt(dot2(p-vec2(0.25,0.75))) - sqrt(2.0)/4.0;
    return sqrt(min(dot2(p-vec2(0.00,1.00)),
                    dot2(p-0.5*max(p.x+p.y,0.0)))) * sign(p.x-p.y);
} 

vec3 palette (float t)
{
    vec3 a = vec3(.988 ,.248 ,5.508);
    vec3 b = vec3(0.941, .23, 2.044);
    vec3 c = vec3(4.037, 2.477, -3.483);
    vec3 d = vec3(3.233, 0.288, 20.257);

    return a + b*cos( 6.28318* (c*t+d));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord * 2. - iResolution.xy)/ iResolution.y;
    
    uv.y +=.5;

    float d = length(sdHeart(uv));

    uv = fract(uv);

    vec3 col = palette(d + iTime * .5);

    d = sin(d*11. + iTime)/9.;
    d = abs(d);

    d = smoothstep(0., .1, d);

    d = .1 / d;

    col *= d;

    fragColor = vec4(col, 1. );

}