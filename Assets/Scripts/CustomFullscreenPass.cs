using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class CustomFullscreenPass : ScriptableRenderPass
{
    private static readonly int FrameCount = Shader.PropertyToID("_FrameCount");
    private Material _material;
    private RTHandle _colorTarget;

    public CustomFullscreenPass(Material material)
    {
        _material = material;
        renderPassEvent = RenderPassEvent.AfterRendering;
        profilingSampler = new ProfilingSampler("CustomFullscreenPass");
    }

    public void SetResources(Material material, RTHandle target)
    {
        _material = material;
        _colorTarget = target;
    }
    
    public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
    {
        ConfigureTarget(_colorTarget);
    }

    public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
    {
        if(_material == null) return;
        _material.SetInt(FrameCount, Time.frameCount);
        
        CommandBuffer cmd = CommandBufferPool.Get();
        using(new ProfilingScope(cmd, profilingSampler))
        {
            CoreUtils.DrawFullScreen(cmd, _material);
        }
        context.ExecuteCommandBuffer(cmd);
        cmd.Clear();

        CommandBufferPool.Release(cmd);
    }
}
