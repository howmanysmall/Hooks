--!optimize 2
--!strict
local function ShallowEqual(a: any, b: any)
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	local keys = {}
	local length = 0
	for key in a do
		length += 1
		keys[key] = true
	end

	local bLength = 0
	for _ in b do
		bLength += 1
	end

	if length ~= bLength then
		return false
	end

	for _, key in keys do
		if b[key] == nil then
			return false
		end

		if a[key] ~= b[key] then
			return false
		end
	end

	return true
end

return ShallowEqual
