Shader "CustomFullscreen/Texture"
{
    Properties
    {
        _Texture ("Texture", 2D) = "white" {}
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
           
           TEXTURE2D(_Texture);
           SAMPLER(sampler_Texture);

           half4 frag(Varyings input) : SV_Target
		   {
		       return SAMPLE_TEXTURE2D(_Texture, sampler_Texture, input.texcoord);
		   }
           ENDHLSL
        }
    }
}
