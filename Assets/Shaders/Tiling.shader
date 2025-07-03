Shader "CustomFullscreen/Tiling"
{
    Properties
    {
        [IntRange] _TileSizeX ("Tile Size X", Range(1, 100)) = 50
        [IntRange] _TileSizeY ("Tile Size Y", Range(1, 100)) = 50
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

           int _TileSizeX, _TileSizeY;

           half4 frag(Varyings input) : SV_Target
		   {
		       float2 tileCoords = frac(input.positionCS.xy / float2(_TileSizeX, _TileSizeY));
		       return half4(tileCoords, 0.0, 1.0);
		   }
           ENDHLSL
        }
    }
}
