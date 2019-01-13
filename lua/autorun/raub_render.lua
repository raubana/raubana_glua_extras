if not CLIENT then return end

local render = render




local QUAD_WIDTH = 100000
local QUAD_HEIGHT = 100000

render.DrawStencilTestColors = function( context_3d, layers, opacity )
	render.SetStencilEnable(true)
	render.OverrideDepthEnable( true, false )
	
	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
	render.SetStencilPassOperation( STENCILOPERATION_KEEP )
	render.SetStencilFailOperation( STENCILOPERATION_KEEP )
	render.SetStencilZFailOperation( STENCILOPERATION_KEEP )
	
	render.SetColorMaterial()
	
	for i = 0, layers do
		render.SetStencilReferenceValue( i )
		
		local c = HSVToColor(
			(i/(layers)) * 300.0, 1.0,
			Lerp(((i+1)%2)/2,
			0.5,
			1.0)
		)
		c.a = opacity or 64
		
		if context_3d then
			cam.IgnoreZ(true)
		
			local cam_pos = EyePos()
			local cam_angle = EyeAngles()
			local cam_normal = cam_angle:Forward()
		
			render.DrawQuadEasy(
				cam_pos + cam_normal * 10, 
				-cam_normal,
				QUAD_WIDTH,
				QUAD_HEIGHT,
				c,
				cam_angle.roll
			)
			cam.IgnoreZ(false)
		else
			render.SetColorModulation(c.r/255, c.g/255, c.b/255)
			render.DrawScreenQuad()
		end
	end
	
	render.OverrideDepthEnable( false, false )
	render.SetStencilEnable(false)
end