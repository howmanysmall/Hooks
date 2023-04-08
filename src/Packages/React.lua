if not script.Parent.Parent.Parent:FindFirstChild("React") then
	error("React is not installed?", 2)
end

return require(script.Parent.Parent.Parent.React)
