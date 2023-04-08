--!optimize 2
--!strict
local React = require(script.Parent.Packages.React)
local ShallowEqual = require(script.Parent.Utility.ShallowEqual)

local function ShallowCompare(previousValue: {unknown}, currentValue: {unknown}?)
	if not previousValue or not currentValue then
		return false
	end

	if previousValue == currentValue then
		return true
	end

	if #previousValue ~= #currentValue then
		return false
	end

	for index, value in previousValue do
		if not ShallowEqual(value, currentValue[index]) then
			return false
		end
	end

	return true
end

local function useShallowCompare(dependencies: {unknown}?)
	local ref = React.useRef({} :: {unknown})
	local updatedRef = React.useRef(0)

	assert(ref.current, "This should never throw.")
	assert(updatedRef.current, "This should never throw.")

	if not ShallowCompare(ref.current, dependencies) then
		ref.current = dependencies
		updatedRef.current += 1
	end

	return {updatedRef.current}
end

--[=[
	`useEffect` drop in replacement with dependencies shallow comparison. `useShallowEffect` works
	exactly like `useEffect` but performs shallow dependencies comparison instead of referential comparison.

	@tag Lifecycle
	@within Hooks
	@param callback () -> () -- The callback to run when the dependencies change.
	@param dependencies? {unknown} -- The dependencies to compare.
]=]
local function useShallowEffect(callback: () -> (), dependencies: {unknown}?)
	React.useEffect(callback, useShallowCompare(dependencies))
end

return useShallowEffect
