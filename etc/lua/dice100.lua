log.scrpt("dice100.lua")

dice100 = {
	dice     = nil,
	dice_add = 0,
}

function dice100.throw()
	dice100.dice     = rnd.int(1, 100)
	dice100.dice_add = 0
end

function dice100.chk(per)
	
	if dice100.dice <= dice100.dice_add then return _.f end

	local ret = _.f
	dice100.dice_add = dice100.dice_add + per
	if dice100.dice <= dice100.dice_add then
		ret = _.t
		dice100.dice     = 0
		dice100.dice_add = 0
	end
	return ret
end
