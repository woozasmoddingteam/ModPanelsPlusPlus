ModLoader.SetupFileHook("lua/Gamerules.lua", "lua/ModPanelsPlusPlus/Gamerules.lua", "post")

if Shared.GetBuildNumber() < 315 then
	ModLoader.SetupFileHook("lua/ReadyRoomPlayer.lua", "lua/ModPanelsPlusPlus/ReadyRoomPlayer.lua", "replace")
	ModLoader.SetupFileHook("lua/Player.lua", "lua/ModPanelsPlusPlus/Player.lua", "post")
end

kModPanels = {}

local dot = string.byte('.')
local slash = string.byte('/')

local function parse_path(path)
	local stop
	for i = #path, 1, -1 do
		if path:byte(i) == dot then
			stop = i-1
		elseif path:byte(i) == slash then
			return path:sub(i+1, stop), path:sub(1, stop)
		end
	end
	local v = path:sub(1, stop)
	return v, v
end

function AddModPanel(values, maybe_url)
	assert(#kModPanels < 255, "Can not add more mod panels! Max: 255")
	if type(values) == "string" then
		values = {
			material = values,
			url      = maybe_url
		}
	end
	assert(values.material, "Material file required!")
	if not values.name then
		values.name = parse_path(values.material)
	end
	PrecacheAsset(values.material)
	table.insert(kModPanels, values)
end

local panels = {}
Shared.GetMatchingFileNames("modpanels/*.material", true, panels)
for _, file in ipairs(panels) do
	local data = {}
	setfenv(assert(loadfile(file)), data)()
	data.material = file
	local name, path = parse_path(file)
	path = path .. ".lua"
	if GetFileExists(path) then
		assert(loadfile(path))(data)
	end
	AddModPanel(data)
end
