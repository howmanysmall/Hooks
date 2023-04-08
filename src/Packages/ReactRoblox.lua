if not script.Parent.Parent.Parent:FindFirstChild("ReactRoblox") then
	error("ReactRoblox is not installed?", 2)
end

return require(script.Parent.Parent.Parent.ReactRoblox)
