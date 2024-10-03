using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class CustomFullscreenRendererFeature : ScriptableRendererFeature
{
    public Shader shader;

    [SerializeField] Color color1 = Color.white;
    [SerializeField] Color color2 = Color.black;
    
    Material material;

    CustomFullscreenPass renderPass = null;

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if(renderingData.cameraData.cameraType == CameraType.Game)
        {
            renderer.EnqueuePass(renderPass);
        }
    }

    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData)
    {
        if(renderingData.cameraData.cameraType == CameraType.Game)
        {
            renderPass.ConfigureInput(ScriptableRenderPassInput.Color);
            renderPass.SetTarget(renderer.cameraColorTargetHandle);
            renderPass.color1 = color1;
            renderPass.color2 = color2;
        }
    }

    public override void Create()
    {
        material = CoreUtils.CreateEngineMaterial(shader);
        renderPass = new CustomFullscreenPass(material);
    }
}
