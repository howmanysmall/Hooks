--!optimize 2
--!strict
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local LuauPolyfill = require(script.Parent.Packages.LuauPolyfill)
local React = require(script.Parent.Packages.React)
local TryUtility = require(script.Parent.Utility.TryUtility)

local Object = LuauPolyfill.Object
local console = LuauPolyfill.console

type Inst<Snapshot> = {
	value: Snapshot,
	getSnapshot: () -> Snapshot,
}

local didWarnUncachedGetSnapshot = false
local function checkIfSnapshotChanged<Snapshot>(inst: Inst<Snapshot>)
	local latestGetSnapshot = inst.getSnapshot
	local prevValue = inst.value

	local exitType, returns = TryUtility.Try(function()
		local nextValue = latestGetSnapshot()
		return TryUtility.TRY_RETURN, {not Object.is(prevValue, nextValue)}
	end, function()
		return TryUtility.TRY_RETURN, {true}
	end)

	if exitType then
		assert(returns, "Expected returns to be defined")
		return table.unpack(returns)
	end

	return nil
end

--[=[
	A polyfill for React 18's `useSyncExternalStore` hook.

	:::info
	For more info, check out the [issue](https://github.com/reactwg/react-18/discussions/86) on the React 18 Working Group.
	:::

	@tag Polyfill
	@within Hooks
	@param subscribe (onStoreChange: () -> ()) -> () -> () -- A function that subscribes to the external store.
	@param getSnapshot () -> Snapshot -- A function that returns the current snapshot of the external store.
	@return Snapshot -- The current snapshot of the external store.
]=]
local function useSyncExternalStore<Snapshot>(subscribe: (onStoreChange: () -> ()) -> () -> (), getSnapshot: () -> Snapshot)
	local value = getSnapshot()

	do
		if not didWarnUncachedGetSnapshot then
			local cachedValue = getSnapshot()
			if not Object.is(value, cachedValue) then
				console.warn("The result of getSnapshot should be cached to avoid an infinite loop")
				didWarnUncachedGetSnapshot = true
			end
		end
	end

	local state, forceUpdate = React.useState({
		inst = {
			value = value,
			getSnapshot = getSnapshot,
		},
	})

	local inst = state.inst

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

	return value
end

return useSyncExternalStore
