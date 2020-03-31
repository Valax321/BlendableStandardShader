using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace Valax321.BlendableStandard.Editor
{
    public abstract class BaseBlendableEditor : ShaderGUI
    {
        private const string k_editorPrefsPrefix = "Valax321:BlendableStandard:ShaderGUI:";
        
        #region Shader Properties

        private const string k_heightBlend = "_HeightmapBlending";
        
        private const string k_mainTex = "_MainTex";
        private const string k_mainTex2 = "_MainTex2";
        private const string k_mainTex3 = "_MainTex3";
        private const string k_mainTex4 = "_MainTex4";

        private const string k_bumpMap = "_BumpMap";
        private const string k_bumpMap2 = "_BumpMap2";
        private const string k_bumpMap3 = "_BumpMap3";
        private const string k_bumpMap4 = "_BumpMap4";

        private const string k_smoothness = "_MetallicRoughness";
        private const string k_smoothness2 = "_MetallicRoughness2";
        private const string k_smoothness3 = "_MetallicRoughness3";
        private const string k_smoothness4 = "_MetallicRoughness4";

        private const string k_ao = "_AmbientOcclusion";
        private const string k_ao2 = "_AmbientOcclusion2";
        private const string k_ao3 = "_AmbientOcclusion3";
        private const string k_ao4 = "_AmbientOcclusion4";

        private const string k_height = "_Height";
        private const string k_height2 = "_Height2";
        private const string k_height3 = "_Height3";
        private const string k_height4 = "_Height4";

        private const string k_metallicF = "_Metallic";
        private const string k_metallicF2 = "_Metallic2";
        private const string k_metallicF3 = "_Metallic3";
        private const string k_metallicF4 = "_Metallic4";

        private const string k_smoothnessF = "_Smoothness";
        private const string k_smoothnessF2 = "_Smoothness2";
        private const string k_smoothnessF3 = "_Smoothness3";
        private const string k_smoothnessF4 = "_Smoothness4";

        private const string k_3Layers = "THREE_LAYERS";
        private const string k_4Layers = "FOUR_LAYERS";
        
        #endregion

        protected enum MaterialType
        {
            Metallic,
            Specular
        }

        private class Styles
        {
            public static readonly GUIContent LayerHeading = new GUIContent("Layer Setup");
            public static readonly GUIContent Layer1Header = new GUIContent("Layer 1");
            public static readonly GUIContent Layer2Header = new GUIContent("Layer 2");
            public static readonly GUIContent Layer3Header = new GUIContent("Layer 3");
            public static readonly GUIContent Layer4Header = new GUIContent("Layer 4");
            
            public static readonly GUIContent MainPropsHeading = new GUIContent("Layer Properties");
            public static readonly GUIContent LayerCount = new GUIContent("Layers", "Compiles shader variants for the given number of layers. Set this to the lowest number you use for improved performance");
            public static readonly GUIContent LayerBlend = new GUIContent("Blend Factor", "Sharpness of blending between the layers.");
            
            public static readonly GUIContent MainTex = new GUIContent("Base Color (RGB)");
            public static readonly GUIContent BumpMap = new GUIContent("Normal Map");
            public static readonly GUIContent MetallicSmoothnessTex = new GUIContent("Metallic Smoothness", "Metallic (R), Smoothness (A)");
            public static readonly GUIContent SpecularSmoothnessTex = new GUIContent("Specular Smoothness", "Specular (RGB), Smoothness (A)");
            public static readonly GUIContent AmbientOcclusionTex = new GUIContent("Ambient Occlusion", "Ambient Occlusion (R)");
            public static readonly GUIContent MetallicF = new GUIContent("Metallic");
            public static readonly GUIContent SpecularF = new GUIContent("Specular Color");
            public static readonly GUIContent SmoothnessF = new GUIContent("Smoothness");
            public static readonly GUIContent Height = new GUIContent("Height Map (R)");
            
            public static readonly GUIContent AdvancedProperties = new GUIContent("Advanced Properties");
        }

        #region Material Properties

        private MaterialProperty m_heightBlend;

        private MaterialProperty m_mainTex;
        private MaterialProperty m_mainTex2;
        private MaterialProperty m_mainTex3;
        private MaterialProperty m_mainTex4;

        private MaterialProperty m_bumpMap;
        private MaterialProperty m_bumpMap2;
        private MaterialProperty m_bumpMap3;
        private MaterialProperty m_bumpMap4;

        private MaterialProperty m_smoothness;
        private MaterialProperty m_smoothness2;
        private MaterialProperty m_smoothness3;
        private MaterialProperty m_smoothness4;

        private MaterialProperty m_ao;
        private MaterialProperty m_ao2;
        private MaterialProperty m_ao3;
        private MaterialProperty m_ao4;

        private MaterialProperty m_height;
        private MaterialProperty m_height2;
        private MaterialProperty m_height3;
        private MaterialProperty m_height4;

        private MaterialProperty m_metallicF;
        private MaterialProperty m_metallicF2;
        private MaterialProperty m_metallicF3;
        private MaterialProperty m_metallicF4;

        private MaterialProperty m_smoothnessF;
        private MaterialProperty m_smoothnessF2;
        private MaterialProperty m_smoothnessF3;
        private MaterialProperty m_smoothnessF4;
        
        #endregion

        private int GetLayerCount(Material mat)
        {
            if (!mat)
                return 4;
            
            if (mat.IsKeywordEnabled(k_4Layers))
                return 4;
            else if (mat.IsKeywordEnabled(k_3Layers))
                return 3;
            else 
                return 2;
        }

        private void SetLayerCount(Material mat, int count)
        {
            if (!mat)
                return;
            
            mat.DisableKeyword(k_3Layers);
            mat.DisableKeyword(k_4Layers);

            if (count >= 3)
            {
                mat.EnableKeyword(k_3Layers);
            }
            if (count >= 4)
            {
                mat.EnableKeyword(k_4Layers);
            }
        }
        
        protected abstract MaterialType GetMaterialType();

        private void PopulateMaterialProperties(MaterialProperty[] props)
        {
            m_heightBlend = FindProperty(k_heightBlend, props);

            m_mainTex = FindProperty(k_mainTex, props);
            m_mainTex2 = FindProperty(k_mainTex2, props);
            m_mainTex3 = FindProperty(k_mainTex3, props);
            m_mainTex4 = FindProperty(k_mainTex4, props);

            m_bumpMap = FindProperty(k_bumpMap, props);
            m_bumpMap2 = FindProperty(k_bumpMap2, props);
            m_bumpMap3 = FindProperty(k_bumpMap3, props);
            m_bumpMap4 = FindProperty(k_bumpMap4, props);

            m_smoothness = FindProperty(k_smoothness, props);
            m_smoothness2 = FindProperty(k_smoothness2, props);
            m_smoothness3 = FindProperty(k_smoothness3, props);
            m_smoothness4 = FindProperty(k_smoothness4, props);

            m_ao = FindProperty(k_ao, props);
            m_ao2 = FindProperty(k_ao2, props);
            m_ao3 = FindProperty(k_ao3, props);
            m_ao4 = FindProperty(k_ao4, props);

            m_height = FindProperty(k_height, props);
            m_height2 = FindProperty(k_height2, props);
            m_height3 = FindProperty(k_height3, props);
            m_height4 = FindProperty(k_height4, props);

            m_metallicF = FindProperty(k_metallicF, props);
            m_metallicF2 = FindProperty(k_metallicF2, props);
            m_metallicF3 = FindProperty(k_metallicF3, props);
            m_metallicF4 = FindProperty(k_metallicF4, props);

            m_smoothnessF = FindProperty(k_smoothnessF, props);
            m_smoothnessF2 = FindProperty(k_smoothnessF2, props);
            m_smoothnessF3 = FindProperty(k_smoothnessF3, props);
            m_smoothnessF4 = FindProperty(k_smoothnessF4, props);
        }

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            if (m_mainTex == null)
                PopulateMaterialProperties(properties);

            DrawProperties(materialEditor);
        }

        private void DrawLayerCount(MaterialEditor editor)
        {
            int layers = GetLayerCount(editor.target as Material);
            EditorGUILayout.PrefixLabel(Styles.LayerCount);
            var newLayers = GUILayout.Toolbar(layers - 2, new string[] {"2", "3", "4"});
            if (newLayers != layers - 2)
                SetLayerCount(editor.target as Material, newLayers + 2);
        }

        private void DrawProperties(MaterialEditor editor)
        {
            EditorGUI.BeginChangeCheck();

            EditorGUILayout.LabelField(Styles.MainPropsHeading, EditorStyles.boldLabel);
            editor.FloatProperty(m_heightBlend, Styles.LayerBlend.text);
            DrawLayerCount(editor);

            EditorGUILayout.Separator();

            EditorGUILayout.LabelField(Styles.LayerHeading, EditorStyles.boldLabel);
            int layerCount = GetLayerCount(editor.target as Material);
            
            // Layer 1
            DrawLayer(Styles.Layer1Header, editor, m_mainTex, m_bumpMap, 
                m_smoothness, m_ao, m_metallicF, m_smoothnessF, m_height, "layer1");
            // Layer 2
            DrawLayer(Styles.Layer2Header, editor, m_mainTex2, m_bumpMap2, 
                m_smoothness2, m_ao2, m_metallicF2, m_smoothnessF2, m_height2, "layer2");
            // Layer 3
            if (layerCount >= 3)
            {
                DrawLayer(Styles.Layer3Header, editor, m_mainTex3, m_bumpMap3, 
                    m_smoothness3, m_ao3, m_metallicF3, m_smoothnessF3, m_height3, "layer3");
            }
            // Layer 4
            if (layerCount >= 4)
            {
                DrawLayer(Styles.Layer4Header, editor, m_mainTex4, m_bumpMap4, 
                    m_smoothness4, m_ao4, m_metallicF4, m_smoothnessF4, m_height4, "layer4");
            }
            
            EditorGUILayout.Separator();

            EditorGUILayout.LabelField(Styles.AdvancedProperties, EditorStyles.boldLabel);
            editor.EnableInstancingField();
            editor.DoubleSidedGIField();

            EditorGUI.EndChangeCheck();
        }

        private void DrawLayer(GUIContent header, MaterialEditor editor, MaterialProperty mainTex, MaterialProperty bump,
            MaterialProperty smoothness, MaterialProperty ao, MaterialProperty metallicF, MaterialProperty smoothnessF, MaterialProperty height, string prefsName)
        {
            bool state = EditorPrefs.GetBool(k_editorPrefsPrefix + prefsName, true);
            state = EditorGUILayout.BeginFoldoutHeaderGroup(state, header);
            if (state)
            {
                editor.TexturePropertySingleLine(Styles.MainTex, mainTex);
                editor.TexturePropertySingleLine(Styles.BumpMap, bump);
                
                if (GetMaterialType() == MaterialType.Metallic)
                {
                    editor.TexturePropertySingleLine(Styles.MetallicSmoothnessTex, smoothness);
                    EditorGUI.indentLevel++;
                    metallicF.floatValue = EditorGUILayout.Slider(Styles.MetallicF, metallicF.floatValue, metallicF.rangeLimits.x,
                        metallicF.rangeLimits.y);
                    smoothnessF.floatValue = EditorGUILayout.Slider(Styles.SmoothnessF, smoothnessF.floatValue, smoothnessF.rangeLimits.x,
                        smoothnessF.rangeLimits.y);
                    EditorGUI.indentLevel--;
                }
                else
                {
                    editor.TexturePropertySingleLine(Styles.SpecularSmoothnessTex, smoothness);
                    EditorGUI.indentLevel++;
                    editor.ColorProperty(metallicF, Styles.SpecularF.text);
                    smoothnessF.floatValue = EditorGUILayout.Slider(Styles.SmoothnessF, smoothnessF.floatValue, smoothnessF.rangeLimits.x,
                        smoothnessF.rangeLimits.y);
                    EditorGUI.indentLevel--;
                }

                editor.TexturePropertySingleLine(Styles.Height, height);
                editor.TexturePropertySingleLine(Styles.AmbientOcclusionTex, ao);
                
                editor.TextureScaleOffsetProperty(mainTex);
            }
            EditorPrefs.SetBool(k_editorPrefsPrefix + prefsName, state);
            EditorGUILayout.EndFoldoutHeaderGroup();
        }
    }
}
