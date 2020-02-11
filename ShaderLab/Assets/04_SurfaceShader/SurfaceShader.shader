﻿Shader "Learning/SurfaceShader"
{
    Properties{
     _MainTex("Main Texture", 2D) = "white" {}
     _Color("Color", Color) = (1,1,1,1)
     _Metallic("Metallic", Range(0,1)) = 0.2
     _Smoothness("Smoothness", Range(0,1)) = 0.4
     [HDR]_Emission("Emission", color) = (0,0,0)
	}

    SubShader{
     Tags{
      "RenderQueue"="Opaque"
      "Queue"="Geometry"
	 }

     CGPROGRAM

     #pragma surface surf Standard fullforwardshadows
     #pragma target 3.0 
     
     sampler2D _MainTex;
     fixed4 _Color ;
     half _Metallic;
     half _Smoothness;

     half3 _Emission;

     struct Input{
        float2 uv_MainTex;
	 };

     void surf(Input i, inout SurfaceOutputStandard o){
        fixed4 col = tex2D(_MainTex, i.uv_MainTex) * _Color;
        o.Albedo = col.rgb;
        o.Metallic = _Metallic;
        o.Smoothness = _Smoothness;
        o.Emission = _Emission;
	 }

     

     ENDCG
	}

    Fallback "Standard"
}
