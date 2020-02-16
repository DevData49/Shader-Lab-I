Shader "DevData/08_Interpolator_Texture"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _SecondTex("Second Texture", 2D) = "black" {}
        _Blend("Blend", Range(0,1)) = 0
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
            sampler2D _SecondTex;
            float4 _SecondTex_ST;
            float _Blend;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
			};

            struct v2f
            {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(appdata i){
                v2f o;
                o.position = UnityObjectToClipPos(i.vertex);
                o.uv = i.uv;
                return o;
			}

            fixed4 frag(v2f i) : SV_TARGET
            {
                float2 mainUV = TRANSFORM_TEX(i.uv, _MainTex);
                float2 secondaryUV = TRANSFORM_TEX(i.uv,_SecondTex);

                fixed4 mainCol = tex2D(_MainTex, mainUV);
                fixed4 secondaryCol = tex2D(_SecondTex, secondaryUV);
                
                return lerp(mainCol, secondaryCol, _Blend);
                }

            ENDCG
        }
	}
}
