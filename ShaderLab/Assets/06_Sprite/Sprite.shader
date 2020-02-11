Shader "Learning/Sprite"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _Color("Tint", Color) = (1,1,1,1)
	}

    SubShader{
     
     Tags
     {
      "RenderType" = "Transparent"
      "Queue"="Transparent"
	 }

     Blend SrcAlpha OneMinusSrcAlpha
        ZWrite off
        Cull off

     Pass
     {

        

        CGPROGRAM

        #include "UnityCG.cginc"

        #pragma vertex vert
        #pragma fragment frag

        sampler2D _MainTex;
        float4 _MainTex_ST;
        fixed4 _Color;

        struct appdata{
          float4 vertex : POSITION;
          float2 uv : TEXCOORD0;
          fixed4 color : COLOR;
		};

        struct v2f{
            float4 position : SV_POSITION;
            float2 uv : TEXCOORD0;
            fixed4 color : COLOR;
		};

        v2f vert(appdata i){
            v2f o;
            o.position = UnityObjectToClipPos(i.vertex);
            o.uv = TRANSFORM_TEX(i.uv, _MainTex);
            o.color = i.color;
            return o;
		}

        fixed4 frag(v2f i) : SV_TARGET{
            fixed4 col = tex2D(_MainTex, i.uv);
            col *= _Color;
            col *= i.color;
            return col;
            }

        ENDCG
    }
}
}