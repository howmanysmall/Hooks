--!optimize 2
local CollectionService = game:GetService("CollectionService")
local React = require(script.Parent.Parent.RoactCompat)

local function useTagged(tagName: string): {Instance}
	local tagged, setTagged = React.useState(CollectionService:GetTagged(tagName))
	local onInstanceEvent = React.useCallback(function()
		setTagged(CollectionService:GetTagged(tagName))
	end, {})

	--local onInstanceAdded = React.useCallback(function(object: Instance)
	--	local new = table.clone(tagged)
	--	table.insert(new, object)
	--	setTagged(new)
	--end, {tagged})

	--local onInstanceRemoved = React.useCallback(function(object: Instance)
	--	local index = table.find(tagged, object)
	--	if index then
	--		local new = table.clone(tagged)
	--		local length = #new
	--		new[index] = new[length]
	--		new[length] = nil
	--		setTagged(new)
	--	end
	--end, {tagged})

	React.useEffect(function()
		local onAdded = CollectionService:GetInstanceAddedSignal(tagName):Connect(onInstanceEvent)
		local onRemoved = CollectionService:GetInstanceRemovedSignal(tagName):Connect(onInstanceEvent)

		return function()
			onAdded:Disconnect()
			onRemoved:Disconnect()
		end
	end, {})

	return tagged
end

return useTagged
