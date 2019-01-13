if SERVER then
	local DEBUG_ADD_RESOURCES = false

	local legal_extensions = {
		txt = true,
		mdl = true,
		mp3 = true,
		wav = true,
		vmt = true,
		vtf = true
	}




	function AddAllResourcesAt(name, path)
		if not path then path = "GAME" end
		if DEBUG_ADD_RESOURCES then print("- "..name..", "..path) end
		local filelist = {}
		local L1,L2 = file.Find(name,path)
		for key,f in pairs(L1) do
			local new_f = string.Replace(name,"*",f)
			if legal_extensions[string.GetExtensionFromFilename(new_f)] then
				if DEBUG_ADD_RESOURCES then print("-- adding "..new_f) end
				resource.AddFile(new_f)
				table.insert(filelist,new_f)
			else
				if DEBUG_ADD_RESOURCES then print("-- skipping "..new_f) end
			end
		end
		for key,dir in pairs(L2) do
			local new_dir = string.Replace(name,"*",dir).."/*"
			AddAllResourcesAt(new_dir)
		end
		return filelist
	end
end