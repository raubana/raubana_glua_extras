if not math then return end




function math.invlerp( c, a, b )
	return math.Clamp((c-a)/(b-a), 0, 1)
end