Shader "DevData/PlannarMapping"
{
	Properties
	{
		_Color("Tint", Color) = (0,0,0,1)
		_MainTex("Main Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags
		{
			"RenderType"="Opaque"
			"Queue"="Geometry"
		}

		Pass{
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert
			#pragma fragment frag

			fixed4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST;

			struct appdata{
				float4 vertex : POSITION;
			};

			struct v2f{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata i){
				v2f o;
				o.position = UnityObjectToClipPos(i.vertex);
				float4 worldPos = mul(unity_ObjectToWorld, i.vertex);
				o.uv = TRANSFORM_TEX(worldPos.xz, _MainTex);
				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET{
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= _Color;
				return col;
			}

			ENDCG
		}
	}
}