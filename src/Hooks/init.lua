--!optimize 2
local GetDependencies = require(script.Utility.GetDependencies)
local React = require(script.Parent.RoactCompat)

local UseAsync = require(script.useAsync)
local UseAsyncToBinding = require(script.useAsyncToBinding)
local UseAsyncToState = require(script.useAsyncToState)
local UseBinding = require(script.useBinding)
local UseClickOutside = require(script.useClickOutside)
local UseCurrentCamera = require(script.useCurrentCamera)
local UseDefaultProperties = require(script.useDefaultProperties)
local UseDefaultProperty = require(script.useDefaultProperty)
local UseDidUpdate = require(script.useDidUpdate)
local UseDidUpdateNoProps = require(script.useDidUpdateNoProps)
local UseEffectOnce = require(script.useEffectOnce)
local UseExternalEvent = require(script.useExternalEvent)
local UseForceUpdate = require(script.useForceUpdate)
local UseIdle = require(script.useIdle)
local UseIsGamepad = require(script.useIsGamepad)
local UseJanitor = require(script.useJanitor)
local UseLifecycles = require(script.useLifecycles)
local UseMouse = require(script.useMouse)
local UseProperty = require(script.useProperty)
local UseRainbowColorSequence = require(script.useRainbowColorSequence)
local UseRendersSpy = require(script.useRendersSpy)
local UseRunOnce = require(script.useRunOnce)
local UseSetState = require(script.useSetState)
local UseStrokeScale = require(script.useStrokeScale)
local UseSyncExternalStore = require(script.useSyncExternalStore)
local UseSyncExternalStoreWithSelector = require(script.useSyncExternalStoreWithSelector)
local UseTagged = require(script.useTagged)
local UseTaggedBinding = require(script.useTaggedBinding)
local UseTimeout = require(script.useTimeout)
local UseToggle = require(script.useToggle)
local UseUndo = require(script.useUndo)
local UseViewportSize = require(script.useViewportSize)
local UseWhyDidYouUpdate = require(script.useWhyDidYouUpdate)

type NoReturn = () -> ()
type FunctionReturn = () -> () -> ()

type SetFunction<T> = (CurrentValue: T) -> T

type UseCallback = <T>(callback: T, dependencies: {unknown}?) -> T
type UseEffect = (callback: NoReturn | FunctionReturn, dependencies: {unknown}?) -> ()
type UseMemo = <T>(callback: () -> T, dependencies: {unknown}?) -> T
type UseRef = <T>(value: T) -> {current: T}
type UseState = <T>(value: T) -> (T, (newValue: T | SetFunction<T>) -> ())

local UseCallback = (React.useCallback :: any) :: UseCallback
local UseEffect = (React.useEffect :: any) :: UseEffect
local UseMemo = (React.useMemo :: any) :: UseMemo
local UseRef = (React.useRef :: any) :: UseRef
local UseState = (React.useState :: any) :: UseState

local Hooks = {
	GetDependencies = GetDependencies,

	UseAsync = UseAsync,
	UseAsyncToBinding = UseAsyncToBinding,
	UseAsyncToState = UseAsyncToState,
	UseBinding = UseBinding,
	UseClickOutside = UseClickOutside,
	UseCurrentCamera = UseCurrentCamera,
	UseDefaultProperties = UseDefaultProperties,
	UseDefaultProperty = UseDefaultProperty,
	UseDidUpdate = UseDidUpdate,
	UseDidUpdateNoProps = UseDidUpdateNoProps,
	UseEffectOnce = UseEffectOnce,
	UseExternalEvent = UseExternalEvent,
	UseForceUpdate = UseForceUpdate,
	UseIdle = UseIdle,
	UseIsGamepad = UseIsGamepad,
	UseJanitor = UseJanitor,
	UseLifecycles = UseLifecycles,
	UseMouse = UseMouse,
	UseProperty = UseProperty,
	UseRainbowColorSequence = UseRainbowColorSequence,
	UseRendersSpy = UseRendersSpy,
	UseRunOnce = UseRunOnce,
	UseSetState = UseSetState,
	UseStrokeScale = UseStrokeScale,
	UseSyncExternalStore = UseSyncExternalStore,
	UseSyncExternalStoreWithSelector = UseSyncExternalStoreWithSelector,
	UseTagged = UseTagged,
	UseTaggedBinding = UseTaggedBinding,
	UseTimeout = UseTimeout,
	UseToggle = UseToggle,
	UseUndo = UseUndo,
	UseViewportSize = UseViewportSize,
	UseWhyDidYouUpdate = UseWhyDidYouUpdate,

	UseCallback = UseCallback,
	UseContext = React.useContext,
	UseDebugValue = React.useDebugValue,
	UseEffect = UseEffect,
	UseImperativeHandle = React.useImperativeHandle,
	UseLayoutEffect = React.useLayoutEffect,
	UseMemo = UseMemo,
	UseMutableSource = React.useMutableSource,
	UseReducer = React.useReducer,
	UseRef = UseRef,
	UseState = UseState,
}

table.freeze(Hooks)
return Hooks
