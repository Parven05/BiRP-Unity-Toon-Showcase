// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Symm/[Transparent] Cel PBR (Outline)"
{
	Properties
	{
		[Main(GroupMain, _, off, off)]_MainTexturesSettings("Main Textures & Settings", Float) = 1
		[Tex(GroupMain)][NoScaleOffset]_MainTex("Main Texture (RGB)", 2D) = "gray" {}
		[Tex(GroupMain, _NormalStrength)][Normal]_BumpMap("Normal Map", 2D) = "bump" {}
		[HideInInspector]_NormalStrength("Normal Strength", Range( 0 , 10)) = 1
		[Tex(GroupMain, _MetallicStrength)]_Metallic("Metallic (R)", 2D) = "white" {}
		[Sub(GroupMain)][HideInInspector]_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 1
		[Tex(GroupMain,_SmoothnessStrength)]_Smoothness("Smoothness (G)", 2D) = "white" {}
		[Sub(GroupMain)][HideInInspector]_SmoothnessStrength("Smoothness Strength", Range( 0 , 1)) = 1
		[Tooltip(Change tint to pure white to only show the color of the Emission map. Otherwise, make your Emission map grayscale and define overall color using the tint value.)][Tex(GroupMain, _EmissionTint)]_EmissionMap("Emission Map (RGB)", 2D) = "white" {}
		[HDR][HideInInspector]_EmissionTint("Emission Tint", Color) = (0,0,0,0)
		[Sub(GroupMain)]_EmissionMultiplier("Emission Multiplier", Range( 0 , 10)) = 1
		[Tex(GroupMain, _HeightStrength)]_ParallaxMap("Height Map (B)", 2D) = "white" {}
		[HideInInspector]_HeightStrength("Height Strength", Range( 0 , 0.1)) = 0.01
		[Tooltip(Any values less than one will darken the entire model. Adjust strength value with caution.)][Tex(GroupMain,_OcclusionStrength)]_OcclusionMap("Occlusion Map (R)", 2D) = "white" {}
		[Sub(GroupMain)][HideInInspector]_OcclusionStrength("Occlusion Strength", Range( 0 , 1)) = 1
		[Tooltip(Effects Tiling and Offset values for all textures and masks in the Main Textures and Settings section.)][Sub(GroupMain)]_TilingOffset("Tiling & Offset", Vector) = (1,1,0,0)
		[Space(10)][Main(GroupLighting, _, off, off)]_Lighting("Lighting", Float) = 1
		[Tooltip(Number of sections that lighting is cut into for Cel shading.)][Sub(GroupLighting)]_LightGradientSteps("Light Gradient Steps", Range( 1 , 12)) = 5
		[Tooltip(The position offset of the edge of shadows. 0.444 is a magic number for this.)][Sub(GroupLighting)]_LightGradientMidLevel("Light Gradient MidLevel", Range( 0 , 1)) = 0.444
		[Tooltip(A remapped scale size of shadows compared to the full attenuation of shadows.)][Sub(GroupLighting)]_LightGradientSize("Light Gradient Size", Range( 0 , 1)) = 0.493
		[Tooltip(Boosts Intensity of Point and Spot lights. Default value of 10 is a magic number, but feel free to change this value as desired.)][Sub(GroupLighting)]_PointSpotLightBoost("Point & Spot Light Boost", Range( 1 , 10)) = 10
		[Tooltip(Increases the strength of shadows. 1 is pure dark in Unlit lighting. 0.5 is magical and works well in most lighting scenarios.)][Sub(GroupLighting)]_IndirectShadowIntensity("Indirect Shadow Intensity", Range( 0 , 1)) = 0.5
		[Tooltip(Boosts the base brightness value of Ambient lighting. 1.0 works well in the majority of lighting scenarios.)][Sub(GroupLighting)]_AmbientBoost("Ambient Boost", Range( 1 , 2)) = 2
		[Tooltip(Note. Only effects lit areas of the avatar. Unlit Vertex or Ambient lit areas are uneffected. Value of 0.5 is the strongest possible shift. Set to 0 or 1 to disable. 0.872 is a magical number that looks real good.)][Sub(GroupLighting)]_HueShiftColor("Hue Shift Color", Range( 0 , 1)) = 0.872
		[Tooltip(A multiplier for how strong the Hue Shift Color changed a lit surface.)][Sub(GroupLighting)]_HueShiftStrength("Hue Shift Strength", Float) = 3.27
		[Space(10)][Main(GroupOutline, _OUTLINEENABLED, off)][Tooltip(Note, This is going to look a little whacky unless you have a good mask. That could be what you are looking for though too)]_Outline("Outline", Float) = 1
		[Tooltip(No mask means the entire model will have an outline. A grayscale mask will occlude masked areas from producing an outline. White is outlined, Black is occluded.)][Tex(GroupOutline)]_OutlineMask("Outline Mask (R)", 2D) = "white" {}
		[Sub(GroupOutline)]_OutlineColor("Outline Color", Color) = (0,0,0,0)
		[Sub(GroupOutline)]_OutlineSize("Outline Size", Float) = 1
		[Space(10)][Main(GroupAdv, _, off, off)]_AdvancedOptionsRendering("Advanced Options & Rendering", Float) = 1
		[Tooltip(Turns on internal MSAA capabilities to blend alpha objects using layers of opaque objects, Only available for forward rendering with MSAA turned on.)][SubKeywordEnum(GroupAdv, Off,On)][Title(GroupAdv, Blend Mode Misc.)]_AlphatoCoverage("Alpha to Coverage", Float) = 0
		[Tooltip(Front, Cull frontfacing geometry. Back, Cull backfacing geometry. Off, Double sided geometry.)][SubKeywordEnum(GroupAdv, Off,Front,Back)]_CullMode("Cull Mode", Float) = 2
		[Tooltip(The value to be compared against if Comp is anything else than always, andor the value to be written to the buffer if either Pass, Fail or ZFail is set to replace.)][Sub(GroupAdv)][Title(GroupAdv, Stencil Buffer)]_StencilBufferReference("Stencil Buffer Reference", Range( 0 , 255)) = 0
		[Tooltip(An 8 bit mask as a 0 to 255 integer, used when comparing the reference value with the contents of the buffer comparisonFunction.)][Sub(GroupAdv)]_StencilBufferReadMask("Stencil Buffer Read Mask", Range( 0 , 255)) = 255
		[Tooltip(An 8 bit mask as a 0 to 255 integer, used when writing to the buffer.)][Sub(GroupAdv)]_StencilBufferWriteMask("Stencil Buffer Write Mask", Range( 0 , 255)) = 255
		[Tooltip(The function used to compare the reference value to the current contents of the buffer.)][SubKeywordEnum(GroupAdv, Disabled,Never,Less,Equal,LessEqual,Greater,NotEqual,GreaterEqual,Always)]_StencilBufferComparison("Stencil Buffer Comparison", Float) = 0
		[Tooltip(What to do with the contents of the buffer if the stencil test, and the depth test, passes.)][SubKeywordEnum(GroupAdv, Keep,Zero,Replace,IncrementSaturate,DecrementSaturate,Invert,IncrementWrap,DecrementWrap)]_StencilBufferPassFront("Stencil Buffer Pass Front", Float) = 0
		[Tooltip(What to do with the contents of the buffer if the stencil test fails.)][SubKeywordEnum(GroupAdv, Keep,Zero,Replace,IncrementSaturate,DecrementSaturate,Invert,IncrementWrap,DecrementWrap)]_StencilBufferFailFront("Stencil Buffer Fail Front", Float) = 0
		[Tooltip(What to do with the contents of the buffer if the stencil test passes, but the depth test fails.)][SubKeywordEnum(GroupAdv, Keep,Zero,Replace,IncrementSaturate,DecrementSaturate,Invert,IncrementWrap,DecrementWrap)]_StencilBufferZFailFront("Stencil Buffer ZFail Front", Float) = 0
		[Tooltip(Controls whether pixels from this object are written to the depth buffer. If youre drawing solid objects, leave this on. If youre drawing semitransparent effects, switch to ZWrite Off.)][SubKeywordEnum(GroupAdv, Off,On)][Title(GroupAdv, Depth)]_ZWrite("ZWrite Mode", Float) = 1
		[Tooltip(How depth testing is performed.)][SubKeywordEnum(GroupAdv, Disabled,Never,Less,Equal,LessEqual,Greater,NotEqual,GreaterEqual,Always)]_ZTest("ZTest Mode", Float) = 4
		[Tooltip(Scales the maximum Z slope, with respect to X or Y of the polygon.)][Sub(GroupAdv)]_DepthOffsetFactor("Depth Offset Factor", Float) = 0
		[Tooltip(Units scale of the minimum resolvable depth buffer value.)][Sub(GroupAdv)]_DepthOffsetUnits("Depth Offset Units", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0"}
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog alpha:fade  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = ( _OutlineSize * 0.01 );
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float lerpResult659 = lerp( 0.0 , tex2D( _OutlineMask, i.uv_texcoord ).r , _Outline);
			o.Emission = _OutlineColor.rgb;
			o.Alpha = lerpResult659;
		}
		ENDCG
		

		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  "VRCFallback"="Toon" }
		Cull [_CullMode]
		Stencil
		{
			Ref [_StencilBufferReference]
			ReadMask [_StencilBufferReadMask]
			WriteMask [_StencilBufferWriteMask]
			Comp [_StencilBufferComparison]
			Pass [_StencilBufferPassFront]
			Fail [_StencilBufferFailFront]
			ZFail [_StencilBufferZFailFront]
		}
		AlphaToMask [_AlphatoCoverage]
		ColorMask [_ColorMask]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		#pragma multi_compile _ VERTEXLIGHT_ON
		#pragma multi_compile _ LIGHTMAP_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float3 worldPos;
			float3 worldNormal;
			float3 worldRefl;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _MainTexturesSettings;
		uniform float _AdvancedOptionsRendering;
		uniform float _Lighting;
		uniform float _StencilBufferReference;
		uniform float _StencilBufferReadMask;
		uniform float _StencilBufferWriteMask;
		uniform float _StencilBufferComparison;
		uniform float _StencilBufferPassFront;
		uniform float _StencilBufferFailFront;
		uniform float _StencilBufferZFailFront;
		uniform float _ZWrite;
		uniform float _ZTest;
		uniform float _DepthOffsetFactor;
		uniform float _DepthOffsetUnits;
		uniform float _AlphatoCoverage;
		uniform float _CullMode;
		uniform sampler2D _EmissionMap;
		uniform float4 _TilingOffset;
		uniform sampler2D _ParallaxMap;
		uniform float _HeightStrength;
		uniform float4 _EmissionTint;
		uniform float _EmissionMultiplier;
		uniform sampler2D _MainTex;
		uniform sampler2D _BumpMap;
		uniform float _NormalStrength;
		uniform float _PointSpotLightBoost;
		uniform sampler2D _OcclusionMap;
		uniform float _OcclusionStrength;
		uniform float _LightGradientMidLevel;
		uniform float _LightGradientSize;
		uniform float _LightGradientSteps;
		uniform float _HueShiftColor;
		uniform sampler2D _Metallic;
		uniform float _MetallicStrength;
		uniform sampler2D _Smoothness;
		uniform float _SmoothnessStrength;
		uniform float _HueShiftStrength;
		uniform float _IndirectShadowIntensity;
		uniform float _AmbientBoost;
		uniform float4 _OutlineColor;
		uniform sampler2D _OutlineMask;
		uniform float _Outline;
		uniform float _OutlineSize;


		void BasicToonLightinginAmplify(  )
		{
			//Basics of Toon Lighting in Unity! (https://www.patreon.com/posts/toon-lighting-41620461)
		}


		void AmbientLighting(  )
		{
			//This Shader was made possible by Moriohs Toon Shader (https://gitlab.com/xMorioh/moriohs-toon-shader)
		}


		void LightingbySymmasolan(  )
		{
			// All code not attributed to sources written by Symmasolan (Symm#8218)
			// Please don't randomly friend request me  without talking to me first somehow :(
		}


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		float3 PosterizedShade4PointLights19_g255( float3 posWorld, float3 normalWorld, float posterizeSteps, float occlusion )
		{
			#ifdef VERTEXLIGHT_ON
			    // to light vectors
			    float4 toLightX = unity_4LightPosX0 - posWorld.x;
			    float4 toLightY = unity_4LightPosY0 - posWorld.y;
			    float4 toLightZ = unity_4LightPosZ0 - posWorld.z;
			    // squared lengths
			    float4 lengthSq = 0;
			    lengthSq += toLightX * toLightX;
			    lengthSq += toLightY * toLightY;
			    lengthSq += toLightZ * toLightZ;
			    // don't produce NaNs if some vertex position overlaps with the light
			    lengthSq = max(lengthSq, 0.000001);
			    // NdotL
			    float4 ndotl = 0;
			    ndotl += toLightX * normalWorld.x;
			    ndotl += toLightY * normalWorld.y;
			    ndotl += toLightZ * normalWorld.z;
			    // correct NdotL
			    float4 corr = rsqrt(lengthSq);
			    ndotl = max (float4(0,0,0,0), ndotl * corr);
			    // attenuation
			    // fixed atten by d4rkpl4y3r#2639
			    float4 atten = saturate((1 - (unity_4LightAtten0 * lengthSq / 25)));
			    // shade with ndotl, darken with occlusion
			    float4 diff = atten * ndotl * occlusion;
			    // posterize
			    float steps = posterizeSteps;
			    diff = round(diff * ceil(steps)) / floor(steps);
			    // final color
			    float3 col = 0;
			    col += unity_LightColor[0].rgb * diff.x;
			    col += unity_LightColor[1].rgb * diff.y;
			    col += unity_LightColor[2].rgb * diff.z;
			    col += unity_LightColor[3].rgb * diff.w;
			    return col;
			#endif
			return float3(0,0,0);
		}


		float3 ambientDir(  )
		{
			//Source: "https://web.archive.org/web/20160313132301/http://www.geomerics.com/wp-content/uploads/2015/08/CEDEC_Geomerics_ReconstructingDiffuseLighting1.pdf" Page 18
			return normalize(unity_SHAr.xyz + unity_SHAg.xyz + unity_SHAb.xyz);
		}


		half getLinearRgbToLuminance( half3 linearRgb )
		{
			return LinearRgbToLuminance(linearRgb);
		}


		half3 Ambient(  )
		{
			return float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w) + float3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 FinalOutlineOffset661 = 0;
			v.vertex.xyz += FinalOutlineOffset661;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 appendResult16 = (float2(_TilingOffset.x , _TilingOffset.y));
			float2 appendResult17 = (float2(_TilingOffset.z , _TilingOffset.w));
			float2 uv_TexCoord12 = i.uv_texcoord * appendResult16 + appendResult17;
			float2 Offset5 = ( ( tex2D( _ParallaxMap, uv_TexCoord12 ).b - 1 ) * i.viewDir.xy * _HeightStrength ) + uv_TexCoord12;
			float2 FinalParallaxUV467 = Offset5;
			float4 var_AlbedoRGBA500 = tex2D( _MainTex, FinalParallaxUV467 );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 var_NormalXYZ501 = UnpackScaleNormal( tex2D( _BumpMap, FinalParallaxUV467 ), _NormalStrength );
			float3 input_Normal231_g252 = var_NormalXYZ501;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 var_WorldNormal263_g252 = ( input_Normal231_g252 == float3( 0,0,1 ) ? ase_worldNormal : (WorldNormalVector( i , input_Normal231_g252 )) );
			float fresnelNdotV134_g252 = dot( var_WorldNormal263_g252, ase_worldViewDir );
			float fresnelNode134_g252 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV134_g252, 5.0 ) );
			float PLAttenBoost213_g252 = _PointSpotLightBoost;
			float var_OcclusionR505 = ( tex2D( _OcclusionMap, FinalParallaxUV467 ).r * _OcclusionStrength );
			float input_Occlusion567_g252 = var_OcclusionR505;
			float LightAttenuation205_g252 = ( ase_lightAtten * input_Occlusion567_g252 );
			float isPointLight167_g252 = _WorldSpaceLightPos0.w;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult3_g252 = dot( var_WorldNormal263_g252 , ase_worldlightDir );
			float NLSaturated171_g252 = saturate( dotResult3_g252 );
			float FinalRTLightAttenuation161_g252 = saturate( ( ( PLAttenBoost213_g252 * LightAttenuation205_g252 * isPointLight167_g252 ) + ( NLSaturated171_g252 * LightAttenuation205_g252 * ( 1.0 - isPointLight167_g252 ) ) ) );
			float dotResult129_g252 = dot( ase_worldViewDir , ase_worldlightDir );
			float prop_LightGradientMidLevel588_g252 = _LightGradientMidLevel;
			float prop_LightGradientSize590_g252 = _LightGradientSize;
			float temp_output_20_0_g252 = ( prop_LightGradientSize590_g252 * 0.5 );
			float smoothstepResult23_g252 = smoothstep( ( prop_LightGradientMidLevel588_g252 - temp_output_20_0_g252 ) , ( prop_LightGradientMidLevel588_g252 + temp_output_20_0_g252 ) , (dotResult3_g252*0.5 + 0.5));
			float prop_GradientSteps381_g252 = round( _LightGradientSteps );
			float temp_output_11_0_g253 = prop_GradientSteps381_g252;
			float AttenPosterized427_g252 = ( round( ( ( ( fresnelNode134_g252 * FinalRTLightAttenuation161_g252 * saturate( -dotResult129_g252 ) ) + ( smoothstepResult23_g252 * FinalRTLightAttenuation161_g252 ) ) * ceil( temp_output_11_0_g253 ) ) ) / floor( temp_output_11_0_g253 ) );
			float prop_HueShiftColor599_g252 = _HueShiftColor;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float dotResult355_g252 = dot( WorldReflectionVector( i , input_Normal231_g252 ) , ase_worldViewDir );
			float var_MetallicR503 = ( tex2D( _Metallic, FinalParallaxUV467 ).r * _MetallicStrength );
			float input_Metallic232_g252 = var_MetallicR503;
			float var_SmoothnessG504 = ( tex2D( _Smoothness, FinalParallaxUV467 ).g * _SmoothnessStrength );
			float input_Smoothness233_g252 = var_SmoothnessG504;
			float temp_output_11_0_g254 = 4.0;
			float FinalReflectionColor291_g252 = saturate( ( round( ( pow( dotResult355_g252 , ( input_Metallic232_g252 * input_Smoothness233_g252 * 2.0 * input_Occlusion567_g252 ) ) * ceil( temp_output_11_0_g254 ) ) ) / floor( temp_output_11_0_g254 ) ) );
			float3 temp_output_305_0_g252 = ( ase_lightColor.rgb + FinalReflectionColor291_g252 );
			float3 hsvTorgb142_g252 = RGBToHSV( temp_output_305_0_g252 );
			float3 hsvTorgb143_g252 = HSVToRGB( float3(( prop_HueShiftColor599_g252 + hsvTorgb142_g252.x ),hsvTorgb142_g252.y,hsvTorgb142_g252.z) );
			float prop_HueShiftStrength597_g252 = _HueShiftStrength;
			float const_HueShiftPower598_g252 = 0.7;
			float3 lerpResult141_g252 = lerp( hsvTorgb143_g252 , temp_output_305_0_g252 , pow( ( AttenPosterized427_g252 * prop_HueShiftStrength597_g252 ) , const_HueShiftPower598_g252 ));
			float3 posWorld19_g255 = ase_worldPos;
			float3 normalWorld19_g255 = var_WorldNormal263_g252;
			float posterizeSteps19_g255 = prop_GradientSteps381_g252;
			float occlusion19_g255 = input_Occlusion567_g252;
			float3 localPosterizedShade4PointLights19_g255 = PosterizedShade4PointLights19_g255( posWorld19_g255 , normalWorld19_g255 , posterizeSteps19_g255 , occlusion19_g255 );
			float3 FinalVertexPLColor426_g252 = ( localPosterizedShade4PointLights19_g255 * ( PLAttenBoost213_g252 * 0.275 ) );
			float3 localambientDir112_g252 = ambientDir();
			float3 normalizeResult115_g252 = normalize( ase_worldlightDir );
			float dotResult113_g252 = dot( localambientDir112_g252 , normalizeResult115_g252 );
			float temp_output_60_0_g252 = saturate( ( floor( ( saturate( ( ( dotResult113_g252 * 0.5 ) + 0.5 ) ) * prop_GradientSteps381_g252 ) ) / ( prop_GradientSteps381_g252 - 1.0 ) ) );
			half3 temp_cast_1 = (temp_output_60_0_g252).xxx;
			half3 linearRgb95_g252 = temp_cast_1;
			half localgetLinearRgbToLuminance95_g252 = getLinearRgbToLuminance( linearRgb95_g252 );
			float lerpResult85_g252 = lerp( temp_output_60_0_g252 , 1.0 , localgetLinearRgbToLuminance95_g252);
			float prop_IndirectShadowIntensity592_g252 = _IndirectShadowIntensity;
			float lerpResult54_g252 = lerp( 1.0 , lerpResult85_g252 , max( prop_IndirectShadowIntensity592_g252 , 1E-06 ));
			half3 linearRgb90_g252 = ase_lightColor.rgb;
			half localgetLinearRgbToLuminance90_g252 = getLinearRgbToLuminance( linearRgb90_g252 );
			float lerpResult56_g252 = lerp( lerpResult54_g252 , 1.0 , saturate( localgetLinearRgbToLuminance90_g252 ));
			half3 localAmbient106_g252 = Ambient();
			float3 AmbientCalc156_g252 = localAmbient106_g252;
			float prop_AmbientBoost594_g252 = _AmbientBoost;
			float3 break103_g252 = AmbientCalc156_g252;
			float3 lerpResult100_g252 = lerp( ( AmbientCalc156_g252 * prop_AmbientBoost594_g252 ) , AmbientCalc156_g252 , saturate( max( max( break103_g252.x , break103_g252.y ) , break103_g252.z ) ));
			float3 FinalAmbientLightColor61_g252 = ( lerpResult56_g252 * lerpResult100_g252 );
			float3 input_Albedo230_g252 = var_AlbedoRGBA500.rgb;
			float3 FinalCustomLighting347 = saturate( ( ( ( AttenPosterized427_g252 * lerpResult141_g252 ) + FinalVertexPLColor426_g252 + FinalAmbientLightColor61_g252 ) * input_Albedo230_g252 ) );
			c.rgb = FinalCustomLighting347;
			c.a = var_AlbedoRGBA500.a;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 appendResult16 = (float2(_TilingOffset.x , _TilingOffset.y));
			float2 appendResult17 = (float2(_TilingOffset.z , _TilingOffset.w));
			float2 uv_TexCoord12 = i.uv_texcoord * appendResult16 + appendResult17;
			float2 Offset5 = ( ( tex2D( _ParallaxMap, uv_TexCoord12 ).b - 1 ) * i.viewDir.xy * _HeightStrength ) + uv_TexCoord12;
			float2 FinalParallaxUV467 = Offset5;
			float4 FinalEmissive348 = ( tex2D( _EmissionMap, FinalParallaxUV467 ) * _EmissionTint * _EmissionMultiplier );
			o.Emission = FinalEmissive348.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			AlphaToMask Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.worldRefl = -worldViewDir;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Standard"
	CustomEditor "LWGUI.LWGUI"
}
/*ASEBEGIN
Version=19105
Node;AmplifyShaderEditor.CommentaryNode;643;-2968.453,-2086.048;Inherit;False;767.4915;971.8801;;4;635;247;607;655;Rendering Properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;607;-2523.049,-1763.088;Inherit;False;287;408.3671;Depth;4;605;606;604;603;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;351;-2969.416,-356.7815;Inherit;False;4179.107;2381.085;;45;43;238;239;482;477;280;33;3;505;483;488;501;504;503;474;471;473;240;241;348;324;2;223;514;224;472;500;468;510;509;508;507;506;347;19;475;15;17;16;12;467;5;32;14;18;PBR, Emissive, & Cel Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;247;-2935.637,-2028.321;Inherit;False;308;229.9019;loadbearing editor values;2;244;602;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2299.353,-264.6505;Float;False;True;-1;7;LWGUI.LWGUI;0;0;CustomLighting;Symm/[Transparent] Cel PBR (Outline);False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;True;_ZWrite;0;True;_ZTest;True;0;True;_DepthOffsetFactor;0;True;_DepthOffsetUnits;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;True;_ColorMask;True;0;True;_StencilBufferReference;255;True;_StencilBufferReadMask;255;True;_StencilBufferWriteMask;0;True;_StencilBufferComparison;0;True;_StencilBufferPassFront;0;True;_StencilBufferFailFront;0;True;_StencilBufferZFailFront;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;True;_BlendRGBSource;10;True;_BlendRGBDestination;1;0;True;_BlendAlphaSource;0;True;_BlendAlphaDestination;0;True;_BlendOpRGB;0;True;_BlendOpAlpha;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;Standard;-1;-1;-1;-1;1;VRCFallback=Toon;False;0;0;True;_CullMode;-1;0;False;_OutlineMaskAlphaClip;0;0;0;False;0.1;False;;0;True;_AlphatoCoverage;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;347;691.5655,-174.232;Inherit;False;FinalCustomLighting;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;506;61.00602,-269.0255;Inherit;False;500;var_AlbedoRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;507;62.00602,-196.0255;Inherit;False;501;var_NormalXYZ;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;500;-498.2218,-261.3677;Inherit;False;var_AlbedoRGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;508;61.00602,-123.0254;Inherit;False;503;var_MetallicR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;509;60.00602,-51.02544;Inherit;False;504;var_SmoothnessG;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;510;60.00602,18.97459;Inherit;False;505;var_OcclusionR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;468;-1050.099,-244.2955;Inherit;False;467;FinalParallaxUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;32;-2119.522,0.8459005;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ParallaxMappingNode;5;-1848.562,-217.5515;Inherit;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;467;-1615.712,-217.3229;Inherit;False;FinalParallaxUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2488.964,-234.3789;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;16;-2670.964,-234.3787;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2672.265,-145.979;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;475;-2249.106,-297.408;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;19;-1989.35,-295.3822;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;241;-457.0742,1217.388;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;504;-301.1921,1206.219;Inherit;False;var_SmoothnessG;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;488;-1023.552,1601.139;Inherit;False;467;FinalParallaxUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;483;-442.9275,1606.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;505;-292.8037,1600.696;Inherit;False;var_OcclusionR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;482;-768.9276,1766.981;Inherit;False;Property;_OcclusionStrength;Occlusion Strength;14;0;Create;True;0;0;0;False;2;Sub(GroupMain);HideInInspector;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;472;-1041.099,50.61943;Inherit;False;467;FinalParallaxUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;324;-481.1671,34.92619;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;348;-324.1336,29.99798;Inherit;False;FinalEmissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;501;-478.9748,528.8383;Inherit;False;var_NormalXYZ;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;-448.1255,831.9033;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;503;-277.7066,824.3899;Inherit;False;var_MetallicR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;474;-1031.326,1186.404;Inherit;False;467;FinalParallaxUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;473;-1025.321,547.8744;Inherit;False;467;FinalParallaxUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;471;-1023.417,828.7544;Inherit;False;467;FinalParallaxUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;350;1976.394,-223.0988;Inherit;False;348;FinalEmissive;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;635;-2932.056,-1765.39;Inherit;False;366.0601;618.2424;Stencil Buffer;7;637;641;636;642;640;638;639;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;223;-820.9906,29.96559;Inherit;True;Property;_EmissionMap;Emission Map (RGB);8;0;Create;False;0;0;0;False;2;Tooltip(Change tint to pure white to only show the color of the Emission map. Otherwise, make your Emission map grayscale and define overall color using the tint value.);Tex(GroupMain, _EmissionTint);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;224;-732.3955,212.4774;Inherit;False;Property;_EmissionTint;Emission Tint;9;0;Create;True;0;0;0;False;2;HDR;HideInInspector;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;514;-797.4875,379.4106;Inherit;False;Property;_EmissionMultiplier;Emission Multiplier;10;0;Create;True;0;0;0;False;1;Sub(GroupMain);False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-803.6256,529.267;Inherit;True;Property;_BumpMap;Normal Map;2;0;Create;False;0;0;0;False;2;Tex(GroupMain, _NormalStrength);Normal;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;33;-801.1322,802.7585;Inherit;True;Property;_Metallic;Metallic (R);4;0;Create;False;0;0;0;False;1;Tex(GroupMain, _MetallicStrength);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;-1093.884,630.744;Inherit;False;Property;_NormalStrength;Normal Strength;3;0;Create;True;0;0;0;False;1;HideInInspector;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;238;-781.1252,989.9026;Inherit;False;Property;_MetallicStrength;Metallic Strength;5;0;Create;True;0;0;0;False;2;Sub(GroupMain);HideInInspector;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;280;-797.6268,1164.135;Inherit;True;Property;_Smoothness;Smoothness (G);6;0;Create;False;0;0;0;False;1;Tex(GroupMain,_SmoothnessStrength);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;239;-777.0747,1350.389;Inherit;False;Property;_SmoothnessStrength;Smoothness Strength;7;0;Create;True;0;0;0;False;2;Sub(GroupMain);HideInInspector;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;244;-2886.636,-1978.323;Inherit;False;Property;_MainTexturesSettings;Main Textures & Settings;0;0;Create;True;0;0;0;True;1;Main(GroupMain, _, off, off);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;15;-2927.067,-242.1784;Inherit;False;Property;_TilingOffset;Tiling & Offset;15;0;Create;True;0;0;0;False;2;Tooltip(Effects Tiling and Offset values for all textures and masks in the Main Textures and Settings section.);Sub(GroupMain);False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-2237.737,-264.885;Inherit;True;Property;_ParallaxMap;Height Map (B);11;0;Create;False;0;0;0;False;1;Tex(GroupMain, _HeightStrength);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-2216.358,-74.56319;Inherit;False;Property;_HeightStrength;Height Strength;12;0;Create;True;0;0;0;False;1;HideInInspector;False;0.01;0.01;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;477;-787.8795,1577.493;Inherit;True;Property;_OcclusionMap;Occlusion Map (R);13;0;Create;False;0;0;0;False;2;Tooltip(Any values less than one will darken the entire model. Adjust strength value with caution.);Tex(GroupMain,_OcclusionStrength);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;602;-2908.309,-1895.123;Inherit;False;Property;_AdvancedOptionsRendering;Advanced Options & Rendering;31;0;Create;True;0;0;0;True;2;Space(10);Main(GroupAdv, _, off, off);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;650;367.1862,-169.4809;Inherit;False;Symm's Cel Shaded Lighting;16;;252;108cbb651d697e245bcba4f1d01ed1fa;0;5;225;FLOAT3;1,1,1;False;226;FLOAT3;0,0,1;False;227;FLOAT;1;False;228;FLOAT;1;False;566;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;639;-2878.057,-1710.39;Inherit;False;Property;_StencilBufferReference;Stencil Buffer Reference;34;0;Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;3;Tooltip(The value to be compared against if Comp is anything else than always, andor the value to be written to the buffer if either Pass, Fail or ZFail is set to replace.);Sub(GroupAdv);Title(GroupAdv, Stencil Buffer);False;0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;638;-2880.057,-1636.39;Inherit;False;Property;_StencilBufferReadMask;Stencil Buffer Read Mask;35;0;Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;2;Tooltip(An 8 bit mask as a 0 to 255 integer, used when comparing the reference value with the contents of the buffer comparisonFunction.);Sub(GroupAdv);False;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;640;-2879.057,-1562.39;Inherit;False;Property;_StencilBufferWriteMask;Stencil Buffer Write Mask;36;0;Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;2;Tooltip(An 8 bit mask as a 0 to 255 integer, used when writing to the buffer.);Sub(GroupAdv);False;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;642;-2880.358,-1490.39;Inherit;False;Property;_StencilBufferComparison;Stencil Buffer Comparison;37;0;Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;2;Tooltip(The function used to compare the reference value to the current contents of the buffer.);SubKeywordEnum(GroupAdv, Disabled,Never,Less,Equal,LessEqual,Greater,NotEqual,GreaterEqual,Always);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;636;-2881.358,-1417.39;Inherit;False;Property;_StencilBufferPassFront;Stencil Buffer Pass Front;38;0;Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;2;Tooltip(What to do with the contents of the buffer if the stencil test, and the depth test, passes.);SubKeywordEnum(GroupAdv, Keep,Zero,Replace,IncrementSaturate,DecrementSaturate,Invert,IncrementWrap,DecrementWrap);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;641;-2881.358,-1342.39;Inherit;False;Property;_StencilBufferFailFront;Stencil Buffer Fail Front;39;0;Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;2;Tooltip(What to do with the contents of the buffer if the stencil test fails.);SubKeywordEnum(GroupAdv, Keep,Zero,Replace,IncrementSaturate,DecrementSaturate,Invert,IncrementWrap,DecrementWrap);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;637;-2879.358,-1267.39;Inherit;False;Property;_StencilBufferZFailFront;Stencil Buffer ZFail Front;40;0;Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;2;Tooltip(What to do with the contents of the buffer if the stencil test passes, but the depth test fails.);SubKeywordEnum(GroupAdv, Keep,Zero,Replace,IncrementSaturate,DecrementSaturate,Invert,IncrementWrap,DecrementWrap);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;603;-2470.205,-1713.088;Inherit;False;Property;_ZWrite;ZWrite Mode;41;0;Create;False;0;2;Off;0;On;1;0;True;3;Tooltip(Controls whether pixels from this object are written to the depth buffer. If youre drawing solid objects, leave this on. If youre drawing semitransparent effects, switch to ZWrite Off.);SubKeywordEnum(GroupAdv, Off,On);Title(GroupAdv, Depth);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;604;-2470.5,-1635.306;Inherit;False;Property;_ZTest;ZTest Mode;42;0;Create;False;0;0;1;UnityEngine.Rendering.CompareFunction;True;2;Tooltip(How depth testing is performed.);SubKeywordEnum(GroupAdv, Disabled,Never,Less,Equal,LessEqual,Greater,NotEqual,GreaterEqual,Always);False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;605;-2473.051,-1552.811;Inherit;False;Property;_DepthOffsetFactor;Depth Offset Factor;43;0;Create;True;0;0;0;True;2;Tooltip(Scales the maximum Z slope, with respect to X or Y of the polygon.);Sub(GroupAdv);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;606;-2471.329,-1470.721;Inherit;False;Property;_DepthOffsetUnits;Depth Offset Units;44;0;Create;True;0;0;0;True;2;Tooltip(Units scale of the minimum resolvable depth buffer value.);Sub(GroupAdv);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;349;1946.14,2.328824;Inherit;False;347;FinalCustomLighting;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;654;1910.646,-143.3836;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;652;1700.646,-149.3836;Inherit;False;500;var_AlbedoRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;651;-2472.285,-1343.846;Inherit;False;Property;_AlphatoCoverage;Alpha to Coverage;32;0;Create;True;0;2;Off;0;On;1;0;True;3;Tooltip(Turns on internal MSAA capabilities to blend alpha objects using layers of opaque objects, Only available for forward rendering with MSAA turned on.);SubKeywordEnum(GroupAdv, Off,On);Title(GroupAdv, Blend Mode Misc.);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;655;-2444.813,-1267.384;Inherit;False;Property;_CullMode;Cull Mode;33;0;Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;2;Tooltip(Front, Cull frontfacing geometry. Back, Cull backfacing geometry. Off, Double sided geometry.);SubKeywordEnum(GroupAdv, Off,Front,Back);False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;656;-2754.375,2377.492;Inherit;False;1399.671;784.7122;;9;666;665;664;663;662;661;659;658;657;Outline;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;657;-2122.299,2966.104;Inherit;False;253;186;cleaner human readable value;1;660;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;658;-2437.392,2785.372;Inherit;False;303;263.9019;loadbearing editor values lmao;2;668;667;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;659;-2047.469,2605.531;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;660;-2053.299,3029.103;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;661;-1562.109,2577.482;Inherit;False;FinalOutlineOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;662;-2682.229,2624.92;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;664;-2353.579,2427.492;Inherit;False;Property;_OutlineColor;Outline Color;29;0;Create;True;0;0;0;False;1;Sub(GroupOutline);False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;665;-2438.593,2601.045;Inherit;True;Property;_OutlineMask;Outline Mask (R);27;0;Create;False;0;0;0;False;2;Tooltip(No mask means the entire model will have an outline. A grayscale mask will occlude masked areas from producing an outline. White is outlined, Black is occluded.);Tex(GroupOutline);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;666;-2316.72,3064.671;Inherit;False;Property;_OutlineSize;Outline Size;30;0;Create;True;0;0;0;False;1;Sub(GroupOutline);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;669;1953.07,89.17584;Inherit;False;661;FinalOutlineOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;667;-2332.739,2949.065;Inherit;False;Property;_Outline;Outline;26;0;Create;True;0;0;0;False;3;Space(10);Main(GroupOutline, _OUTLINEENABLED, off);Tooltip(Note, This is going to look a little whacky unless you have a good mask. That could be what you are looking for though too);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;668;-2415.887,2846.285;Inherit;False;Property;_OutlineMaskAlphaClip;Outline Mask Alpha Clip;28;0;Create;True;0;0;0;False;2;Tooltip(Grayscale colors in the Outline Mask below this value, ex pure black, will not have an outline.);Sub(GroupOutline);False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OutlineNode;663;-1810.217,2578.114;Inherit;False;0;True;Transparent;0;0;Front;True;True;True;True;0;False;;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;2;-820.0197,-262.0853;Inherit;True;Property;_MainTex;Main Texture (RGB);1;0;Create;False;0;0;0;False;2;Tex(GroupMain);NoScaleOffset;False;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
WireConnection;0;2;350;0
WireConnection;0;9;654;3
WireConnection;0;13;349;0
WireConnection;0;11;669;0
WireConnection;347;0;650;0
WireConnection;500;0;2;0
WireConnection;5;0;19;0
WireConnection;5;1;18;3
WireConnection;5;2;14;0
WireConnection;5;3;32;0
WireConnection;467;0;5;0
WireConnection;12;0;16;0
WireConnection;12;1;17;0
WireConnection;16;0;15;1
WireConnection;16;1;15;2
WireConnection;17;0;15;3
WireConnection;17;1;15;4
WireConnection;475;0;12;0
WireConnection;19;0;475;0
WireConnection;241;0;280;2
WireConnection;241;1;239;0
WireConnection;504;0;241;0
WireConnection;483;0;477;1
WireConnection;483;1;482;0
WireConnection;505;0;483;0
WireConnection;324;0;223;0
WireConnection;324;1;224;0
WireConnection;324;2;514;0
WireConnection;348;0;324;0
WireConnection;501;0;3;0
WireConnection;240;0;33;1
WireConnection;240;1;238;0
WireConnection;503;0;240;0
WireConnection;223;1;472;0
WireConnection;3;1;473;0
WireConnection;3;5;43;0
WireConnection;33;1;471;0
WireConnection;280;1;474;0
WireConnection;18;1;12;0
WireConnection;477;1;488;0
WireConnection;650;225;506;0
WireConnection;650;226;507;0
WireConnection;650;227;508;0
WireConnection;650;228;509;0
WireConnection;650;566;510;0
WireConnection;654;0;652;0
WireConnection;659;1;665;1
WireConnection;659;2;667;0
WireConnection;660;0;666;0
WireConnection;661;0;663;0
WireConnection;665;1;662;0
WireConnection;663;0;664;0
WireConnection;663;2;659;0
WireConnection;663;1;660;0
WireConnection;2;1;468;0
ASEEND*/
//CHKSM=BE991351DDEBA75B255F49A1730721FA861819C3