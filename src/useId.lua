--!optimize 2
--!strict
local GetRandomId = require(script.Parent.Utility.GetRandomId)
local React = require(script.Parent.Packages.React)

--[=[
	The `useId` hook generates random id that persists across renders. Hook is usually used to bind input elements to labels. Generated random id is saved to ref and will not change unless component is unmounted.

	@tag State Management
	@within Hooks
	@param staticId? string -- A static id to use instead of a generated one.
	@return string -- The generated id.
]=]
local function useId(staticId: string?): string
	local uuid, setUuid = React.useState("")
	React.useLayoutEffect(function()
		setUuid(GetRandomId())
	end, {})

	return if staticId then staticId else uuid
end

return useId
