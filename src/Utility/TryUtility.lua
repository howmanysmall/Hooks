--!optimize 2
--!strict

local TryUtility = {}

TryUtility.TRY_RETURN = 1
TryUtility.TRY_BREAK = 2
TryUtility.TRY_CONTINUE = 3

function TryUtility.Try<T>(
	callback: () -> (number?, {T}?),
	onCatch: nil | (exception: string, traceback: string) -> (number?, {T}?),
	onFinally: nil | () -> (number?, {T}?)
)
	local exception, traceback
	local success, exitType, returns = xpcall(callback, function(errorInner)
		exception = errorInner
		traceback = debug.traceback()
	end)

	if not success and onCatch then
		local newExitType, newReturns = onCatch(exception, traceback)
		if newExitType then
			exitType, returns = newExitType, newReturns
		end
	end

	if onFinally then
		local newExitType, newReturns = onFinally()
		if newExitType then
			exitType, returns = newExitType, newReturns
		end
	end

	return exitType, returns
end

table.freeze(TryUtility)
return TryUtility
