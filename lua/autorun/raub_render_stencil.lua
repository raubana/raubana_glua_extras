if not CLIENT then return end

local render = render




local quad_width = 100000
local quad_height = 100000

render.DrawStencilTestColors = function( context_3d )
	render.SetStencilEnable(true)
	render.OverrideDepthEnable( true, false )
	
	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
	render.SetStencilPassOperation( STENCILOPERATION_KEEP )
	render.SetStencilFailOperation( STENCILOPERATION_KEEP )
	render.SetStencilZFailOperation( STENCILOPERATION_KEEP )
	
	render.SetColorMaterial()
	
	for i = 0, 16 do
		render.SetStencilReferenceValue( i )
		
		local c = HSVToColor((i/17.0) * 360.0, 1.0, 1.0)
		
		if context_3d then
			cam.IgnoreZ(true)
		
			local localplayer = LocalPlayer()
			local cam_pos = localplayer:EyePos()
			local cam_angle = localplayer:EyeAngles()
			local cam_normal = cam_angle:Forward()
		
			render.DrawQuadEasy(
				cam_pos + cam_normal * 10, 
				-cam_normal,
				quad_width,
				quad_height,
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