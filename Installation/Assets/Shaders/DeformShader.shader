// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Particle"
{
	Properties
	{
		_VertexMap("VertexMap", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Transparent"="Transparent" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend One One
		Cull Back
		ColorMask RGBA
		ZWrite Off
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
			};

			uniform sampler2D _VertexMap;
			uniform float4 _VertexMap_ST;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord.xy = v.ase_texcoord.xy;
				o.ase_color = v.color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				float2 uv_VertexMap = i.ase_texcoord.xy * _VertexMap_ST.xy + _VertexMap_ST.zw;
				float4 tex2DNode2 = tex2D( _VertexMap, uv_VertexMap );
				float2 appendResult3 = (float2(tex2DNode2.r , tex2DNode2.g));
				float2 temp_cast_0 = (0.5).xx;
				
				
				finalColor = float4( ( ( ( appendResult3 - temp_cast_0 ) * 2.0 ) * tex2DNode2.a * i.ase_color.a ), 0.0 , 0.0 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17000
784;171;1130;541;1352.018;198.5873;1.673835;True;False
Node;AmplifyShaderEditor.SamplerNode;2;-799.5148,-44.93617;Float;True;Property;_VertexMap;VertexMap;0;0;Create;True;0;0;False;0;None;5c0f55e4617d25143a8574317415ea6b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;3;-412.7214,-33.51181;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-419.927,127.8292;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-268.7214,-22.51181;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-165.7214,133.4882;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-61.52143,-15.11181;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;9;-522.0779,259.6214;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;155.9012,13.86295;Float;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;338.5001,145.7;Float;False;True;2;Float;ASEMaterialInspector;0;1;Particle;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;4;1;False;-1;1;False;-1;0;1;False;-1;1;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Transparent=RenderType;Transparent=Transparent;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;1
WireConnection;3;1;2;2
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;7;0;4;0
WireConnection;7;1;6;0
WireConnection;8;0;7;0
WireConnection;8;1;2;4
WireConnection;8;2;9;4
WireConnection;1;0;8;0
ASEEND*/
//CHKSM=C2D64B9C9888D9E7E31C838644DC34A053E62225