// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GrassShader"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 1
		_Float5("Float 5", Float) = 0
		_RTCam("RTCam", 2D) = "white" {}
		_SmallVal("SmallVal", Float) = 0.001
		_BendStrenght("BendStrenght", Float) = 2
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _SmallVal;
		uniform sampler2D _RTCam;
		uniform float3 RTCameraPosition;
		uniform float RTCameraSize;
		uniform float _BendStrenght;
		uniform float _Float5;
		uniform float _TessValue;


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float4 transform160 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult161 = (float2(transform160.x , transform160.z));
			float2 appendResult162 = (float2(RTCameraPosition.x , RTCameraPosition.z));
			float4 tex2DNode65 = tex2Dlod( _RTCam, float4( ( ( ( appendResult161 - appendResult162 ) / ( RTCameraSize * 2.0 ) ) + 0.5 ), 0, 0.0) );
			float3 appendResult125 = (float3(tex2DNode65.r , 0.0 , tex2DNode65.g));
			float3 normalizeResult128 = normalize( ( _SmallVal + appendResult125 ) );
			float3 worldToObjDir129 = normalize( mul( unity_WorldToObject, float4( normalizeResult128, 0 ) ).xyz );
			float3 temp_output_138_0 = cross( worldToObjDir129 , float3( 0,-1,0 ) );
			float temp_output_131_0 = ( length( appendResult125 ) * _BendStrenght );
			float temp_output_134_0 = max( temp_output_131_0 , 0.0 );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_105_0 = saturate( ( ( _Float5 * ase_worldPos.y ) * 1.0 ) );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 rotatedValue137 = RotateAroundAxis( float3( 0,0,0 ), ase_vertex3Pos, normalize( temp_output_138_0 ), ( temp_output_134_0 * temp_output_105_0 ) );
			v.vertex.xyz += ( rotatedValue137 - ase_vertex3Pos );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color18 = IsGammaSpace() ? float4(0.3285422,0.6509434,0.4197545,0) : float4(0.08817505,0.3812781,0.1471363,0);
			o.Emission = color18.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
573;359;1130;481;-2536.471;-416.6082;3.271711;True;False
Node;AmplifyShaderEditor.Vector3Node;163;1634.574,476.865;Float;False;Global;RTCameraPosition;RTCameraPosition;16;0;Create;True;0;0;False;0;0,0,0;0,60,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;160;1668.398,217.7995;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;161;1954.274,242.2651;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;162;1936.075,441.1647;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;164;2015.608,512.5734;Float;False;Global;RTCameraSize;RTCameraSize;16;0;Create;True;0;0;False;0;0;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;159;2302.674,519.165;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;158;2212.974,343.6649;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;157;2609.474,632.2649;Float;False;Constant;_Float7;Float 7;16;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;156;2392.375,368.3649;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;155;2738.174,516.5649;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;65;2937.362,469.0483;Float;True;Property;_RTCam;RTCam;10;0;Create;True;0;0;False;0;93f4d44097a19484b94d476c6520f793;ea7dceeec9a34cb45838ce93f1b9ebec;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;127;3432.255,447.604;Float;False;Property;_SmallVal;SmallVal;15;0;Create;True;0;0;False;0;0.001;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;102;2930.656,1863.228;Float;True;Property;_Float5;Float 5;7;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;176;3216.211,2048.366;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;125;3472.059,560.871;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;175;3594.324,2050.377;Float;False;Constant;_Float8;Float 8;17;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;130;3609.404,715.769;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;3518.02,1971.647;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;3693.232,912.9476;Float;False;Property;_BendStrenght;BendStrenght;18;0;Create;True;0;0;False;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;126;3671.869,533.7751;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;128;3827.041,509.5334;Float;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;4020.585,1763.249;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;3980.035,952.8547;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;134;4152.853,1208.54;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;105;4128.743,1637.414;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;129;4101.514,570.2028;Float;False;World;Object;True;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;4508.557,1474.589;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;138;4661.153,904.2158;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,-1,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;139;4757.626,1242.065;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotateAboutAxisNode;137;4918.576,955.926;Float;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalVertexDataNode;103;3104.342,2205.039;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;166;3300.481,2384.63;Float;False;Property;_h;h;17;0;Create;True;0;0;False;0;0;10.92;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;33;-1083.82,1579.214;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;165;3581.771,2297.864;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;169;4152.277,2136.466;Float;True;Property;_TextureSample1;Texture Sample 1;19;0;Create;True;0;0;False;0;None;160398aae4caa334d8b056d45516e14e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;54;744.2946,1235.493;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;12;-1135.498,336.0504;Float;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;742.5658,942.6145;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;31;-1509.311,1599.027;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;96;2004.77,1105.226;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;3256.897,787.5031;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;140;5324.868,967.1805;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;51;-2702.976,1063.601;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;18;2493.185,-186.1171;Float;False;Constant;_Color0;Color 0;4;0;Create;True;0;0;False;0;0.3285422,0.6509434,0.4197545,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-725.0541,254.1068;Float;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;85;1568.39,1174.005;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;63;1323.351,282.1185;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;60;1079.424,774.7717;Float;False;Constant;_Float2;Float 2;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;49;-2326.566,1268.413;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleTimeNode;30;-1263.846,1382.588;Float;False;1;0;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;41;122.284,1023.81;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;1999.824,-80.93404;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;89;2866.507,1663.88;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectScaleNode;118;1941.981,1180.511;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;45;-1559.081,842.4414;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;754.9967,178.5075;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;167;3801.003,2291.958;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-392.5719,1271.471;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;11;-1687.497,634.5858;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCRemapNode;29;-99.06705,171.9769;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;172;4849.76,738.3562;Float;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;43;-1801.291,1161.495;Float;False;Property;_C;C;8;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;14;-867.7302,461.3806;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;92;3094.181,1187.073;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;2662.368,1128.062;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;86;1828.269,1486.876;Float;False;Property;_Vector0;Vector 0;11;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;100;2360.94,1472.438;Float;False;Property;_Height;Height;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-485.3378,120.8563;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;3999.375,1316.121;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;110;1113.171,2521.1;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;57;1373.767,1032.124;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;107;924.3994,2500.554;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;113;1699.647,2170.811;Float;False;Constant;_Float6;Float 6;6;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;84;2107.735,1469.022;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;111;1390.03,2175.465;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;37;-623.0606,1541.68;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;4;-473.9668,528.9042;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;112;1469.159,2441.02;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;144;3723.85,1180.966;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;64;1227.392,636.8195;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;108;582.9084,2498.367;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;121;2075.908,918.1941;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;307.2526,1121.264;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;10;127.3065,568.6793;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;143;3572.136,1172.478;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;88;2223.608,1762.88;Float;False;Property;_Float4;Float 4;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;87;2721.507,1708.88;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;303.7066,256.3481;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;1539.71,1919.167;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1162.648,483.6168;Float;False;Property;_Tile;Tile;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;50;-2113.766,1326.013;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector4Node;20;-1051.566,563.0321;Float;False;Property;_Speed;Speed;21;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;46;-2802.926,1421.987;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;34;-218.1307,1239.403;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;23;-228.3586,-78.64008;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;2919.365,874.5272;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;174.8387,45.93988;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;104;3451.268,1843.987;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;44;-1411.462,991.9652;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;97;2292.948,1117.855;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TFHCRemapNode;28;-70.05367,-31.83762;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;56;1007.839,1046.979;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TFHCRemapNode;123;2846.64,1346.456;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;141;3319.865,1148.769;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;53;-2573.131,951.8077;Float;False;Property;_Size;Size;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;135;4371.31,934.5589;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;3232.321,1547.426;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;47;-2495.927,1400.787;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LengthOpNode;32;-724.0484,1601.76;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;150;3626.108,2131.143;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-552.5091,1019.827;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;59;1495.247,937.1424;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;48;-2937.292,1162.365;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;98;2859.87,1188.495;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;418.5979,91.4101;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;52;-2458.395,1127.287;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;114;828.3734,2281.928;Float;False;1;0;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;120;2166.552,1336.893;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;91;2696.415,1579.751;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-380.4928,700.0198;Float;True;Property;_Float0;Float 0;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;116;2214.503,1923.15;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;673.8915,91.79337;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;23.8785,338.9766;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;81;2856.168,-100.7922;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;2556.951,134.4857;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;2611.202,1301.482;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;405.1293,417.479;Float;False;Property;_Deform;Deform;20;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;1303.329,-20.48895;Float;False;Property;_Float3;Float 3;12;0;Create;True;0;0;False;0;0;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;173;5523.37,1193.777;Float;False;Constant;_4;4;18;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;2399.472,2020.604;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;21;-866.6796,736.8604;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;3;-1100.024,20.31123;Float;True;Property;_Wind;Wind;5;0;Create;True;0;0;False;0;d1bae21a991465043b8e51c73a668fe9;d1bae21a991465043b8e51c73a668fe9;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;1305.604,489.7957;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;1236.463,203.3362;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalVertexDataNode;6;-118.1219,572.2724;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;4343.803,1117.38;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-702.1895,1276.125;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;149;4218.172,1765.884;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;109;1874.089,2138.743;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;119;2808.273,990.3436;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;90;3073.084,1655.27;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;5648.831,579.6837;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;GrassShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;1;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;161;0;160;1
WireConnection;161;1;160;3
WireConnection;162;0;163;1
WireConnection;162;1;163;3
WireConnection;159;0;164;0
WireConnection;158;0;161;0
WireConnection;158;1;162;0
WireConnection;156;0;158;0
WireConnection;156;1;159;0
WireConnection;155;0;156;0
WireConnection;155;1;157;0
WireConnection;65;1;155;0
WireConnection;125;0;65;1
WireConnection;125;2;65;2
WireConnection;130;0;125;0
WireConnection;177;0;102;0
WireConnection;177;1;176;2
WireConnection;126;0;127;0
WireConnection;126;1;125;0
WireConnection;128;0;126;0
WireConnection;174;0;177;0
WireConnection;174;1;175;0
WireConnection;131;0;130;0
WireConnection;131;1;132;0
WireConnection;134;0;131;0
WireConnection;105;0;174;0
WireConnection;129;0;128;0
WireConnection;170;0;134;0
WireConnection;170;1;105;0
WireConnection;138;0;129;0
WireConnection;137;0;138;0
WireConnection;137;1;170;0
WireConnection;137;3;139;0
WireConnection;33;0;31;0
WireConnection;165;0;103;2
WireConnection;165;1;166;0
WireConnection;169;1;167;0
WireConnection;12;0;11;0
WireConnection;58;0;57;0
WireConnection;145;1;112;0
WireConnection;140;0;137;0
WireConnection;140;1;139;0
WireConnection;51;0;48;0
WireConnection;51;1;43;0
WireConnection;1;2;3;0
WireConnection;63;0;61;0
WireConnection;63;1;61;0
WireConnection;49;0;48;0
WireConnection;49;1;47;0
WireConnection;41;0;34;0
WireConnection;68;0;69;0
WireConnection;89;0;91;0
WireConnection;15;0;22;0
WireConnection;15;1;17;0
WireConnection;167;0;165;0
WireConnection;29;0;2;2
WireConnection;172;0;138;0
WireConnection;14;0;12;0
WireConnection;14;1;13;0
WireConnection;92;2;101;0
WireConnection;106;0;97;0
WireConnection;106;1;100;0
WireConnection;2;0;3;0
WireConnection;2;1;4;0
WireConnection;148;0;144;0
WireConnection;110;0;107;0
WireConnection;57;0;56;0
WireConnection;57;2;56;1
WireConnection;107;0;108;0
WireConnection;84;0;86;0
WireConnection;84;1;85;0
WireConnection;111;0;114;0
WireConnection;111;1;112;0
WireConnection;37;0;32;0
WireConnection;4;0;14;0
WireConnection;4;2;21;0
WireConnection;112;0;110;0
WireConnection;144;0;143;0
WireConnection;64;0;40;0
WireConnection;40;0;41;0
WireConnection;40;1;37;0
WireConnection;10;0;9;0
WireConnection;143;0;141;0
WireConnection;87;0;84;0
WireConnection;87;1;88;0
WireConnection;26;0;29;0
WireConnection;26;1;10;0
WireConnection;115;0;111;0
WireConnection;115;1;113;0
WireConnection;50;0;49;0
WireConnection;46;0;43;0
WireConnection;34;0;38;0
WireConnection;23;0;2;1
WireConnection;24;0;28;0
WireConnection;24;1;10;0
WireConnection;104;0;176;2
WireConnection;104;1;102;0
WireConnection;44;0;11;0
WireConnection;44;1;43;0
WireConnection;97;0;96;0
WireConnection;28;0;2;1
WireConnection;56;0;54;0
WireConnection;123;0;101;0
WireConnection;135;0;129;0
WireConnection;135;1;131;0
WireConnection;101;0;90;0
WireConnection;47;0;46;0
WireConnection;47;1;48;2
WireConnection;47;2;46;2
WireConnection;32;0;33;0
WireConnection;150;0;104;0
WireConnection;38;0;36;0
WireConnection;38;1;39;0
WireConnection;59;0;40;0
WireConnection;59;1;54;0
WireConnection;98;0;100;0
WireConnection;98;1;100;0
WireConnection;42;0;24;0
WireConnection;42;1;40;0
WireConnection;52;0;53;0
WireConnection;52;1;51;0
WireConnection;120;0;85;0
WireConnection;120;1;86;0
WireConnection;91;0;84;0
WireConnection;91;1;88;0
WireConnection;116;0;109;0
WireConnection;22;0;24;0
WireConnection;22;1;26;0
WireConnection;9;0;6;3
WireConnection;9;1;8;0
WireConnection;81;0;18;0
WireConnection;99;0;97;1
WireConnection;99;1;100;0
WireConnection;117;0;116;0
WireConnection;117;1;112;0
WireConnection;21;0;20;1
WireConnection;21;1;20;2
WireConnection;61;0;64;0
WireConnection;61;1;10;0
WireConnection;55;0;15;0
WireConnection;55;1;63;0
WireConnection;136;0;134;0
WireConnection;136;1;105;0
WireConnection;36;0;30;0
WireConnection;36;1;37;0
WireConnection;149;0;148;0
WireConnection;149;1;105;0
WireConnection;109;0;115;0
WireConnection;90;0;117;0
WireConnection;0;2;18;0
WireConnection;0;11;140;0
ASEEND*/
//CHKSM=3ADBFF9F6FED103281B5C217EAFAEB1BDFB669E6