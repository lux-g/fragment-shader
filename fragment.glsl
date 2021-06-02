uniform sampler2D oceanTexture;
uniform sampler2D displacement;
varying vec2 vUv;
varying float vNoise;
uniform float time;
//uniform float progress;


varying vec3 vPosition;
uniform vec3 mouse;


float map(float value, float min1, float max1, float min2, float max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}




void main(){

    // vec3 color1 = vec3(0.149, 0.0, 1.0);
    // vec3 color2 = vec3(0.7333, 1.0, 0.0);
    // vec3 finalColor = mix(color1, color2, vNoise);
    
    // gl_FragColor = vec4(finalColor, 1.);

    vec2 newUV = vUv;
    newUV = vec2(newUV.x, newUV.y + 0.009*sin(newUV.x*20. + time));
    vec4 displace = texture2D(displacement, vUv.yx );

    //vec2 displacedUV = vec2(vUv.x + progress*0.1*sin(vUv.y*19. + time/10.), vUv.y);
    // /vec2 displacedUV = vec2(vUv.x, vUv.y);

    //displacedUV.y = mix(vUv.y,displace.r - 0.2 ,progress);





    // color.b = texture2D(oceanTexture, displacedUV + vec2(0.,4.* 0.1)*progress).b;
    // color.r = texture2D(oceanTexture, displacedUV + vec2(0.,4.* 0.02)*progress).r;

    vec2 direction = normalize(vPosition.xy - mouse.xy);

    float dist = distance(vPosition,mouse);

    float prox = 1. - map(dist, 0., 0.3, 0., 1.);
    prox = clamp(prox, 0., 1.);


    vec2 zoomedUV = vUv + direction * prox * 0.02;

    vec2 zoomedUV1 = mix(vUv, mouse.xy + vec2(0.5), prox * 0.2);
    vec4 color = texture2D(oceanTexture, zoomedUV1);


    //vec3 color = vec3(0.0078, 0.2549, 0.0078);

    //gl_FragColor = vec4(0.8667, 0.8667, 0.0667, 1.0);
    gl_FragColor = color;
    // gl_FragColor = vec4(prox, prox, prox, 1.);
    // gl_FragColor = vec4(direction,0.,1.);
    // gl_FragColor = vec4(vNoise, 0., 0., 1.);
}
