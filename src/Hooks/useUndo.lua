--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local LuauPolyfill = require(script.Parent.Parent.LuauPolyfill)
local React = require(script.Parent.Parent.RoactCompat)

local UNDO_ACTION = "UNDO"
local REDO_ACTION = "REDO"
local SET_ACTION = "SET"
local RESET_ACTION = "RESET"

local LuauPolyfill_Object_assign = LuauPolyfill.Object.assign

local INITIAL_STATE = {
	Future = {},
	Past = {},
}

local function reducer(state, action)
	local past = state.Past
	local present = state.Present
	local future = state.Future

	if action.type == UNDO_ACTION then
		local length = #past
		if length == 0 then
			return state
		end

		local previous = past[length]
		local newLength = length - 1

		local newPast = table.move(past, 1, newLength, 1, table.create(newLength))
		local newFuture = table.create(#future + 1)
		table.insert(newFuture, present)
		local newFutureLength = #newFuture

		for _, value in future do
			newFutureLength += 1
			newFuture[newFutureLength] = value
		end

		return table.freeze({
			Future = newFuture,
			Past = newPast,
			Present = previous,
		})
	elseif action.type == REDO_ACTION then
		local length = #future
		if length == 0 then
			return state
		end

		local nextValue = future[1]
		local newFuture = table.move(future, 2, length, 1, table.create(length - 1))

		local newPast = table.move(past, 1, #past, 1, table.create(#past + 1))
		table.insert(newPast, present)

		return table.freeze({
			Future = newFuture,
			Past = newPast,
			Present = nextValue,
		})
	elseif action.type == SET_ACTION then
		local newPresent = action.newPresent
		if newPresent == present then
			return state
		end

		local length = #past
		local newPast = table.move(past, 1, length, 1, table.create(length + 1))
		table.insert(newPast, present)

		return table.freeze({
			Future = {},
			Past = newPast,
			Present = newPresent,
		})
	elseif action.type == RESET_ACTION then
		return table.freeze(LuauPolyfill_Object_assign({}, INITIAL_STATE, {Present = action.newPresent}))
	end
end

local function useUndo(initialPresent)
	local state, dispatch = React.useReducer(
		reducer,
		LuauPolyfill_Object_assign(
			{},
			INITIAL_STATE,
			{Present = initialPresent}
		)
	)

	return React.useMemo(function()
		local function undo()
			dispatch({
				type = UNDO_ACTION,
			})
		end

		local function redo()
			dispatch({
				type = REDO_ACTION,
			})
		end

		local function set(newPresent)
			dispatch({
				newPresent = newPresent,
				type = SET_ACTION,
			})
		end

		local function reset(newPresent)
			dispatch({
				newPresent = newPresent,
				type = RESET_ACTION,
			})
		end

		return state, {
			Redo = redo,
			Reset = reset,
			Set = set,
			Undo = undo,

			CanRedo = #state.Future > 0,
			CanUndo = #state.Past > 0,
		}
	end, GetDependencies(state.Past, state.Future))
end

return useUndo
