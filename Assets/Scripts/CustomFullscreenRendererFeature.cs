using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class CustomFullscreenRendererFeature : ScriptableRendererFeature
{
    public Material material;
    private CustomFullscreenPass _renderPass;

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if(renderingData.cameraData.cameraType == CameraType.Game)
        {
            renderer.EnqueuePass(_renderPass);
        }
    }

    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData)
    {
        if(renderingData.cameraData.cameraType == CameraType.Game)
        {
            _renderPass.ConfigureInput(ScriptableRenderPassInput.Color);
            _renderPass.SetResources(material, renderer.cameraColorTargetHandle);
        }
    }

    public override void Create()
    {
        _renderPass = new CustomFullscreenPass(material);
    }
}
