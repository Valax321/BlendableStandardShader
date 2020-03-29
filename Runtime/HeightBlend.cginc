/*
	Copyright(c) 2017 Untitled Games
	Written by Chris Bellini

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files(the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions :

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
*/

// Expose this property to control blending:
//		HeightmapBlending("Heightmap Blending", Float) = 0.05
float _HeightmapBlending;

// FLOAT BLENDING ----------------------------------------------------------------------------------------------------
float heightblend(float input1, float height1, float input2, float height2)
{
	float height_start = max(height1, height2) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	return ((input1 * b1) + (input2 * b2)) / (b1 + b2);
}
float heightlerp(float input1, float height1, float input2, float height2, float lerp)
{
	lerp = clamp(lerp, 0, 1);
	return heightblend(input1, height1 * (1 - lerp), input2, height2 * lerp);
}
float heightblend(float input1, float height1, float input2, float height2, float input3, float height3)
{
	float height_start = max(max(height1, height2), height3) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	float b3 = max(height3 - height_start, 0);
	return ((input1 * b1) + (input2 * b2) + (input3 * b3)) / (b1 + b2 + b3);
}
float heightblend(float input1, float height1, float input2, float height2, float input3, float height3, float input4, float height4)
{
	float height_start = max(max(height1, height2), max(height3, height4)) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	float b3 = max(height3 - height_start, 0);
	float b4 = max(height4 - height_start, 0);
	return ((input1 * b1) + (input2 * b2) + (input3 * b3) + (input4 * b4)) / (b1 + b2 + b3 + b4);
}
// -------------------------------------------------------------------------------------------------------------------

// FLOAT2 BLENDING ---------------------------------------------------------------------------------------------------
float2 heightblend(float2 input1, float height1, float2 input2, float height2)
{
	float height_start = max(height1, height2) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	return ((input1 * b1) + (input2 * b2)) / (b1 + b2);
}
float2 heightlerp(float2 input1, float height1, float2 input2, float height2, float lerp)
{
	return heightblend(input1, height1 * (1 - lerp), input2, height2 * lerp);
}
float2 heightblend(float2 input1, float height1, float2 input2, float height2, float2 input3, float height3)
{
	float height_start = max(max(height1, height2), height3) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	float b3 = max(height3 - height_start, 0);
	return ((input1 * b1) + (input2 * b2) + (input3 * b3)) / (b1 + b2 + b3);
}
float2 heightblend(float2 input1, float height1, float2 input2, float height2, float2 input3, float height3, float2 input4, float height4)
{
	float height_start = max(max(height1, height2), max(height3, height4)) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	float b3 = max(height3 - height_start, 0);
	float b4 = max(height4 - height_start, 0);
	return ((input1 * b1) + (input2 * b2) + (input3 * b3) + (input4 * b4)) / (b1 + b2 + b3 + b4);
}
// -------------------------------------------------------------------------------------------------------------------

// FLOAT3 BLENDING ---------------------------------------------------------------------------------------------------
float3 heightblend(float3 input1, float height1, float3 input2, float height2)
{
	float height_start = max(height1, height2) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	return ((input1 * b1) + (input2 * b2)) / (b1 + b2);
}
float3 heightlerp(float3 input1, float height1, float3 input2, float height2, float lerp)
{
	return heightblend(input1, height1 * (1 - lerp), input2, height2 * lerp);
}
float3 heightblend(float3 input1, float height1, float3 input2, float height2, float3 input3, float height3)
{
	float height_start = max(max(height1, height2), height3) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	float b3 = max(height3 - height_start, 0);
	return ((input1 * b1) + (input2 * b2) + (input3 * b3)) / (b1 + b2 + b3);
}
float3 heightblend(float3 input1, float height1, float3 input2, float height2, float3 input3, float height3, float3 input4, float height4)
{
	float height_start = max(max(height1, height2), max(height3, height4)) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	float b3 = max(height3 - height_start, 0);
	float b4 = max(height4 - height_start, 0);
	return ((input1 * b1) + (input2 * b2) + (input3 * b3) + (input4 * b4)) / (b1 + b2 + b3 + b4);
}
// -------------------------------------------------------------------------------------------------------------------

// FLOAT4 BLENDING ---------------------------------------------------------------------------------------------------
float4 heightblend(float4 input1, float height1, float4 input2, float height2)
{
	float height_start = max(height1, height2) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	return ((input1 * b1) + (input2 * b2)) / (b1 + b2);
}
float4 heightlerp(float4 input1, float height1, float4 input2, float height2, float lerp)
{
	return heightblend(input1, height1 * (1 - lerp), input2, height2 * lerp);
}
float4 heightblend(float4 input1, float height1, float4 input2, float height2, float4 input3, float height3)
{
	float height_start = max(max(height1, height2), height3) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	float b3 = max(height3 - height_start, 0);
	return ((input1 * b1) + (input2 * b2) + (input3 * b3)) / (b1 + b2 + b3);
}
float4 heightblend(float4 input1, float height1, float4 input2, float height2, float4 input3, float height3, float4 input4, float height4)
{
	float height_start = max(max(height1, height2), max(height3, height4)) - _HeightmapBlending;
	float b1 = max(height1 - height_start, 0);
	float b2 = max(height2 - height_start, 0);
	float b3 = max(height3 - height_start, 0);
	float b4 = max(height4 - height_start, 0);
	return ((input1 * b1) + (input2 * b2) + (input3 * b3) + (input4 * b4)) / (b1 + b2 + b3 + b4);
}
// Weights the height of each side by the alpha channel
float4 heightblendalpha(float4 input1, float height1, float4 input2, float height2)
{
	float height_start = max(input1.a + height1, input2.a + height2) - _HeightmapBlending;
	float b1 = max(input1.a + height1 - height_start, 0);
	float b2 = max(input2.a + height2 - height_start, 0);
	return ((input1 * b1) + (input2 * b2)) / (b1 + b2);
}
float4 heightlerpalpha(float4 input1, float height1, float4 input2, float height2, float lerp)
{
	return heightblendalpha(input1, height1 * (1 - lerp), input2, height2 * lerp);
}
float4 heightblendalpha(float4 input1, float height1, float4 input2, float height2, float4 input3, float height3)
{
	float height_start = max(max(input1.a + height1, input2.a + height2), input3.a + height3) - _HeightmapBlending;
	float b1 = max(input1.a + height1 - height_start, 0);
	float b2 = max(input2.a + height2 - height_start, 0);
	float b3 = max(input3.a + height3 - height_start, 0);
	return ((input1 * b1) + (input2 * b2) + (input3 * b3)) / (b1 + b2 + b3);
}
float4 heightblendalpha(float4 input1, float height1, float4 input2, float height2, float4 input3, float height3, float4 input4, float height4)
{
	float height_start = max(max(input1.a + height1, input2.a + height2), max(input3.a + height3, input4.a + height4)) - _HeightmapBlending;
	float b1 = max(input1.a + height1 - height_start, 0);
	float b2 = max(input2.a + height2 - height_start, 0);
	float b3 = max(input3.a + height3 - height_start, 0);
	float b4 = max(input4.a + height4 - height_start, 0);
	return ((input1 * b1) + (input2 * b2) + (input3 * b3) + (input4 * b4)) / (b1 + b2 + b3 + b4);
}
// -------------------------------------------------------------------------------------------------------------------
