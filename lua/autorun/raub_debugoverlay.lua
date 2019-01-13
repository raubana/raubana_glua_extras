local debugoverlay = debugoverlay




debugoverlay.ThickLine = function(pos1, pos2, size, lifetime, color)
	local size = size / 2
	local center = (pos1 + pos2)/2
	local dif = (pos1 - pos2)
	local length = dif:Length() / 2
	local ang = dif:Angle()
	debugoverlay.BoxAngles(center, Vector(-length,-size,-size), Vector(length,size,size), ang, lifetime, color)
end




debugoverlay.Node = function(pos, size, lifetime, color)
	local size = size / 2
	debugoverlay.BoxAngles(pos, Vector(-size,-size,-size), Vector(size,size,size), angle_zero, lifetime, color)
end




debugoverlay.Circle = function( pos, angle, radius, lifetime, color, ignorez)
	local circ = 2*math.pi*radius
	local parts = math.ceil(circ/15)+2
	
	local points = {}
	for i = 0, parts-1 do
		local p = i / parts
		local a = p * 360
		local point = Vector(0,0,radius)
		point:Rotate(angle + Angle(0,0,a))
		point = point + pos
		table.insert(points, point)
	end
	
	for i = 1, parts do
		debugoverlay.Line(points[i], points[i%parts + 1], lifetime, color, ignorez)
	end
end




debugoverlay.AAWireBox = function( mins, maxs, lifetime, color, ignorez )
	local a = mins
	local b = Vector(maxs.x, mins.y, mins.z)
	local c = Vector(maxs.x, mins.y, maxs.z)
	local d = Vector(mins.x, mins.y, maxs.z)
	
	local e = Vector(mins.x, maxs.y, mins.z)
	local f = Vector(maxs.x, maxs.y, mins.z)
	local g = maxs
	local h = Vector(mins.x, maxs.y, maxs.z)
	
	debugoverlay.Line(a, b, lifetime, color, ignorez)
	debugoverlay.Line(b, c, lifetime, color, ignorez)
	debugoverlay.Line(c, d, lifetime, color, ignorez)
	debugoverlay.Line(d, a, lifetime, color, ignorez)
	
	debugoverlay.Line(e, f, lifetime, color, ignorez)
	debugoverlay.Line(f, g, lifetime, color, ignorez)
	debugoverlay.Line(g, h, lifetime, color, ignorez)
	debugoverlay.Line(h, e, lifetime, color, ignorez)
	
	debugoverlay.Line(a, e, lifetime, color, ignorez)
	debugoverlay.Line(b, f, lifetime, color, ignorez)
	debugoverlay.Line(c, g, lifetime, color, ignorez)
	debugoverlay.Line(d, h, lifetime, color, ignorez)
end