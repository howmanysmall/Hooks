--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local LuauPolyfill = require(script.Parent.Parent.LuauPolyfill)
local React = require(script.Parent.Parent.RoactCompat)
local Shared = require(script.Parent.Parent.Shared)

local useSyncExternalStore = require(script.Parent.useSyncExternalStore)

local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local console = LuauPolyfill.console

local useRef = React.useRef
local useEffect = React.useEffect
local useMemo = React.useMemo
local useDebugValue = React.useDebugValue

local function useSyncExternalStoreWithSelector(subscribe, getSnapshot, getServerSnapshot, selector, isEqual)
	local instRef = useRef(nil)
	local inst

	if instRef.current == nil then
		inst = {
			hasValue = false,
			value = nil,
		}

		instRef.current = inst
	else
		inst = instRef.current
	end

	local getSelection = useMemo(function()
		local hasMemo = false
		local memoizedSnapshot
		local memoizedSelection

		local function memoizedSelector(nextSnapshot)
			if not hasMemo then
				hasMemo = true
				memoizedSnapshot = nextSnapshot

				local _nextSelection = selector(nextSnapshot)
				if isEqual ~= nil then
					if inst.hasValue then
						local currentSelection = inst.value
						if isEqual(currentSelection, _nextSelection) then
							memoizedSelection = currentSelection
							return currentSelection
						end
					end
				end

				memoizedSelection = _nextSelection
				return _nextSelection
			end

			local prevSnapshot = memoizedSnapshot
			local prevSelection = memoizedSelection

			if Object.is(prevSnapshot, nextSnapshot) then
				return prevSelection
			end

			local nextSelection = selector(nextSnapshot)
			if isEqual ~= nil and isEqual(prevSelection, nextSelection) then
				return prevSelection
			end

			memoizedSnapshot = nextSnapshot
			memoizedSelection = nextSelection
			return nextSelection
		end

		local maybeGetServerSnapshot = if getServerSnapshot == nil then nil else getServerSnapshot
		local function getSnapshotWithSelector()
			return memoizedSelector(getSnapshot())
		end

		return getSnapshotWithSelector
	end, GetDependencies(getSnapshot, getServerSnapshot, selector, isEqual))

	local value = useSyncExternalStore(subscribe, getSelection)
	useEffect(function()
		inst.hasValue = true
		inst.value = value
	end, GetDependencies(value))

	useDebugValue(value)
	return value
end

return useSyncExternalStoreWithSelector
