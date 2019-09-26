// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Grass"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Color1("Color 1", Color) = (0,0,0,0)
		_Color2("Color 2", Color) = (0,0,0,0)
		_Color0("Color 0", Color) = (0,0,0,0)
		_Float1("Float 1", Float) = 1
		_Float4("Float 4", Float) = 1
		_Tile("Tile", Float) = 1
		_Float0("Float 0", Range( -1 , 1)) = 0
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_WAves("WAves", Float) = 12
		_SinSpeed("SinSpeed", Float) = 1
		_NoiseP("NoiseP", Range( 0 , 1)) = 0.1
		_Sway("Sway", Float) = 1
		_SinPower("SinPower", Float) = 1.24
		_Noise_2_Add("Noise_2_Add", Float) = 0
		_TopGrass("TopGrass", Float) = 0
		_Ring_Burst("Ring_Burst", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform float4 _Color1;
		uniform float4 _Color0;
		uniform float4 _Color2;
		uniform sampler2D _TextureSample1;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _SinSpeed;
		uniform float _WAves;
		uniform float _SinPower;
		uniform float _Ring_Burst;
		uniform float _Float4;
		uniform float _Noise_2_Add;
		uniform float _TopGrass;
		uniform float _Float0;
		uniform float _Sway;
		uniform sampler2D _TextureSample2;
		uniform float _Float1;
		uniform float _NoiseP;
		uniform float _Tile;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 lerpResult22 = lerp( _Color1 , _Color0 , i.vertexColor.r);
			float2 uv0_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float mulTime14 = _Time.y * _SinSpeed;
			float temp_output_13_0 = sin( ( ( uv0_TextureSample0.y + mulTime14 ) * _WAves ) );
			float temp_output_107_0 = ( 1.0 - length( (float2( -1,-1 ) + (i.uv_texcoord - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) );
			float temp_output_113_0 = ( saturate( ( saturate( sin( ( ( temp_output_107_0 + _Time.y ) * 4.0 ) ) ) * ( temp_output_107_0 + -0.18 ) ) ) * _Ring_Burst );
			float3 ase_worldPos = i.worldPos;
			float2 temp_output_18_0 = (ase_worldPos).xz;
			float2 panner49 = ( ( ( i.vertexColor.r + ( temp_output_13_0 * _SinPower ) ) - temp_output_113_0 ) * float2( 0.05,0.05 ) + ( temp_output_18_0 / _Float4 ));
			float temp_output_78_0 = saturate( ( tex2D( _TextureSample1, panner49 ).r + _Noise_2_Add ) );
			float temp_output_69_0 = saturate( ( temp_output_78_0 * ( temp_output_13_0 + 2.0 ) ) );
			float temp_output_48_0 = saturate( ( ( i.vertexColor.r * temp_output_69_0 ) + _TopGrass ) );
			float4 lerpResult42 = lerp( lerpResult22 , _Color2 , temp_output_48_0);
			o.Emission = lerpResult42.rgb;
			o.Alpha = 1;
			float mulTime56 = _Time.y * _Sway;
			float2 panner41 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + ( temp_output_18_0 / _Float1 ));
			float2 panner8 = ( sin( ( i.vertexColor.r + mulTime56 + ( tex2D( _TextureSample2, panner41 ).r * _NoiseP ) ) ) * float2( 0.01,0.01 ) + ( temp_output_18_0 / _Tile ));
			clip( saturate( ( ( ( ( 1.0 - i.vertexColor.r ) + _Float0 ) - temp_output_113_0 ) + ( tex2D( _TextureSample0, panner8 ).r * temp_output_78_0 ) ) ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
2174;116;1544;922;2237.059;-138.9391;1.6;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;91;-1939.804,3.8363;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;92;-1720.015,148.7177;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;93;-1625.969,157.2779;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;107;-1512.686,158.6112;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;103;-1266.772,278.3308;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2237.78,1155.612;Float;False;Property;_SinSpeed;SinSpeed;12;0;Create;True;0;0;False;0;1;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;102;-1086.143,211.0224;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-1038.133,353.9266;Float;False;Constant;_Float2;Float 2;18;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-2233.618,65.15881;Float;True;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;14;-2011.409,1183.87;Float;False;1;0;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;-930.2335,225.5266;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2069.291,1354.991;Float;False;Property;_WAves;WAves;11;0;Create;True;0;0;False;0;12;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;65;-1826.731,997.8771;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;101;-846.8376,321.9153;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;-1428.351,310.3646;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;-0.18;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;110;-793.457,487.5526;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1612.305,1325.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;12;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1388.088,1913.012;Float;False;Property;_SinPower;SinPower;15;0;Create;True;0;0;False;0;1.24;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;-798.0065,745.3625;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;13;-1171.817,1390.118;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;118;-580.0106,924.7703;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-952.4561,1441.885;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;17;-2361.409,295.8307;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;114;-1086.104,1253.159;Float;False;Property;_Ring_Burst;Ring_Burst;18;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;1;-1581.69,-94.95736;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;18;-2052.127,358.3053;Float;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;-541.8648,1165.011;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-712.9044,1094.16;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1180.527,1271.651;Float;False;Property;_Float4;Float 4;7;0;Create;True;0;0;False;0;1;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1737.17,740.1531;Float;False;Property;_Float1;Float 1;6;0;Create;True;0;0;False;0;1;5.37;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;27;-1519.33,620.6926;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;60;-906.9009,1164.161;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;115;-401.1334,1218.579;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;41;-1512.052,798.8739;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;49;-393.9624,993.1387;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.05;False;1;FLOAT;0.1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1310.305,605.0238;Float;False;Property;_Sway;Sway;14;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-119.7621,1188.653;Float;False;Property;_Noise_2_Add;Noise_2_Add;16;0;Create;True;0;0;False;0;0;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-218.8595,912.9999;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;c1c450ff57756174e805bb983e2b22d1;c9df5638d4b75fb42be4bf1f3192b838;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;39;-1223.709,1051.321;Float;False;Property;_NoiseP;NoiseP;13;0;Create;True;0;0;False;0;0.1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;26;-1622.024,982.1807;Float;True;Property;_TextureSample2;Texture Sample 2;10;0;Create;True;0;0;False;0;cce9823101782c049bcbd48c986f413f;cce9823101782c049bcbd48c986f413f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;77;199.0734,958.5836;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1125.301,788.0109;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;56;-1147.104,620.0214;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-233.9374,1492.445;Float;False;Constant;_2;2;15;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1904.565,507.6541;Float;False;Property;_Tile;Tile;8;0;Create;True;0;0;False;0;1;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-41.42559,1365.528;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;19;-1599.475,494.1582;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-994.6375,789.2399;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;78;287.3452,886.6078;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;58;-541.2383,591.55;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;408.406,1058.372;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;104;-759.0675,302.4201;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;5;-464.8325,61.32376;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;69;476.0806,919.2041;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-583.2142,131.3433;Float;False;Property;_Float0;Float 0;9;0;Create;True;0;0;False;0;0;-0.321;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;8;-589.4185,235.8256;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-283.0881,62.2767;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-392.7829,315.3234;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;c1c450ff57756174e805bb983e2b22d1;cb6267f8d3ea513448ac3cfd66675958;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;46;-1285.615,-82.26038;Float;False;Property;_TopGrass;TopGrass;17;0;Create;True;0;0;False;0;0;-0.36;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-808.941,-21.35986;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-564.7601,-414.8426;Float;False;Property;_Color0;Color 0;5;0;Create;True;0;0;False;0;0,0,0,0;0.4376665,0.735849,0.4061054,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;-285.2744,-527.3928;Float;False;Property;_Color1;Color 1;3;0;Create;True;0;0;False;0;0,0,0,0;0.1747508,0.3113208,0.2237088,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;36.50311,458.67;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-1104.983,-216.882;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;116;-271.5333,199.3798;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-12.44359,253.108;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;22;-157.6968,-332.048;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;48;-794.2658,-200.4386;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;43;23.16446,-334.0633;Float;False;Property;_Color2;Color 2;4;0;Create;True;0;0;False;0;0,0,0,0;0.8213191,1,0.5137255,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;76;-615.386,-136.0709;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;51;-988.5972,2017.379;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;68;436.0908,788.1271;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;42;403.1206,-142.0719;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;7;150.9541,291.7079;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;82;-742.5934,1699.283;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;81;-554.1702,1658.088;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;83;-348.3885,1811.788;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;20.25578,-132.2729;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;75;598.694,849.7087;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;64;-1016.418,868.5928;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;-809.3881,1774.583;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;700.38,-100.267;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Grass;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;92;0;91;0
WireConnection;93;0;92;0
WireConnection;107;0;93;0
WireConnection;102;0;107;0
WireConnection;102;1;103;0
WireConnection;14;0;35;0
WireConnection;111;0;102;0
WireConnection;111;1;112;0
WireConnection;65;0;3;2
WireConnection;65;1;14;0
WireConnection;101;0;111;0
WireConnection;96;0;107;0
WireConnection;110;0;101;0
WireConnection;33;0;65;0
WireConnection;33;1;34;0
WireConnection;117;0;110;0
WireConnection;117;1;96;0
WireConnection;13;0;33;0
WireConnection;118;0;117;0
WireConnection;86;0;13;0
WireConnection;86;1;50;0
WireConnection;18;0;17;0
WireConnection;88;0;1;1
WireConnection;88;1;86;0
WireConnection;113;0;118;0
WireConnection;113;1;114;0
WireConnection;27;0;18;0
WireConnection;27;1;28;0
WireConnection;60;0;18;0
WireConnection;60;1;61;0
WireConnection;115;0;88;0
WireConnection;115;1;113;0
WireConnection;41;0;27;0
WireConnection;49;0;60;0
WireConnection;49;1;115;0
WireConnection;9;1;49;0
WireConnection;26;1;41;0
WireConnection;77;0;9;1
WireConnection;77;1;63;0
WireConnection;38;0;26;1
WireConnection;38;1;39;0
WireConnection;56;0;55;0
WireConnection;74;0;13;0
WireConnection;74;1;71;0
WireConnection;19;0;18;0
WireConnection;19;1;20;0
WireConnection;57;0;1;1
WireConnection;57;1;56;0
WireConnection;57;2;38;0
WireConnection;78;0;77;0
WireConnection;58;0;57;0
WireConnection;62;0;78;0
WireConnection;62;1;74;0
WireConnection;104;0;19;0
WireConnection;5;0;1;1
WireConnection;69;0;62;0
WireConnection;8;0;104;0
WireConnection;8;1;58;0
WireConnection;23;0;5;0
WireConnection;23;1;24;0
WireConnection;2;1;8;0
WireConnection;89;0;1;1
WireConnection;89;1;69;0
WireConnection;10;0;2;1
WireConnection;10;1;78;0
WireConnection;47;0;89;0
WireConnection;47;1;46;0
WireConnection;116;0;23;0
WireConnection;116;1;113;0
WireConnection;6;0;116;0
WireConnection;6;1;10;0
WireConnection;22;0;21;0
WireConnection;22;1;11;0
WireConnection;22;2;1;1
WireConnection;48;0;47;0
WireConnection;76;0;48;0
WireConnection;51;0;50;0
WireConnection;42;0;22;0
WireConnection;42;1;43;0
WireConnection;42;2;48;0
WireConnection;7;0;6;0
WireConnection;82;0;83;2
WireConnection;82;1;51;0
WireConnection;81;0;82;0
WireConnection;45;0;48;0
WireConnection;75;0;69;0
WireConnection;85;0;13;0
WireConnection;85;1;51;0
WireConnection;0;2;42;0
WireConnection;0;10;7;0
ASEEND*/
//CHKSM=BC44718F9B6B1967AA472248FB3410F54DD8F849