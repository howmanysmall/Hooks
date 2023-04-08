--!optimize 2
--!strict
local Types = require(script.Parent.Types)
export type ThemeData = Types.ThemeData

local function GetTheme(): ThemeData
	debug.profilebegin("GetTheme")
	local studioTheme = settings().Studio.Theme :: StudioTheme
	local theme = {}
	theme.ThemeName = studioTheme.Name

	for _, studioStyleGuideColor in Enum.StudioStyleGuideColor:GetEnumItems() do
		local color = {}
		for _, studioStyleGuideModifier in Enum.StudioStyleGuideModifier:GetEnumItems() do
			color[studioStyleGuideModifier.Name] = studioTheme:GetColor(studioStyleGuideColor, studioStyleGuideModifier)
		end

		theme[studioStyleGuideColor.Name] = table.freeze(color)
	end

	function theme.GetColor(
		studioStyleGuideColor: Enum.StudioStyleGuideColor,
		studioStyleGuideModifier: Enum.StudioStyleGuideModifier?
	)
		return theme[studioStyleGuideColor.Name][if studioStyleGuideModifier
			then studioStyleGuideModifier.Name
			else "Default"]
	end

	local newTheme: ThemeData = table.freeze(theme) :: any
	debug.profileend()
	return newTheme
end

return GetTheme
