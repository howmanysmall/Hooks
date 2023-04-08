--!optimize 2
--!strict
local React = require(script.Parent.Packages.React)

type ICurrentValue<T> = {
	Dependencies: {unknown},
	MemoizedValue: T,
}

--[=[
	A hook that memoizes a value and cleans it up when the dependencies change.
	@within Hooks

	@tag State Management
	@param createValue () -> T -- The function to create the value.
	@param cleanupValue (value: T) -> () -- The function to clean up the value.
	@param dependencies? {unknown} -- The dependencies to check for changes.
	@return T -- The memoized value.
]=]
local function useMemoWithCleanup<T>(createValue: () -> T, cleanupValue: (value: T) -> (), dependencies: {unknown}?)
	local trueDependencies: {unknown} = if dependencies then dependencies else {}
	local currentValue = React.useRef(nil :: ICurrentValue<T>?)
	local needsToRecalculate = false

	if not currentValue.current then
		needsToRecalculate = true
	else
		for index, dependency in trueDependencies do
			if dependency ~= currentValue.current.Dependencies[index] then
				needsToRecalculate = true
				break
			end
		end
	end

	if needsToRecalculate then
		local currentValueValue = currentValue.current
		if currentValueValue then
			cleanupValue(currentValueValue.MemoizedValue)
		end

		currentValue.current = {
			Dependencies = trueDependencies,
			MemoizedValue = createValue(),
		}
	end

	React.useEffect(function()
		return function()
			local currentValueValue = currentValue.current
			if currentValueValue then
				cleanupValue(currentValueValue.MemoizedValue)
			end

			currentValue.current = nil
		end
	end, {})

	return (currentValue.current :: ICurrentValue<T>).MemoizedValue
end

return useMemoWithCleanup
