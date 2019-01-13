PERLIN_NOISE_GEN = {}
PERLIN_NOISE_GEN.__index = PERLIN_NOISE_GEN




function PERLIN_NOISE_GEN:create()
	local gen = {}
	setmetatable(gen,PERLIN_NOISE_GEN)
	gen.seed = math.random(0,1000)
	return gen
end




function PERLIN_NOISE_GEN:prng(x)
	// expects an integer
	return util.SharedRandom("pnrg",0,1,x)
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




function PERLIN_NOISE_GEN:GenPerlinNoise(x, speed, persistence, octaves)
	// expects a float
	local total = 0
	local den = 0
	for i = 0, oct - 1 do
		local freq = math.pow(2,i)
		local amp = math.pow(persistence,i)
		den = den + amp
		total = total + self:InterpolatedNoise(x*speed*freq)*ampl
	end
	total = total / den
	return total
end 