Shader "CustomFullscreen/Barrier"
{
    Properties
    {
        [IntRange] _Width ("Width", Range(1,50)) = 1
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

           int _Width;

           half4 frag(Varyings input) : SV_Target
		   {
		       float x = input.positionCS.x; // pixel coordinate [0, Resolution.x]
		       
		       if (x % _Width < _Width * 0.5)
               {
                   return half4(1.0, 1.0, 1.0, 1.0);
               }
               else
               {
                   return half4(0.0, 0.0, 0.0, 1.0);
               }
		   }
           ENDHLSL
        }
    }
}
