--!optimize 2
--!strict
local LuauPolyfill = require(script.Parent.Packages.LuauPolyfill)
local React = require(script.Parent.Packages.React)

local Object = LuauPolyfill.Object
local console = LuauPolyfill.console

-- TODO: Make this better.

--[=[
	Quickly see which prop changed and caused a re-render by adding a single line to the component.

	@tag Debug
	@within Hooks

	@param name string -- The name of the component.
	@param props table -- The props of the component.
]=]
local function useWhyDidYouUpdate<T>(name: string, props: T)
	assert(type(props) == "table", "Props must be a table!")

	local previousProps = React.useRef(props :: T)
	React.useEffect(function()
		local previous = previousProps.current
		assert(type(previous) == "table", "Failed type cast check.")

		local keysMerged = table.clone(previous)
		for key, value in props do
			keysMerged[key] = value
		end

		local allKeys = Object.keys(keysMerged)
		local changesObject = {}

		for _, key in allKeys do
			local from = previous[key]
			local to = props[key]
			if from ~= to then
				changesObject[key] = {
					from = from,
					to = to,
				}
			end
		end

		if next(changesObject) ~= nil then
			console.log("[useWhyDidYouUpdate]", name, changesObject)
		end

		previousProps.current = props
	end, Object.values(props))
end

return useWhyDidYouUpdate
