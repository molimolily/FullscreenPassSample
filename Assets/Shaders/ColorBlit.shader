Shader "ColorBlit"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline" = "UniversalPipeline"}
        LOD 100
        ZWrite Off Cull Off
        Pass
        {
           Name "ColorBlitPass"

           HLSLPROGRAM
           #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
           #include "Packages/com.unity.render-pipelines.core/Runtime/Utilities/Blit.hlsl"

           #pragma vertex Vert
           #pragma fragment frag

           TEXTURE2D_X(_CameraOpaqueTexture);
           SAMPLER(sampler_CameraOpaqueTexture);

           float _Intensity;

           half4 frag(Varyings input) : SV_Target
		   {
               UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);
			   half4 color = SAMPLE_TEXTURE2D_X(_CameraOpaqueTexture, sampler_CameraOpaqueTexture, input.texcoord);
			   return color * float4(0, _Intensity, 0, 1);
		   }
           ENDHLSL
        }
    }
}
