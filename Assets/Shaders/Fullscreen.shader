Shader "Fullscreen"
{
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
           #include "Packages/com.unity.render-pipelines.core/Runtime/Utilities/Blit.hlsl"

           #pragma vertex Vert
           #pragma fragment frag

           TEXTURE2D_X(_CameraOpaqueTexture);
           SAMPLER(sampler_CameraOpaqueTexture);

           float4 _Color;

           half4 frag(Varyings input) : SV_Target
		   {
               UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);
			   return _Color;
		   }
           ENDHLSL
        }
    }
}
