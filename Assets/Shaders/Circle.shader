Shader "CustomFullscreen/Circle"
{
    Properties
    {
        _Radius      ("Radius",      Range(0, 1))  = 0.2
        _Color       ("Albedo",      Color)  = (1,0.2,0.2,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline" = "UniversalPipeline"}
        LOD 100
        ZWrite Off Cull Off
        Pass
        {
           Name "FullscreenPass"

           HLSLPROGRAM
           #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
           #include "FullscreenVertex.hlsl"

           #pragma vertex Vert
           #pragma fragment frag
           
            float     _Radius;
            float4    _Color;

           float CircleSDF(float2 pos, float radius)
           {
               return length(pos) < radius ? 1.0 : 0.0;
           }
           
            float4 frag (Varyings i) : SV_Target
            {
                float2 pos = i.texcoord - 0.5; // [-0.5, 0.5]
                pos.x *= _ScreenParams.x / _ScreenParams.y; // Correct aspect ratio
                float hit = CircleSDF(pos, _Radius);
                return half4(hit * _Color.rgb, 1.0);
            }
           ENDHLSL
        }
    }
}
