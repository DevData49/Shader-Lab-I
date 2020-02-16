Shader "DevData/08_Interpolator_adv"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_SecondaryTex("Secondary Texture", 2D) = "black" {}
		_BlendTex("Blend Texture", 2D) = "grey" {}
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

			sampler2D _SecondaryTex;
			float4 _SecondaryTex_ST;

			sampler2D _BlendTex;
			float4 _BlendTex_ST;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata i)
			{
				v2f o;
				o.position  = UnityObjectToClipPos(i.vertex);
				o.uv = i.uv;
				return o;
			}

			fixed4 frag(v2f i): SV_TARGET
			{
				float2 mainUV = TRANSFORM_TEX(i.uv, _MainTex);
				float2 secondaryUV = TRANSFORM_TEX(i.uv,_SecondaryTex);
				float2 blendUV = TRANSFORM_TEX(i.uv, _BlendTex);

				fixed4 mainCol = tex2D(_MainTex, mainUV);
				fixed4 secondaryCol = tex2D(_SecondaryTex, secondaryUV);
				fixed4 blendCol = tex2D(_BlendTex, blendUV);
				
				float4 blend = blendCol.r;

				return lerp(mainCol, secondaryCol, blend);

			}

			

			ENDCG
		}
	}
}
