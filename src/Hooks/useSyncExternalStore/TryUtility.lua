--!optimize 2
--!strict
local TryUtility = {}

TryUtility.TRY_RETURN = 1
TryUtility.TRY_BREAK = 2
TryUtility.TRY_CONTINUE = 3

function TryUtility.Try(Function, Catch, Finally: nil | () -> (...any?))
	local Error, Traceback
	local Success, ExitType, Returns = xpcall(Function, function(ErrorInner)
		Error = ErrorInner
		Traceback = debug.traceback()
	end)

	if not Success and Catch then
		local NewExitType, NewReturns = Catch(Error, Traceback)
		if NewExitType then
			ExitType, Returns = NewExitType, NewReturns
		end
	end

	if Finally then
		local NewExitType, NewReturns = Finally()
		if NewExitType then
			ExitType, Returns = NewExitType, NewReturns
		end
	end

	return ExitType, Returns
end

table.freeze(TryUtility)
return TryUtility
