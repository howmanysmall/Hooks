--!optimize 2
--!strict
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Packages.React)
local Object = require(script.Parent.Packages.LuauPolyfill).Object
local useSyncExternalStore = require(script.Parent.useSyncExternalStore)

type Selector<Snapshot, Selected> = (snapshot: Snapshot) -> Selected
type EqualityFn<Selected> = (left: Selected, right: Selected) -> boolean

type IInstHasValue<Selected> = {
	hasValue: true,
	value: Selected,
}

type IInst<Selected> = {
	hasValue: false,
	value: nil,
} | IInstHasValue<Selected>

--[=[
	A polyfill for React 18's `useSyncExternalStore` hook that allows for a selector.

	:::info
	For more info, check out the [issue](https://github.com/reactwg/react-18/discussions/86) on the React 18 Working Group.
	:::

	@tag Polyfill
	@within Hooks

	@param subscribe (onStoreChange: () -> ()) -> () -> () -- A function that subscribes to the external store.
	@param getSnapshot () -> Snapshot -- A function that returns the current snapshot of the external store.
	@param selector (snapshot: Snapshot) -> Selected -- A selector function that is used to select a value from the snapshot.
	@param isEqual? (left: Selected, right: Selected) -> boolean -- A function used to determine if the selected value has changed.
	@return Selected -- The selected value for the current snapshot of the external store.
]=]
local function useSyncExternalStoreWithSelector<Snapshot, Selected>(
	subscribe: (onStoreChange: () -> ()) -> () -> (),
	getSnapshot: () -> Snapshot,
	selector: Selector<Snapshot, Selected>,
	isEqual: EqualityFn<Selected>?
)
	local instRef = React.useRef(nil :: IInst<Selected>?)
	local inst: IInst<Selected>

	if instRef.current == nil then
		inst = {
			hasValue = false,
			value = nil,
		}

		instRef.current = inst
	else
		inst = instRef.current
	end

	local getSelection = React.useMemo(function()
		local hasMemo = false
		local memoizedSnapshot: Snapshot?
		local memoizedSelection: Selected?

		local function memoizedSelector(nextSnapshot: Snapshot): Selected
			if not hasMemo then
				hasMemo = true
				memoizedSnapshot = nextSnapshot

				local nextSelection = selector(nextSnapshot)
				if isEqual then
					if inst.hasValue == true then
						local currentSelection = inst.value
						if isEqual(currentSelection, nextSelection) then
							memoizedSelection = currentSelection
							return currentSelection
						end
					end
				end

				memoizedSelection = nextSelection
				return nextSelection
			end

			local previousSnapshot = memoizedSnapshot
			local previousSelection = memoizedSelection :: Selected
			if Object.is(previousSnapshot, nextSnapshot) then
				return previousSelection :: Selected
			end

			local nextSelection = selector(nextSnapshot)
			if isEqual and isEqual(previousSelection, nextSelection) then
				return previousSelection :: Selected
			end

			memoizedSnapshot = nextSnapshot
			memoizedSelection = nextSelection
			return nextSelection
		end

		local function getSnapshotWithSelector(): Selected
			return memoizedSelector(getSnapshot())
		end

		return getSnapshotWithSelector
	end, GetDependencies(getSnapshot, selector, isEqual))

	local value = useSyncExternalStore(subscribe, getSelection)
	React.useEffect(function()
		(inst :: IInstHasValue<Selected>).hasValue = true;
		(inst :: IInstHasValue<Selected>).value = value
	end, GetDependencies(value))

	return value
end

return useSyncExternalStoreWithSelector
