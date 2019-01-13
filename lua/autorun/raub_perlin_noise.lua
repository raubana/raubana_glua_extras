PERLIN_NOISE_GEN = {}
PERLIN_NOISE_GEN.__index = PERLIN_NOISE_GEN




function PERLIN_NOISE_GEN:create( speed, pers, oct, seed )
	local gen = {}
	setmetatable(gen,PERLIN_NOISE_GEN)
	
	gen.speed = speed
	gen.pers = pers
	gen.oct = oct
	if seed then
		gen.seed = seed
	else
		gen.seed = math.random( 0, 100000 )
	end
	return gen
end




function PERLIN_NOISE_GEN:prng(x)
	// expects an integer
	return util.SharedRandom( "pnrg", 0, 1, x + self.seed )
end




function PERLIN_NOISE_GEN:SmoothedNoise(x)
	// expects a float
	return self:prng(x)/2 + self:prng(x-1)/4  +  self:prng(x+1)/4
end




function PERLIN_NOISE_GEN:InterpolatedNoise(x)
	// expects a float
	local frac_x = math.mod(x,1)
	local int_x = x-frac_x
	local v1 = self:SmoothedNoise(int_x)
	local v2 = self:SmoothedNoise(int_x + 1)
	return Lerp((1-math.cos(frac_x*math.pi))/2,v1,v2)
end




function PERLIN_NOISE_GEN:gen( x )
	// expects a float
	local total = 0
	local den = 0
	for i = 0, self.oct - 1 do
		local freq = math.pow(2,i)
		local amp = math.pow(self.pers,i)
		den = den + amp
		total = total + self:InterpolatedNoise(x*self.speed*freq)*amp
	end
	total = total / den
	return total
end 