using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Valax321.BlendableStandard.Editor
{
    public class MetallicBlendableEditor : BaseBlendableEditor
    {
        protected override MaterialType GetMaterialType()
        {
            return MaterialType.Metallic;
        }
    }
}