Shader "Blending/Standard (Specular)"
{
    Properties
    {
        _HeightmapBlending("Height Blend", Float) = 0.1
    
        _MainTex ("Base Color 1", 2D) = "white" {}
        _BumpMap ("Normal Map 1", 2D) = "bump" {}
        _MetallicRoughness ("Specular (RGB), Smoothness (A) 1", 2D) = "white" {}
        _AmbientOcclusion ("Ambient Occlusion 1", 2D) = "white" {}
        _Height ("Height Map 1", 2D) = "white" {}
        _Metallic ("Specular 1", Color) = (1,1,1,1)
        _Smoothness("Smoothness 1", Range(0,1)) = 1
        
        _MainTex2 ("Base Color 2", 2D) = "white" {}
        _BumpMap2 ("Normal Map 2", 2D) = "bump" {}
        _MetallicRoughness2 ("Specular (RGB), Smoothness (A) 2", 2D) = "white" {}
        _AmbientOcclusion2 ("Ambient Occlusion 2", 2D) = "white" {}
        _Height2 ("Height Map 2", 2D) = "white" {}
        _Metallic2 ("Specular 2", Color) = (1,1,1,1)
        _Smoothness2("Smoothness 2", Range(0,1)) = 1
        
        _MainTex3 ("Base Color 3", 2D) = "white" {}
        _BumpMap3 ("Normal Map 3", 2D) = "bump" {}
        _MetallicRoughness3 ("Specular (RGB), Smoothness (A) 3", 2D) = "white" {}
        _AmbientOcclusion3 ("Ambient Occlusion 3", 2D) = "white" {}
        _Height3 ("Height Map 3", 2D) = "white" {}
        _Metallic3 ("Specular 3", Color) = (1,1,1,1)
        _Smoothness3("Smoothness 3", Range(0,1)) = 1
        
        _MainTex4 ("Base Color 4", 2D) = "white" {}
        _BumpMap4 ("Normal Map 4", 2D) = "bump" {}
        _MetallicRoughness4 ("Specular (RGB), Smoothness (A) 4", 2D) = "white" {}
        _AmbientOcclusion4 ("Ambient Occlusion 4", 2D) = "white" {}
        _Height4 ("Height Map 4", 2D) = "white" {}
        _Metallic4 ("Specular 4", Color) = (1,1,1,1)
        _Smoothness4("Smoothness 4", Range(0,1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf StandardSpecular fullforwardshadows
        
        #pragma shader_feature THREE_LAYERS
        #pragma shader_feature FOUR_LAYERS

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.5
        
        #include "HeightBlend.cginc"

        UNITY_DECLARE_TEX2D(_MainTex);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicRoughness);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_AmbientOcclusion);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_Height);
        half3 _Metallic;
        half _Smoothness;
        
        UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex2);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap2);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicRoughness2);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_AmbientOcclusion2);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_Height2);
        half3 _Metallic2;
        half _Smoothness2;
        
        #if THREE_LAYERS || FOUR_LAYERS
        UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex3);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap3);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicRoughness3);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_AmbientOcclusion3);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_Height3);
        half3 _Metallic3;
        half _Smoothness3;
        #endif
        
        #if FOUR_LAYERS
        UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex4);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap4);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicRoughness4);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_AmbientOcclusion4);
        UNITY_DECLARE_TEX2D_NOSAMPLER(_Height4);
        half3 _Metallic4;
        half _Smoothness4;
        #endif

        struct Input
        {
            float4 color : COLOR;
            float2 uv_MainTex;
            float2 uv_MainTex2;
            #if THREE_LAYERS || FOUR_LAYERS
            float2 uv_MainTex3;
            #endif
            #if FOUR_LAYERS
            float2 uv_MainTex4;
            #endif
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
            float4 vc = IN.color;
        
            // Albedo comes from a texture tinted by color
            fixed4 c1 = UNITY_SAMPLE_TEX2D(_MainTex, IN.uv_MainTex);
            float3 n1 = UnpackNormal(UNITY_SAMPLE_TEX2D_SAMPLER(_BumpMap, _MainTex, IN.uv_MainTex));
            float4 m1 = UNITY_SAMPLE_TEX2D_SAMPLER(_MetallicRoughness, _MainTex, IN.uv_MainTex) 
                        * float4(_Metallic, _Smoothness);
            float a1 = UNITY_SAMPLE_TEX2D_SAMPLER(_AmbientOcclusion, _MainTex, IN.uv_MainTex).r;
            float h1 = UNITY_SAMPLE_TEX2D_SAMPLER(_Height, _MainTex, IN.uv_MainTex).r + _HeightmapBlending;
            
            fixed4 c2 = UNITY_SAMPLE_TEX2D_SAMPLER(_MainTex2, _MainTex, IN.uv_MainTex2);
            float3 n2 = UnpackNormal(UNITY_SAMPLE_TEX2D_SAMPLER(_BumpMap2, _MainTex, IN.uv_MainTex2));
            float4 m2 = UNITY_SAMPLE_TEX2D_SAMPLER(_MetallicRoughness2, _MainTex, IN.uv_MainTex2) 
                        * float4(_Metallic2, _Smoothness2);
            float a2 = UNITY_SAMPLE_TEX2D_SAMPLER(_AmbientOcclusion2, _MainTex, IN.uv_MainTex2).r;
            float h2 = UNITY_SAMPLE_TEX2D_SAMPLER(_Height2, _MainTex, IN.uv_MainTex2).r + _HeightmapBlending;
            
            #if THREE_LAYERS || FOUR_LAYERS
            fixed4 c3 = UNITY_SAMPLE_TEX2D_SAMPLER(_MainTex3, _MainTex, IN.uv_MainTex3);
            float3 n3 = UnpackNormal(UNITY_SAMPLE_TEX2D_SAMPLER(_BumpMap3, _MainTex, IN.uv_MainTex3));
            float4 m3 = UNITY_SAMPLE_TEX2D_SAMPLER(_MetallicRoughness3, _MainTex, IN.uv_MainTex3) 
                        * float4(_Metallic3, _Smoothness3);
            float a3 = UNITY_SAMPLE_TEX2D_SAMPLER(_AmbientOcclusion3, _MainTex, IN.uv_MainTex3).r;
            float h3 = UNITY_SAMPLE_TEX2D_SAMPLER(_Height3, _MainTex, IN.uv_MainTex3).r + _HeightmapBlending;
            #endif
            
            #if FOUR_LAYERS
            fixed4 c4 = UNITY_SAMPLE_TEX2D_SAMPLER(_MainTex4, _MainTex, IN.uv_MainTex4);
            float3 n4 = UnpackNormal(UNITY_SAMPLE_TEX2D_SAMPLER(_BumpMap4, _MainTex, IN.uv_MainTex4));
            float4 m4 = UNITY_SAMPLE_TEX2D_SAMPLER(_MetallicRoughness4, _MainTex, IN.uv_MainTex4) 
                        * float4(_Metallic4, _Smoothness4);
            float a4 = UNITY_SAMPLE_TEX2D_SAMPLER(_AmbientOcclusion4, _MainTex, IN.uv_MainTex4).r;
            float h4 = UNITY_SAMPLE_TEX2D_SAMPLER(_Height4, _MainTex, IN.uv_MainTex4).r + _HeightmapBlending;
            #endif
            
            #if FOUR_LAYERS
            float4 ms = heightblend(m1, h1 * vc.r, m2, h2 * vc.g, m3, h3 * vc.b, m4, h4 * vc.a);
            #elif THREE_LAYERS
            float4 ms = heightblend(m1, h1 * vc.r, m2, h2 * vc.g, m3, h3 * vc.b);
            #else
            float4 ms = heightblend(m1, h1 * vc.r, m2, h2 * vc.g);
            #endif
            
            #if FOUR_LAYERS
            o.Albedo = heightblend(c1.rgb, h1 * vc.r, c2.rgb, h2 * vc.g, c3.rgb, h3 * vc.b, c4.rgb, h4 * vc.a);
            #elif THREE_LAYERS
            o.Albedo = heightblend(c1.rgb, h1 * vc.r, c2.rgb, h2 * vc.g, c3.rgb, h3 * vc.b);
            #else
            o.Albedo = heightblend(c1.rgb, h1 * vc.r, c2.rgb, h2 * vc.g);
            #endif
            
            #if FOUR_LAYERS
            o.Normal = heightblend(n1, h1 * vc.r, n2, h2 * vc.g, n3, h3 * vc.b, n4, h4 * vc.a);
            #elif THREE_LAYERS
            o.Normal = heightblend(n1, h1 * vc.r, n2, h2 * vc.g, n3, h3 * vc.b);
            #else
            o.Normal = heightblend(n1, h1 * vc.r, n2, h2 * vc.g);
            #endif
            
            o.Specular = ms.rgb;
            o.Smoothness = ms.a;
            
            #if FOUR_LAYERS
            o.Occlusion = heightblend(a1, h1 * vc.r, a2, h2 * vc.g, a3, h3 * vc.b, a4, h4 * vc.a);
            #elif THREE_LAYERS
            o.Occlusion = heightblend(a1, h1 * vc.r, a2, h2 * vc.g, a3, h3 * vc.b);
            #else
            o.Occlusion = heightblend(a1, h1 * vc.r, a2, h2 * vc.g);
            #endif
            
            o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
    CustomEditor "Valax321.BlendableStandard.Editor.SpecularBlendableEditor"
}
