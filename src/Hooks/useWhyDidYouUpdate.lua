--!optimize 2
local LuauPolyfill = require(script.Parent.Parent.LuauPolyfill)
local React = require(script.Parent.Parent.RoactCompat)
local Sift = require(script.Parent.Parent.Sift)

local console = LuauPolyfill.console

local Sift_Dictionary_keys = Sift.Dictionary.keys
local Sift_Dictionary_merge = Sift.Dictionary.merge

local function useWhyDidYouUpdate<T>(name: string, props: T)
	assert(type(props) == "table", "Props isn't a table.")
	local previousProps = React.useRef(nil :: T?)
	React.useEffect(function()
		if previousProps.current then
			local allKeys = Sift_Dictionary_keys(Sift_Dictionary_merge(previousProps.current, props))
			local changesObject = {}

			for _, key in allKeys do
				if previousProps.current[key] ~= props[key] then
					changesObject[key] = {
						from = previousProps.current[key],
						to = props[key],
					}
				end
			end

			if next(changesObject) ~= nil then
				console.log("[why-did-you-update]", name, changesObject)
			end
		end

		previousProps.current = props
	end)
end

return useWhyDidYouUpdate
