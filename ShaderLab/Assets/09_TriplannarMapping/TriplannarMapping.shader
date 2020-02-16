Shader "DevData/TriplannarMapping"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_Color("Tint", Color)  = (1,1,1,1)
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

			sampler2D _MainTex;
			float4 _MainTex_ST;

			fixed4 _Color;

			struct appdata
			{
				float4 vertex :POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
				float3 worldPos : TEXCOORD0;
				float3 normal : NORMAL;
			};

			v2f vert(appdata i)
			{
				v2f o;
				o.position = UnityObjectToClipPos(i.vertex);
				o.worldPos = mul(unity_ObjectToWorld, i.vertex);
				o.normal = mul(i.normal,(float3x3)unity_WorldToObject);
				o.normal = normalize(o.normal);				
				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				float3 weights = i.normal;
				weights = abs(weights);
				weights = weights/(weights.x + weights.y + weights.z);

				float2 uv_Front = TRANSFORM_TEX(i.worldPos.xy, _MainTex);
				float2 uv_Top = TRANSFORM_TEX(i.worldPos.xz, _MainTex);
				float2 uv_Side = TRANSFORM_TEX(i.worldPos.yz, _MainTex);

				fixed4 col_Front = tex2D(_MainTex, uv_Front) * weights.z;
				fixed4 col_Top = tex2D(_MainTex, uv_Top) * weights.y;
				fixed4 col_Side = tex2D(_MainTex, uv_Side)* weights.x;

				fixed4 col = col_Front + col_Top + col_Side;

				col *= _Color;
				return col;
			}
			ENDCG
		}
	}
}
