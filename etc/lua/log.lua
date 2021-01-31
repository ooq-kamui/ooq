log = {}

function log._(...)
	print(...)
end

function log.scrpt(file)
	local flg = _.f
	-- local flg = _.t
	if flg then log._(file) end
end

function log.pp(txt, data)
	log._(txt)
	pprint(data)
end

function log.asrt(txt, data)
	assert(data, txt)
end

function log.fltr_cls(cls, ...)
	
	if not ha.eq(id.cls(id._()), cls) then return end
	-- if not ha.eq(id.cls(go.get_id()), cls) then return end

	log._(cls, ...)
end

-- function log.float_truncation(val, num) -- old
function log.f(txt, val, dgt)
	dgt = dgt or "2"
	local str = string.format("%."..dgt.."f", val)
	log._(txt, str)
	-- return str
end

function log.save_data_tile(tile, y_fr, y_to, x_fr, x_to) -- tile["y_idx_str"]["x_idx_str"]

	for y = y_fr, y_to do
		for x = x_fr, x_to do
			log._(y, x, tile[int._2_str(y)][int._2_str(x)])
		end
	end
end
