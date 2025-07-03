Shader "CustomFullscreen/TwoColorSwap"
{
    Properties
    {
        _Color1 ("Color 1", Color) = (1, 0, 0, 1)
        _Color2 ("Color 2", Color) = (0, 0, 1, 1)
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

           float4 _Color1;
           float4 _Color2;
           int _FrameCount;

           half4 frag(Varyings input) : SV_Target
		   {
		       if (_FrameCount % 2.0 < 1.0)
		           return _Color1;
               else
                   return _Color2;
		   }
           ENDHLSL
        }
    }
}
