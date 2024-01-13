// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Symm/[TransparentCutout] Cel PBR"
{
	Properties
	{
		[Main(GroupMain, _, off, off)]_MainTexturesSettings("Main Textures & Settings", Float) = 1
		[Tex(GroupMain)][NoScaleOffset]_MainTex("Main Texture (RGBA)", 2D) = "white" {}
		[Sub(GroupMain)]_AlphaClip("Alpha Clip", Range( 0 , 1)) = 0.5
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
		[Space(10)][Main(GroupAdv, _, off, off)]_AdvancedOptionsRendering("Advanced Options & Rendering", Float) = 1
		[Tooltip(Defines how pixel colors are blended together.)][SubKeywordEnum(GroupAdv, Zero,One,DstColor,SrcColor,OneMinusDstColor,DstAlpha,OneMinusDstAlpha,SrcAlphaSaturate,OneMinusSrcAlpha)][Title(GroupAdv, Blend RGB Values)]_BlendRGBSource("Blend RGB Source", Float) = 1
		[Tooltip(Defines how pixel colors are blended together.)][SubKeywordEnum(GroupAdv, Zero,One,DstColor,SrcColor,OneMinusDstColor,DstAlpha,OneMinusDstAlpha,SrcAlphaSaturate,OneMinusSrcAlpha)]_BlendRGBDestination("Blend RGB Destination", Float) = 0
		[Tooltip(Defines how pixel colors are blended together.)][SubKeywordEnum(GroupAdv, Add,Subtract,ReverseSubtract,Min,Max)]_BlendOpRGB("Blend Op RGB", Float) = 0
		[Tooltip(Defines how pixel colors are blended together.)][SubKeywordEnum(GroupAdv, Zero,One,DstColor,SrcColor,OneMinusDstColor,DstAlpha,OneMinusDstAlpha,SrcAlphaSaturate,OneMinusSrcAlpha)][Title(GroupAdv, Blend Alpha Values)]_BlendAlphaSource("Blend Alpha Source", Float) = 1
		[Tooltip(Defines how pixel colors are blended together.)][SubKeywordEnum(GroupAdv, Zero,One,DstColor,SrcColor,OneMinusDstColor,DstAlpha,OneMinusDstAlpha,SrcAlphaSaturate,OneMinusSrcAlpha)]_BlendAlphaDestination("Blend Alpha Destination", Float) = 0
		[Tooltip(Defines how pixel colors are blended together.)][SubKeywordEnum(GroupAdv, Add,Subtract,ReverseSubtract,Min,Max)]_BlendOpAlpha("Blend Op Alpha", Float) = 0
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
		[Tooltip(Turns on internal MSAA capabilities to blend alpha objects using layers of opaque objects, Only available for forward rendering with MSAA turned on.)][SubKeywordEnum(GroupAdv, Off,On)][Title(GroupAdv, Blend Mode Misc.)]_AlphatoCoverage("Alpha to Coverage", Float) = 0
		[Tooltip(Sets color channel writing mask, turning them all OFF makes it invisible.)][SubEnum(GroupAdv, Off,0,Alpha,1,Blue,2,Green,4,Red,8,RGB,14,RGBA,15)]_ColorMask("Color Mask", Float) = 15
		[Tooltip(Front, Cull frontfacing geometry. Back, Cull backfacing geometry. Off, Double sided geometry.)][SubKeywordEnum(GroupAdv, Off,Front,Back)]_CullMode("Cull Mode", Float) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IsEmissive" = "true"  "VRCFallback"="Toon" }
		Cull [_CullMode]
		ZWrite [_ZWrite]
		ZTest [_ZTest]
		Offset  [_DepthOffsetFactor] , [_DepthOffsetUnits]
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
		Blend [_BlendRGBSource] [_BlendRGBDestination] , [_BlendAlphaSource] [_BlendAlphaDestination]
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
		uniform float _AdvancedOptionsRendering;
		uniform float _MainTexturesSettings;
		uniform float _Lighting;
		uniform float _BlendRGBSource;
		uniform float _BlendRGBDestination;
		uniform float _BlendOpRGB;
		uniform float _BlendAlphaSource;
		uniform float _BlendAlphaDestination;
		uniform float _BlendOpAlpha;
		uniform float _AlphatoCoverage;
		uniform float _ColorMask;
		uniform float _CullMode;
		uniform float _AlphaClip;
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

		float3 PosterizedShade4PointLights19_g247( float3 posWorld, float3 normalWorld, float posterizeSteps, float occlusion )
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
			float3 input_Normal231_g1 = var_NormalXYZ501;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 var_WorldNormal263_g1 = ( input_Normal231_g1 == float3( 0,0,1 ) ? ase_worldNormal : (WorldNormalVector( i , input_Normal231_g1 )) );
			float fresnelNdotV134_g1 = dot( var_WorldNormal263_g1, ase_worldViewDir );
			float fresnelNode134_g1 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV134_g1, 5.0 ) );
			float PLAttenBoost213_g1 = _PointSpotLightBoost;
			float var_OcclusionR505 = ( tex2D( _OcclusionMap, FinalParallaxUV467 ).r * _OcclusionStrength );
			float input_Occlusion567_g1 = var_OcclusionR505;
			float LightAttenuation205_g1 = ( ase_lightAtten * input_Occlusion567_g1 );
			float isPointLight167_g1 = _WorldSpaceLightPos0.w;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult3_g1 = dot( var_WorldNormal263_g1 , ase_worldlightDir );
			float NLSaturated171_g1 = saturate( dotResult3_g1 );
			float FinalRTLightAttenuation161_g1 = saturate( ( ( PLAttenBoost213_g1 * LightAttenuation205_g1 * isPointLight167_g1 ) + ( NLSaturated171_g1 * LightAttenuation205_g1 * ( 1.0 - isPointLight167_g1 ) ) ) );
			float dotResult129_g1 = dot( ase_worldViewDir , ase_worldlightDir );
			float prop_LightGradientMidLevel588_g1 = _LightGradientMidLevel;
			float prop_LightGradientSize590_g1 = _LightGradientSize;
			float temp_output_20_0_g1 = ( prop_LightGradientSize590_g1 * 0.5 );
			float smoothstepResult23_g1 = smoothstep( ( prop_LightGradientMidLevel588_g1 - temp_output_20_0_g1 ) , ( prop_LightGradientMidLevel588_g1 + temp_output_20_0_g1 ) , (dotResult3_g1*0.5 + 0.5));
			float prop_GradientSteps381_g1 = round( _LightGradientSteps );
			float temp_output_11_0_g184 = prop_GradientSteps381_g1;
			float AttenPosterized427_g1 = ( round( ( ( ( fresnelNode134_g1 * FinalRTLightAttenuation161_g1 * saturate( -dotResult129_g1 ) ) + ( smoothstepResult23_g1 * FinalRTLightAttenuation161_g1 ) ) * ceil( temp_output_11_0_g184 ) ) ) / floor( temp_output_11_0_g184 ) );
			float prop_HueShiftColor599_g1 = _HueShiftColor;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float dotResult355_g1 = dot( WorldReflectionVector( i , input_Normal231_g1 ) , ase_worldViewDir );
			float var_MetallicR503 = ( tex2D( _Metallic, FinalParallaxUV467 ).r * _MetallicStrength );
			float input_Metallic232_g1 = var_MetallicR503;
			float var_SmoothnessG504 = ( tex2D( _Smoothness, FinalParallaxUV467 ).g * _SmoothnessStrength );
			float input_Smoothness233_g1 = var_SmoothnessG504;
			float temp_output_11_0_g185 = 4.0;
			float FinalReflectionColor291_g1 = saturate( ( round( ( pow( dotResult355_g1 , ( input_Metallic232_g1 * input_Smoothness233_g1 * 2.0 * input_Occlusion567_g1 ) ) * ceil( temp_output_11_0_g185 ) ) ) / floor( temp_output_11_0_g185 ) ) );
			float3 temp_output_305_0_g1 = ( ase_lightColor.rgb + FinalReflectionColor291_g1 );
			float3 hsvTorgb142_g1 = RGBToHSV( temp_output_305_0_g1 );
			float3 hsvTorgb143_g1 = HSVToRGB( float3(( prop_HueShiftColor599_g1 + hsvTorgb142_g1.x ),hsvTorgb142_g1.y,hsvTorgb142_g1.z) );
			float prop_HueShiftStrength597_g1 = _HueShiftStrength;
			float const_HueShiftPower598_g1 = 0.7;
			float3 lerpResult141_g1 = lerp( hsvTorgb143_g1 , temp_output_305_0_g1 , pow( ( AttenPosterized427_g1 * prop_HueShiftStrength597_g1 ) , const_HueShiftPower598_g1 ));
			float3 posWorld19_g247 = ase_worldPos;
			float3 normalWorld19_g247 = var_WorldNormal263_g1;
			float posterizeSteps19_g247 = prop_GradientSteps381_g1;
			float occlusion19_g247 = input_Occlusion567_g1;
			float3 localPosterizedShade4PointLights19_g247 = PosterizedShade4PointLights19_g247( posWorld19_g247 , normalWorld19_g247 , posterizeSteps19_g247 , occlusion19_g247 );
			float3 FinalVertexPLColor426_g1 = ( localPosterizedShade4PointLights19_g247 * ( PLAttenBoost213_g1 * 0.275 ) );
			float3 localambientDir112_g1 = ambientDir();
			float3 normalizeResult115_g1 = normalize( ase_worldlightDir );
			float dotResult113_g1 = dot( localambientDir112_g1 , normalizeResult115_g1 );
			float temp_output_60_0_g1 = saturate( ( floor( ( saturate( ( ( dotResult113_g1 * 0.5 ) + 0.5 ) ) * prop_GradientSteps381_g1 ) ) / ( prop_GradientSteps381_g1 - 1.0 ) ) );
			half3 temp_cast_1 = (temp_output_60_0_g1).xxx;
			half3 linearRgb95_g1 = temp_cast_1;
			half localgetLinearRgbToLuminance95_g1 = getLinearRgbToLuminance( linearRgb95_g1 );
			float lerpResult85_g1 = lerp( temp_output_60_0_g1 , 1.0 , localgetLinearRgbToLuminance95_g1);
			float prop_IndirectShadowIntensity592_g1 = _IndirectShadowIntensity;
			float lerpResult54_g1 = lerp( 1.0 , lerpResult85_g1 , max( prop_IndirectShadowIntensity592_g1 , 1E-06 ));
			half3 linearRgb90_g1 = ase_lightColor.rgb;
			half localgetLinearRgbToLuminance90_g1 = getLinearRgbToLuminance( linearRgb90_g1 );
			float lerpResult56_g1 = lerp( lerpResult54_g1 , 1.0 , saturate( localgetLinearRgbToLuminance90_g1 ));
			half3 localAmbient106_g1 = Ambient();
			float3 AmbientCalc156_g1 = localAmbient106_g1;
			float prop_AmbientBoost594_g1 = _AmbientBoost;
			float3 break103_g1 = AmbientCalc156_g1;
			float3 lerpResult100_g1 = lerp( ( AmbientCalc156_g1 * prop_AmbientBoost594_g1 ) , AmbientCalc156_g1 , saturate( max( max( break103_g1.x , break103_g1.y ) , break103_g1.z ) ));
			float3 FinalAmbientLightColor61_g1 = ( lerpResult56_g1 * lerpResult100_g1 );
			float3 input_Albedo230_g1 = var_AlbedoRGBA500.rgb;
			float3 FinalCustomLighting347 = saturate( ( ( ( AttenPosterized427_g1 * lerpResult141_g1 ) + FinalVertexPLColor426_g1 + FinalAmbientLightColor61_g1 ) * input_Albedo230_g1 ) );
			c.rgb = FinalCustomLighting347;
			c.a = 1;
			clip( var_AlbedoRGBA500.a - _AlphaClip );
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
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

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
Node;AmplifyShaderEditor.CommentaryNode;646;-2576.298,-1774.879;Inherit;False;278.0427;314.062;Blend Mode Misc.;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;643;-2968.453,-2086.048;Inherit;False;1450.5;1187.567;;7;612;632;645;635;247;607;634;Rendering Properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;634;-2936.87,-1774.561;Inherit;False;311.3452;578.5348;Blend Mode;6;627;628;630;629;631;626;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;607;-1846.297,-1771.893;Inherit;False;287;408.3671;Depth;4;605;606;604;603;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;351;-2969.416,-356.7815;Inherit;False;4179.107;2381.085;;45;43;238;239;482;477;280;33;3;505;483;488;501;504;503;474;471;473;240;241;348;324;2;223;514;224;472;500;468;510;509;508;507;506;347;19;475;15;17;16;12;467;5;32;14;18;PBR, Emissive, & Cel Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;247;-2935.637,-2028.321;Inherit;False;308;229.9019;loadbearing editor values;2;244;602;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2299.353,-264.6505;Float;False;True;-1;7;LWGUI.LWGUI;0;0;CustomLighting;Symm/[TransparentCutout] Cel PBR;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;True;_ZWrite;0;True;_ZTest;True;0;True;_DepthOffsetFactor;0;True;_DepthOffsetUnits;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;12;all;True;True;True;True;0;True;_ColorMask;True;0;True;_StencilBufferReference;255;True;_StencilBufferReadMask;255;True;_StencilBufferWriteMask;0;True;_StencilBufferComparison;0;True;_StencilBufferPassFront;0;True;_StencilBufferFailFront;0;True;_StencilBufferZFailFront;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;1;5;True;_BlendRGBSource;10;True;_BlendRGBDestination;1;0;True;_BlendAlphaSource;0;True;_BlendAlphaDestination;0;True;_BlendOpRGB;0;True;_BlendOpAlpha;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;Standard;-1;-1;-1;-1;1;VRCFallback=Toon;False;0;0;True;_CullMode;-1;0;True;_AlphaClip;0;0;0;False;0.1;False;;0;True;_AlphatoCoverage;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
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
Node;AmplifyShaderEditor.RangedFloatNode;482;-768.9276,1766.981;Inherit;False;Property;_OcclusionStrength;Occlusion Strength;15;0;Create;True;0;0;0;False;2;Sub(GroupMain);HideInInspector;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;472;-1041.099,50.61943;Inherit;False;467;FinalParallaxUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;324;-481.1671,34.92619;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;348;-324.1336,29.99798;Inherit;False;FinalEmissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;501;-478.9748,528.8383;Inherit;False;var_NormalXYZ;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;-448.1255,831.9033;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;503;-277.7066,824.3899;Inherit;False;var_MetallicR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;474;-1031.326,1186.404;Inherit;False;467;FinalParallaxUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;473;-1025.321,547.8744;Inherit;False;467;FinalParallaxUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;471;-1023.417,828.7544;Inherit;False;467;FinalParallaxUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;635;-2255.304,-1774.195;Inherit;False;366.0601;618.2424;Stencil Buffer;7;637;641;636;642;640;638;639;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;223;-820.9906,29.96559;Inherit;True;Property;_EmissionMap;Emission Map (RGB);9;0;Create;False;0;0;0;False;2;Tooltip(Change tint to pure white to only show the color of the Emission map. Otherwise, make your Emission map grayscale and define overall color using the tint value.);Tex(GroupMain, _EmissionTint);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-803.6256,529.267;Inherit;True;Property;_BumpMap;Normal Map;3;0;Create;False;0;0;0;False;2;Tex(GroupMain, _NormalStrength);Normal;False;-1;None;5a8dbf8de31773b44a504bf5e7b18c14;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;33;-801.1322,802.7585;Inherit;True;Property;_Metallic;Metallic (R);5;0;Create;False;0;0;0;False;1;Tex(GroupMain, _MetallicStrength);False;-1;None;c442fcc08a4e82248bff31a919159a1a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;-1093.884,630.744;Inherit;False;Property;_NormalStrength;Normal Strength;4;0;Create;True;0;0;0;False;1;HideInInspector;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;238;-781.1252,989.9026;Inherit;False;Property;_MetallicStrength;Metallic Strength;6;0;Create;True;0;0;0;False;2;Sub(GroupMain);HideInInspector;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;280;-797.6268,1164.135;Inherit;True;Property;_Smoothness;Smoothness (G);7;0;Create;False;0;0;0;False;1;Tex(GroupMain,_SmoothnessStrength);False;-1;None;82dd92c9ed96fe440b91b4b1cc107d75;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;239;-777.0747,1350.389;Inherit;False;Property;_SmoothnessStrength;Smoothness Strength;8;0;Create;True;0;0;0;False;2;Sub(GroupMain);HideInInspector;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;639;-2201.305,-1719.195;Inherit;False;Property;_StencilBufferReference;Stencil Buffer Reference;34;0;Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;3;Tooltip(The value to be compared against if Comp is anything else than always, andor the value to be written to the buffer if either Pass, Fail or ZFail is set to replace.);Sub(GroupAdv);Title(GroupAdv, Stencil Buffer);False;0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;638;-2203.305,-1645.195;Inherit;False;Property;_StencilBufferReadMask;Stencil Buffer Read Mask;35;0;Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;2;Tooltip(An 8 bit mask as a 0 to 255 integer, used when comparing the reference value with the contents of the buffer comparisonFunction.);Sub(GroupAdv);False;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;640;-2202.305,-1571.195;Inherit;False;Property;_StencilBufferWriteMask;Stencil Buffer Write Mask;36;0;Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;2;Tooltip(An 8 bit mask as a 0 to 255 integer, used when writing to the buffer.);Sub(GroupAdv);False;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;642;-2203.606,-1499.195;Inherit;False;Property;_StencilBufferComparison;Stencil Buffer Comparison;37;0;Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;2;Tooltip(The function used to compare the reference value to the current contents of the buffer.);SubKeywordEnum(GroupAdv, Disabled,Never,Less,Equal,LessEqual,Greater,NotEqual,GreaterEqual,Always);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;636;-2204.606,-1426.195;Inherit;False;Property;_StencilBufferPassFront;Stencil Buffer Pass Front;38;0;Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;2;Tooltip(What to do with the contents of the buffer if the stencil test, and the depth test, passes.);SubKeywordEnum(GroupAdv, Keep,Zero,Replace,IncrementSaturate,DecrementSaturate,Invert,IncrementWrap,DecrementWrap);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;641;-2204.606,-1351.195;Inherit;False;Property;_StencilBufferFailFront;Stencil Buffer Fail Front;39;0;Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;2;Tooltip(What to do with the contents of the buffer if the stencil test fails.);SubKeywordEnum(GroupAdv, Keep,Zero,Replace,IncrementSaturate,DecrementSaturate,Invert,IncrementWrap,DecrementWrap);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;637;-2202.606,-1276.195;Inherit;False;Property;_StencilBufferZFailFront;Stencil Buffer ZFail Front;40;0;Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;2;Tooltip(What to do with the contents of the buffer if the stencil test passes, but the depth test fails.);SubKeywordEnum(GroupAdv, Keep,Zero,Replace,IncrementSaturate,DecrementSaturate,Invert,IncrementWrap,DecrementWrap);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;603;-1793.453,-1721.893;Inherit;False;Property;_ZWrite;ZWrite Mode;41;0;Create;False;0;2;Off;0;On;1;0;True;3;Tooltip(Controls whether pixels from this object are written to the depth buffer. If youre drawing solid objects, leave this on. If youre drawing semitransparent effects, switch to ZWrite Off.);SubKeywordEnum(GroupAdv, Off,On);Title(GroupAdv, Depth);False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;604;-1793.748,-1644.111;Inherit;False;Property;_ZTest;ZTest Mode;42;0;Create;False;0;0;1;UnityEngine.Rendering.CompareFunction;True;2;Tooltip(How depth testing is performed.);SubKeywordEnum(GroupAdv, Disabled,Never,Less,Equal,LessEqual,Greater,NotEqual,GreaterEqual,Always);False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;605;-1796.299,-1561.616;Inherit;False;Property;_DepthOffsetFactor;Depth Offset Factor;43;0;Create;True;0;0;0;True;2;Tooltip(Scales the maximum Z slope, with respect to X or Y of the polygon.);Sub(GroupAdv);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;606;-1794.577,-1479.526;Inherit;False;Property;_DepthOffsetUnits;Depth Offset Units;44;0;Create;True;0;0;0;True;2;Tooltip(Units scale of the minimum resolvable depth buffer value.);Sub(GroupAdv);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;15;-2927.067,-242.1784;Inherit;False;Property;_TilingOffset;Tiling & Offset;16;0;Create;True;0;0;0;False;2;Tooltip(Effects Tiling and Offset values for all textures and masks in the Main Textures and Settings section.);Sub(GroupMain);False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-2237.737,-264.885;Inherit;True;Property;_ParallaxMap;Height Map (B);12;0;Create;False;0;0;0;False;1;Tex(GroupMain, _HeightStrength);False;-1;None;20ade491c183e64478331f08cdc27e7d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-2216.358,-74.56319;Inherit;False;Property;_HeightStrength;Height Strength;13;0;Create;True;0;0;0;False;1;HideInInspector;False;0.01;0.01;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;477;-787.8795,1577.493;Inherit;True;Property;_OcclusionMap;Occlusion Map (R);14;0;Create;False;0;0;0;False;2;Tooltip(Any values less than one will darken the entire model. Adjust strength value with caution.);Tex(GroupMain,_OcclusionStrength);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;602;-2908.309,-1895.123;Inherit;False;Property;_AdvancedOptionsRendering;Advanced Options & Rendering;27;0;Create;True;0;0;0;True;2;Space(10);Main(GroupAdv, _, off, off);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;244;-2886.636,-1978.323;Inherit;False;Property;_MainTexturesSettings;Main Textures & Settings;0;0;Create;True;0;0;0;True;1;Main(GroupMain, _, off, off);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;648;367.1862,-169.4809;Inherit;False;Symm's Cel Shaded Lighting;17;;1;108cbb651d697e245bcba4f1d01ed1fa;0;5;225;FLOAT3;1,1,1;False;226;FLOAT3;0,0,1;False;227;FLOAT;1;False;228;FLOAT;1;False;566;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;631;-2884.782,-1724.561;Inherit;False;Property;_BlendRGBSource;Blend RGB Source;28;0;Create;True;0;2;Off;0;On;1;1;UnityEngine.Rendering.BlendMode;True;3;Tooltip(Defines how pixel colors are blended together.);SubKeywordEnum(GroupAdv, Zero,One,DstColor,SrcColor,OneMinusDstColor,DstAlpha,OneMinusDstAlpha,SrcAlphaSaturate,OneMinusSrcAlpha);Title(GroupAdv, Blend RGB Values);False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;626;-2886.87,-1646.184;Inherit;False;Property;_BlendRGBDestination;Blend RGB Destination;29;0;Create;True;0;2;Off;0;On;1;1;UnityEngine.Rendering.BlendMode;True;2;Tooltip(Defines how pixel colors are blended together.);SubKeywordEnum(GroupAdv, Zero,One,DstColor,SrcColor,OneMinusDstColor,DstAlpha,OneMinusDstAlpha,SrcAlphaSaturate,OneMinusSrcAlpha);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;627;-2883.851,-1568.767;Inherit;False;Property;_BlendOpRGB;Blend Op RGB;30;0;Create;True;0;2;Off;0;On;1;1;UnityEngine.Rendering.BlendOp;True;2;Tooltip(Defines how pixel colors are blended together.);SubKeywordEnum(GroupAdv, Add,Subtract,ReverseSubtract,Min,Max);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;630;-2881.525,-1452.239;Inherit;False;Property;_BlendAlphaSource;Blend Alpha Source;31;0;Create;True;0;2;Off;0;On;1;1;UnityEngine.Rendering.BlendMode;True;3;Tooltip(Defines how pixel colors are blended together.);SubKeywordEnum(GroupAdv, Zero,One,DstColor,SrcColor,OneMinusDstColor,DstAlpha,OneMinusDstAlpha,SrcAlphaSaturate,OneMinusSrcAlpha);Title(GroupAdv, Blend Alpha Values);False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;629;-2882.525,-1370.239;Inherit;False;Property;_BlendAlphaDestination;Blend Alpha Destination;32;0;Create;True;0;2;Off;0;On;1;1;UnityEngine.Rendering.BlendMode;True;2;Tooltip(Defines how pixel colors are blended together.);SubKeywordEnum(GroupAdv, Zero,One,DstColor,SrcColor,OneMinusDstColor,DstAlpha,OneMinusDstAlpha,SrcAlphaSaturate,OneMinusSrcAlpha);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;628;-2880.507,-1292.821;Inherit;False;Property;_BlendOpAlpha;Blend Op Alpha;33;0;Create;True;0;2;Off;0;On;1;1;UnityEngine.Rendering.BlendOp;True;2;Tooltip(Defines how pixel colors are blended together.);SubKeywordEnum(GroupAdv, Add,Subtract,ReverseSubtract,Min,Max);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;612;-2525.255,-1726.879;Inherit;False;Property;_AlphatoCoverage;Alpha to Coverage;45;0;Create;True;0;2;Off;0;On;1;0;True;3;Tooltip(Turns on internal MSAA capabilities to blend alpha objects using layers of opaque objects, Only available for forward rendering with MSAA turned on.);SubKeywordEnum(GroupAdv, Off,On);Title(GroupAdv, Blend Mode Misc.);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;632;-2526.442,-1651.619;Inherit;False;Property;_ColorMask;Color Mask;46;0;Create;True;0;0;1;UnityEngine.Rendering.ColorWriteMask;True;2;Tooltip(Sets color channel writing mask, turning them all OFF makes it invisible.);SubEnum(GroupAdv, Off,0,Alpha,1,Blue,2,Green,4,Red,8,RGB,14,RGBA,15);False;15;15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;645;-2526.298,-1578.817;Inherit;False;Property;_CullMode;Cull Mode;47;0;Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;2;Tooltip(Front, Cull frontfacing geometry. Back, Cull backfacing geometry. Off, Double sided geometry.);SubKeywordEnum(GroupAdv, Off,Front,Back);False;2;15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;650;2015.134,-171.7547;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;649;1813.134,-176.7547;Inherit;False;500;var_AlbedoRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;350;1952.394,-254.0988;Inherit;False;348;FinalEmissive;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-820.0197,-262.0853;Inherit;True;Property;_MainTex;Main Texture (RGBA);1;0;Create;False;0;0;0;False;2;Tex(GroupMain);NoScaleOffset;False;-1;None;310987d24e42b4941bf251b528317e95;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;224;-732.3955,212.4774;Inherit;False;Property;_EmissionTint;Emission Tint;10;0;Create;True;0;0;0;False;2;HDR;HideInInspector;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;514;-797.4875,379.4106;Inherit;False;Property;_EmissionMultiplier;Emission Multiplier;11;0;Create;True;0;0;0;False;1;Sub(GroupMain);False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;349;1916.624,47.26981;Inherit;False;347;FinalCustomLighting;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;651;1869.303,-28.99582;Inherit;False;Property;_AlphaClip;Alpha Clip;2;0;Create;True;0;0;0;True;1;Sub(GroupMain);False;0.5;0.5;0;1;0;1;FLOAT;0
WireConnection;0;2;350;0
WireConnection;0;10;650;3
WireConnection;0;13;349;0
WireConnection;347;0;648;0
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
WireConnection;648;225;506;0
WireConnection;648;226;507;0
WireConnection;648;227;508;0
WireConnection;648;228;509;0
WireConnection;648;566;510;0
WireConnection;650;0;649;0
WireConnection;2;1;468;0
ASEEND*/
//CHKSM=4CB172902D31B6D968B048C13033B2640CEDF7E3