--!optimize 2
--!strict
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Packages.React)

local NO_OP = function() end

--[=[
	@interface IUseUncontrolledInput<T>
	.DefaultValue? T -- Initial value for uncontrolled state.
	.FinalValue? T -- Final value for uncontrolled state when Value and DefaultValue are not provided.
	.OnChange? (value: T) -> () -- Controlled state onChange handler.
	.Value? T -- Value for controlled state.
	@within Types
]=]
type IUseUncontrolledInput<T> = {
	DefaultValue: T?,
	FinalValue: T?,
	Value: T?,
	OnChange: nil | (value: T) -> (),
}

type IUseUncontrolledInputPatch<T> = {
	DefaultValue: T?,
	FinalValue: T?,
	Value: T?,
	OnChange: (value: T) -> (),
}

--[=[
	Manage state of both controlled and uncontrolled components.

	@tag State Management
	@within Hooks
	@param input? IUseUncontrolledInput<T> -- The input to use.
	@return T -- The value to use.
	@return (value: T) -> () -- The onChange handler to use.
	@return boolean -- Whether the component is controlled or not.
]=]
local function useUncontrolled<T>(input: IUseUncontrolledInput<T>?)
	local trueInput = React.useMemo(function()
		return {
			DefaultValue = if input then input.DefaultValue else nil,
			FinalValue = if input then input.FinalValue else nil,
			Value = if input then input.Value else nil,
			OnChange = if input then input.OnChange or NO_OP else NO_OP,
		} :: IUseUncontrolledInputPatch<T>
	end, GetDependencies(input))

	local defaultValue = trueInput.DefaultValue
	local finalValue = trueInput.FinalValue
	local onChange = trueInput.OnChange
	local value = trueInput.Value

	local uncontrolledValue, setUncontrolledValue =
		React.useState(if defaultValue ~= nil then defaultValue else finalValue)

	local function handleUncontrolledChange(val: T)
		setUncontrolledValue(val)
		if onChange then
			onChange(val)
		end
	end

	if value ~= nil then
		return value :: T, onChange, true
	end

	return uncontrolledValue :: T, handleUncontrolledChange, false
end

return useUncontrolled
