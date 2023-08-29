--!optimize 2
local CollectionService = game:GetService("CollectionService")
local React = require(script.Parent.Parent.RoactCompat)
local useBinding = require(script.Parent.useBinding)

local function useTaggedBinding(tagName: string): React.ReactBinding<{Instance}>
	local tagged, setTagged = useBinding(CollectionService:GetTagged(tagName))

	React.useEffect(function()
		local onAdded = CollectionService:GetInstanceAddedSignal(tagName):Connect(function(object: Instance)
			local new = tagged:getValue()
			table.insert(new, object)
			setTagged(new)
		end)

		local onRemoved = CollectionService:GetInstanceRemovedSignal(tagName):Connect(function(object: Instance)
			local index = table.find(tagged, object)
			if index then
				local new = table.clone(tagged:getValue())
				local length = #new
				new[index] = new[length]
				new[length] = nil
				setTagged(new)
			end
		end)

		return function()
			onAdded:Disconnect()
			onRemoved:Disconnect()
		end
	end, {})

	return tagged
end

return useTaggedBinding
