if not script.Parent.Parent.Parent:FindFirstChild("Promise") then
	error("Promise is not installed?", 2)
end

return require(script.Parent.Parent.Parent.Promise)
