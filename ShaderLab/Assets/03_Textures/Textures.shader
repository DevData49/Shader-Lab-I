Shader "Learning/Textures"
{
    Properties{
     _MainTex("Main Texture", 2D) = "white" {}
     _Color("Color", Color) = (1,1,1,1)
	}

    SubShader{
     Tags{
        "RenderType"="Opaque"
        "Queue"="Geometry"
	 }

     Pass{
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
	  };

      struct v2f{
        float4 position : SV_POSITION;
        float2 uv : TEXCOORD0;
	  };

      v2f vert(appdata i){
        v2f o;
        o.position = UnityObjectToClipPos(i.vertex);
        o.uv = TRANSFORM_TEX(i.uv, _MainTex);
        return o;
	  }

      fixed4 frag(v2f i): SV_TARGET{
       fixed4 col = tex2D(_MainTex,i.uv) * _Color;
       return col;
	  }

      ENDCG
	 }
	}
}
