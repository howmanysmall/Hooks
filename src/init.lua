--!optimize 2
--!strict

local GetDependencies = require(script.Utility.GetDependencies)

local useAsync = require(script.useAsync)
local useClickOutside = require(script.useClickOutside)
local useCurrentCamera = require(script.useCurrentCamera)
local useDelayedValue = require(script.useDelayedValue)
local useExternalEvent = require(script.useExternalEvent)
local useForceUpdate = require(script.useForceUpdate)
local useId = require(script.useId)
local useMemoWithCleanup = require(script.useMemoWithCleanup)
local usePrevious = require(script.usePrevious)
local useRainbowColorSequence = require(script.useRainbowColorSequence)
local useRendersSpy = require(script.useRendersSpy)
local useScale = require(script.useScale)
local useShallowEffect = require(script.useShallowEffect)
local useStrokeScale = require(script.useStrokeScale)
local useSyncExternalStore = require(script.useSyncExternalStore)
local useSyncExternalStoreWithSelector = require(script.useSyncExternalStoreWithSelector)
local useTheme = require(script.useTheme)
local useUncontrolled = require(script.useUncontrolled)
local useViewportSize = require(script.useViewportSize)
local useWhyDidYouUpdate = require(script.useWhyDidYouUpdate)

--[=[
	The extra types for the hooks.
	@class Types
]=]

--[=[
	A collection of hooks made for React.
	@class Hooks
]=]
local Hooks = {
	GetDependencies = GetDependencies,

	useAsync = useAsync,
	useClickOutside = useClickOutside,
	useCurrentCamera = useCurrentCamera,
	useDelayedValue = useDelayedValue,
	useExternalEvent = useExternalEvent,
	useForceUpdate = useForceUpdate,
	useId = useId,
	useMemoWithCleanup = useMemoWithCleanup,
	usePrevious = usePrevious,
	useRainbowColorSequence = useRainbowColorSequence,
	useRendersSpy = useRendersSpy,
	useScale = useScale,
	useShallowEffect = useShallowEffect,
	useStrokeScale = useStrokeScale,
	useSyncExternalStore = useSyncExternalStore,
	useSyncExternalStoreWithSelector = useSyncExternalStoreWithSelector,
	useTheme = useTheme,
	useUncontrolled = useUncontrolled,
	useViewportSize = useViewportSize,
	useWhyDidYouUpdate = useWhyDidYouUpdate,
}

table.freeze(Hooks)
return Hooks
