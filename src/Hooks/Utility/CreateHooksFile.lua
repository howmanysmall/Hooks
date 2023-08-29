--!optimize 2
local Selection = game:GetService("Selection")

local BASE_STRING = [[--!optimize 2
local GetDependencies = require(script.Utility.GetDependencies)
local React = require(script.Parent.RoactCompat)

%s

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

%s

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

%s
table.freeze(Hooks)
return Hooks
]]

local Hooks = Selection:Get()[1]
assert(Hooks, "You must be selecting the Hooks ModuleScript.")
assert(Hooks:IsA("ModuleScript"), "This isn't the Hooks ModuleScript.")
assert(Hooks.Name == "Hooks", "This isn't the Hooks ModuleScript.")
local Utility = assert(Hooks:FindFirstChild("Utility"), "This isn't the Hooks ModuleScript.")
assert(Utility:FindFirstChild("GetDependencies"), "This isn't the Hooks ModuleScript.")

local RequireString = {}
local TableString = {}

local Length = 0
local FoundUseTheme = false

local Children = Hooks:GetChildren()
table.sort(Children, function(A, B)
	return A.Name < B.Name
end)

for _, Child in Children do
	local LowerName = string.lower(Child.Name)
	if string.sub(LowerName, 1, 3) == "use" then
		Length += 1

		local FixName = string.gsub(Child.Name, "^use", "Use")
		RequireString[Length] = `local {FixName} = require(script.{Child.Name})`
		TableString[Length] = `\t{FixName} = {FixName},`

		if LowerName == "usetheme" then
			FoundUseTheme = true
		end
	end
end

print(string.format(
	BASE_STRING,
	table.concat(RequireString, "\n"),
	table.concat(TableString, "\n"),
	if FoundUseTheme then "export type ThemeData = UseTheme.ThemeData\n" else ""
))
