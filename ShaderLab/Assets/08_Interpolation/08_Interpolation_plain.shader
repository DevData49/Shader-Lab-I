Shader "DevData/08_Interpolation_plain"
{
	Properties
	{
		_Color("Color",Color) = (0,0,0,1)
		_Secondary_Color("Color", Color) = (1,1,1,1)
		_blend("blend", Range(0,1)) = 0
	}

	SubShader
	{
		Tags
		{
			"RenderType"="Opaque"
			"Queue"="Geometry"
		}

		Pass
		{
			CGPROGRAM

			#include "unityCG.cginc"

			#pragma vertex vert
			#pragma fragment frag

			fixed4 _Color;
			fixed4 _Secondary_Color;
			float _blend;

			struct appdata{
				float4 vertex : POSITION;
			};

			struct v2f{
				float4 position : SV_POSITION;
			};

			v2f vert(appdata i){
				v2f o;
				o.position = UnityObjectToClipPos(i.vertex);
				return o;
			}

			fixed4 frag(v2f i): SV_TARGET{
				fixed4 col = lerp(_Color, _Secondary_Color,_blend);
				return col;
			} 
			ENDCG
		}
	}
}
