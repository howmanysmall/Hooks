if not script.Parent.Parent.Parent:FindFirstChild("LuauPolyfill") then
	error("LuauPolyfill is not installed?", 2)
end

return require(script.Parent.Parent.Parent.LuauPolyfill)
