--!optimize 2
local React = require(script.Parent.Parent.RoactCompat)
local Janitor = require(script.Parent.Parent.Janitor)

local function UseJanitor(janitor: Janitor.Janitor, dependencies: {unknown}?)
	if not Janitor.Is(janitor) then
		error("UseJanitor expects a Janitor!", 3)
	end

	if dependencies then
		if type(dependencies) ~= "table" then
			error("Dependencies must be an array.", 3)
		elseif #dependencies == 0 then
			error("Dependencies should not be empty.", 3)
		end
	end

	local firstRender = React.useRef(true)
	React.useEffect(function()
		if firstRender.current then
			firstRender.current = false
		end
	end, {})

	React.useEffect(function()
		if not firstRender.current then
			janitor:Cleanup()
		end
	end, dependencies)
end

return UseJanitor
