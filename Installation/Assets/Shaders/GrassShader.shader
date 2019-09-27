// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GrassShader"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 1
		_Grass1("Grass1", Color) = (0.3285422,0.6509434,0.4197545,0)
		_Grass2("Grass2", Color) = (0.3285422,0.6509434,0.4197545,0)
		_Float5("Float 5", Float) = 0
		_RTCam("RTCam", 2D) = "white" {}
		_SmallVal("SmallVal", Float) = 0.001
		_BendStrenght("BendStrenght", Float) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
			float2 uv_texcoord;
		};

		uniform float _SmallVal;
		uniform sampler2D _RTCam;
		uniform float3 RTCameraPosition;
		uniform float RTCameraSize;
		uniform float _BendStrenght;
		uniform float _Float5;
		uniform float4 _Grass1;
		uniform float4 _Grass2;
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
			float temp_output_131_0 = ( length( appendResult125 ) * _BendStrenght );
			float temp_output_134_0 = max( temp_output_131_0 , 0.0 );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_105_0 = saturate( ( ( _Float5 * ase_worldPos.y ) * 1.0 ) );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 rotatedValue137 = RotateAroundAxis( float3( 0,0,0 ), ase_vertex3Pos, normalize( cross( worldToObjDir129 , float3( 0,0,-1 ) ) ), ( temp_output_134_0 * temp_output_105_0 ) );
			float3 temp_output_140_0 = ( rotatedValue137 - ase_vertex3Pos );
			v.vertex.xyz += temp_output_140_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 lerpResult178 = lerp( _Grass1 , _Grass2 , i.uv_texcoord.y);
			o.Emission = lerpResult178.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
291;590;1130;469;-4747.248;-528.0482;1.736157;True;False
Node;AmplifyShaderEditor.Vector3Node;163;1634.574,476.865;Float;False;Global;RTCameraPosition;RTCameraPosition;16;0;Create;True;0;0;False;0;0,0,0;0,60,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;160;1668.398,217.7995;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;164;2015.608,512.5734;Float;False;Global;RTCameraSize;RTCameraSize;16;0;Create;True;0;0;False;0;0;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;162;1936.075,441.1647;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;161;1954.274,242.2651;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;158;2212.974,343.6649;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;159;2302.674,519.165;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;157;2609.474,632.2649;Float;False;Constant;_Float7;Float 7;16;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;156;2392.375,368.3649;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;155;2738.174,516.5649;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;65;2937.362,469.0483;Float;True;Property;_RTCam;RTCam;9;0;Create;True;0;0;False;0;93f4d44097a19484b94d476c6520f793;ea7dceeec9a34cb45838ce93f1b9ebec;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;125;3327.333,522.8494;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;127;3432.255,447.604;Float;False;Property;_SmallVal;SmallVal;12;0;Create;True;0;0;False;0;0.001;0.001;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;102;2930.656,1863.228;Float;True;Property;_Float5;Float 5;8;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;176;3128.896,2017.065;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;175;3594.324,2050.377;Float;False;Constant;_Float8;Float 8;17;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;3693.232,912.9476;Float;False;Property;_BendStrenght;BendStrenght;14;0;Create;True;0;0;False;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;126;3671.869,533.7751;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LengthOpNode;130;3609.404,715.769;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;3600.925,1559.565;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;128;3827.041,509.5334;Float;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;3980.035,952.8547;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;3976.694,1716.92;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;134;4152.853,1210.479;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;105;4128.743,1645.635;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;129;4101.514,570.2028;Float;False;World;Object;True;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;139;4757.626,1242.065;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CrossProductOpNode;138;4661.153,904.2158;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,-1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;4508.557,1474.589;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;180;4594.893,583.6377;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;18;4143.821,-68.43575;Float;False;Property;_Grass1;Grass1;5;0;Create;True;0;0;False;0;0.3285422,0.6509434,0.4197545,0;0.05833926,0.2169811,0.1031172,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotateAboutAxisNode;137;4918.576,961.0284;Float;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;179;4339.566,374.7915;Float;False;Property;_Grass2;Grass2;6;0;Create;True;0;0;False;0;0.3285422,0.6509434,0.4197545,0;0.5375618,0.7529412,0.4313726,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;2556.951,134.4857;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;1999.824,-80.93404;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;178;4896.971,417.2439;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;150;3728.52,1733.691;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;141;3319.865,1148.769;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;104;3451.268,1843.987;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;3999.375,1316.121;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;4343.803,1117.38;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;6;5958.104,2087.706;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;135;4371.31,934.5589;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;81;2856.168,-100.7922;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;87;2721.507,1708.88;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;2223.608,1762.88;Float;False;Property;_Float4;Float 4;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;149;4218.172,1765.884;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NormalizeNode;144;3723.85,1180.966;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;143;3572.136,1172.478;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;4;5651.471,1854.2;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;5400.384,1579.403;Float;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;14;5257.708,1786.676;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;3;5025.415,1345.608;Float;True;Property;_Wind;Wind;7;0;Create;True;0;0;False;0;d1bae21a991465043b8e51c73a668fe9;419ad6d27aeb70d409d4006b81b37996;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ComponentMaskNode;12;4989.94,1661.346;Float;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;20;5073.873,1888.328;Float;False;Property;_Speed;Speed;16;0;Create;True;0;0;False;0;0,0,0,0;0.1,0.1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;4962.791,1808.913;Float;False;Property;_Tile;Tile;13;0;Create;True;0;0;False;0;0;55;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;11;4437.942,1959.881;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;185;5910.461,916.7889;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;2;5640.1,1446.153;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;184;6040.231,1556.408;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;182;5988.046,1403.792;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;6005.426,1806.198;Float;False;Property;_Deform;Deform;15;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;6282.532,1470.899;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;140;5300.868,959.1806;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;21;5258.759,2062.156;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;6539.668,1515.15;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;69;1303.329,-20.48895;Float;False;Property;_Float3;Float 3;10;0;Create;True;0;0;False;0;0;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;6048.731,589.9837;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;GrassShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;1;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;162;0;163;1
WireConnection;162;1;163;3
WireConnection;161;0;160;1
WireConnection;161;1;160;3
WireConnection;158;0;161;0
WireConnection;158;1;162;0
WireConnection;159;0;164;0
WireConnection;156;0;158;0
WireConnection;156;1;159;0
WireConnection;155;0;156;0
WireConnection;155;1;157;0
WireConnection;65;1;155;0
WireConnection;125;0;65;1
WireConnection;125;2;65;2
WireConnection;126;0;127;0
WireConnection;126;1;125;0
WireConnection;130;0;125;0
WireConnection;177;0;102;0
WireConnection;177;1;176;2
WireConnection;128;0;126;0
WireConnection;131;0;130;0
WireConnection;131;1;132;0
WireConnection;174;0;177;0
WireConnection;174;1;175;0
WireConnection;134;0;131;0
WireConnection;105;0;174;0
WireConnection;129;0;128;0
WireConnection;138;0;129;0
WireConnection;170;0;134;0
WireConnection;170;1;105;0
WireConnection;137;0;138;0
WireConnection;137;1;170;0
WireConnection;137;3;139;0
WireConnection;68;0;69;0
WireConnection;178;0;18;0
WireConnection;178;1;179;0
WireConnection;178;2;180;2
WireConnection;150;0;104;0
WireConnection;104;0;176;2
WireConnection;104;1;102;0
WireConnection;148;0;144;0
WireConnection;136;0;134;0
WireConnection;136;1;105;0
WireConnection;135;0;129;0
WireConnection;135;1;131;0
WireConnection;81;0;18;0
WireConnection;87;1;88;0
WireConnection;149;0;148;0
WireConnection;149;1;105;0
WireConnection;144;0;143;0
WireConnection;143;0;141;0
WireConnection;4;0;14;0
WireConnection;4;2;21;0
WireConnection;1;2;3;0
WireConnection;14;0;12;0
WireConnection;14;1;13;0
WireConnection;12;0;11;0
WireConnection;185;0;140;0
WireConnection;185;1;15;0
WireConnection;2;0;3;0
WireConnection;2;1;4;0
WireConnection;184;0;2;2
WireConnection;182;0;2;1
WireConnection;22;0;182;0
WireConnection;22;1;184;0
WireConnection;140;0;137;0
WireConnection;140;1;139;0
WireConnection;21;0;20;1
WireConnection;21;1;20;2
WireConnection;15;0;22;0
WireConnection;15;1;17;0
WireConnection;15;2;105;0
WireConnection;0;2;178;0
WireConnection;0;11;140;0
ASEEND*/
//CHKSM=64A6E1F07D008EEC7E4A2514B991D80B2B313760