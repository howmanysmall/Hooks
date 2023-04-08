--!optimize 2
--!strict
local GetTheme = require(script.Parent.Utility.GetTheme)
local React = require(script.Parent.Packages.React)
local useExternalEvent = require(script.Parent.useExternalEvent)

export type ThemeData = GetTheme.ThemeData

--[=[
	A hook that returns the current theme. Used for Plugins.

	@plugin
	@within Hooks
	@return ThemeData -- The current theme.
]=]
local function useTheme()
	local theme, setTheme = React.useState(GetTheme())
	useExternalEvent(settings().Studio.ThemeChanged, function()
		setTheme(GetTheme())
	end)

	return theme
end

return useTheme
