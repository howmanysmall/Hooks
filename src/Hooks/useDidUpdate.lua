--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Parent.RoactCompat)

local function useDidUpdate<T>(props: T, callback: (previousProps: T) -> (), dependencies: {unknown}?)
	local previousProps = React.useRef(props)
	local onFirstRun = React.useRef(true)

	React.useEffect(function()
		if onFirstRun.current then
			task.defer(function()
				onFirstRun.current = false
			end)
		end
	end, {})

	React.useEffect(function()
		if not onFirstRun.current then
			callback(previousProps.current)
			previousProps.current = props
		end
	end, GetDependencies(props, dependencies))
end

return useDidUpdate

--local React = require(script.Parent.Vendor.React)

--local function useDidUpdate<T>(props: T, callback: (previousProps: T) -> (), dependencies: {unknown}?)
--	local previousProps = React.useRef(props)
--	local onFirstRun = React.useRef(true)

--	React.useEffect(function()
--		if onFirstRun.current then
--			onFirstRun.current = true
--		end
--	end, {})

--	React.useEffect(function()
--		if not onFirstRun.current then
--			callback(previousProps.current)
--			previousProps.current = props
--		end
--	end, {props, dependencies})
--end

--return useDidUpdate
