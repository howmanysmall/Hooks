--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Parent.RoactCompat)
local Sift = require(script.Parent.Parent.Sift)

local Sift_Dictionary_merge = Sift.Dictionary.merge

local function useDefaultProperties<T, V>(props: T, defaultProps: V): T & V
	return React.useMemo(function()
		return Sift_Dictionary_merge(defaultProps, props)
	end, GetDependencies(defaultProps, props))
end

return useDefaultProperties
