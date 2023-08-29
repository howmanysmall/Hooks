--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local LuauPolyfill = require(script.Parent.Parent.LuauPolyfill)
local React = require(script.Parent.Parent.RoactCompat)
local Shared = require(script.Parent.Parent.Shared)

local TryUtility = require(script.TryUtility)

local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local console = LuauPolyfill.console

local ReactSharedInternals = Shared.ReactSharedInternals

local didWarnUncachedGetSnapshot = false

local function printWarning(level, format, args)
	local ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame
	local stack = ReactDebugCurrentFrame.getStackAddendum()

	if stack ~= "" then
		format ..= "%s"
		args = Array.concat(args, {stack})
	end

	local argsWithFormat = Array.map(args, tostring)
	Array.unshift(argsWithFormat, "Warning: " .. format)
	console[level](argsWithFormat)
end

local function _error(format, ...)
	local arguments = {...}
	local _len2 = #arguments
	local args = table.create(if _len2 > 1 then _len2 - 1 else 0)
	local _key2 = 1
	local _shouldIncrement = false
	while true do
		if _shouldIncrement then
			_key2 += 1
		else
			_shouldIncrement = true
		end
		if not (_key2 < _len2) then
			break
		end
		args[_key2 - 1 + 1] = arguments[_key2 + 1]
	end

	printWarning("error", format, args)
end

local function checkIfSnapshotChanged(inst)
	local latestGetSnapshot = inst.getSnapshot
	local prevValue = inst.value

	local exitType, returns = TryUtility.Try(function()
		local nextValue = latestGetSnapshot()
		return TryUtility.TRY_RETURN, {not Object.is(prevValue, nextValue)}
	end, function()
		return TryUtility.TRY_RETURN, {true}
	end)

	if exitType then
		return table.unpack(returns)
	end
end

local function useSyncExternalStore(subscribe, getSnapshot)
	local value = getSnapshot()

	do
		if not didWarnUncachedGetSnapshot then
			local cachedValue = getSnapshot()
			if not Object.is(value, cachedValue) then
				_error("The result of getSnapshot should be cached to avoid an infinite loop")
				didWarnUncachedGetSnapshot = true
			end
		end
	end

	local _useState = {React.useState({
		inst = {
			value = value,
			getSnapshot = getSnapshot,
		},
	})}

	local inst = _useState[1].inst
	local forceUpdate = _useState[2]

	React.useLayoutEffect(function()
		inst.value = value
		inst.getSnapshot = getSnapshot

		if checkIfSnapshotChanged(inst) then
			forceUpdate({
				inst = inst,
			})
		end
	end, GetDependencies(subscribe, value, getSnapshot))

	React.useEffect(function()
		if checkIfSnapshotChanged(inst) then
			forceUpdate({
				inst = inst,
			})
		end

		local function handleStoreChange()
			if checkIfSnapshotChanged(inst) then
				forceUpdate({
					inst = inst,
				})
			end
		end

		return subscribe(handleStoreChange)
	end, GetDependencies(subscribe))

	React.useDebugValue(value)
	return value
end

return useSyncExternalStore
