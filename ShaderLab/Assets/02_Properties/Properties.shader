Shader "Learning/Properties"
{
    Properties{
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

            fixed4 _Color;

            struct appdata{
                float4 vertex: POSITION;
            };

            struct v2f {
                float4 position : SV_POSITION;     
			};

            v2f vert(appdata i){
                v2f o;
                o.position = UnityObjectToClipPos(i.vertex);
                return o;
			}

            fixed4 frag(v2f i): SV_TARGET{
                return _Color;     
			}

            ENDCG
		}
	}
}
