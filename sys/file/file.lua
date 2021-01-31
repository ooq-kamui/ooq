log.scrpt("file.lua")

file = {
	key = "ooq",
	ext = "tbl",
	ver = "000.000.000",

	_ts = nil,
}

function file.w(file_name_fl, data)
	
	local st = sys.save(file_name_fl, data)

	if not st then
		Msg.s("save err file:"..file_name_fl) -- mv game ?
		return
	end
end

function file.r(file_name_fl)
	local data = sys.load(file_name_fl)
	if not data then data = {} end
	return data
end

function file.d(file_name_fl)
	local data = {}
	file.w(file_name_fl, data)
end

function file.dstrct_2_str(dstrct)
	local x_sign, y_sign = num._2_sign(dstrct.x), num._2_sign(dstrct.y)
	local x     , y      = math.abs(   dstrct.x), math.abs(   dstrct.y)
	local str = "x"..x_sign..int.pad(x, 2)..".y"..y_sign..int.pad(y, 2)
	return str
end

function file.file_name_fl(file_name)
	local file_name_fl = sys.get_save_file(file.key, file_name)
	return file_name_fl
end

-- ts

function file.ts__()
	file._ts = ts.now()
end

function file.ts()
	if not file._ts then return end
	return file._ts
end

function file.ts_str()
	if not file._ts then return end
	return ts.str(file._ts)
end

-- ply_slt

file.ply_slt = {
	idx_max = 4,
}

-- file name

function file.ply_slt.file_name_ee(ply_slt_idx) -- ee : excld ext
	local file_name_ee = "slt"..int.pad(ply_slt_idx, 2)
	return file_name_ee
end

function file.ply_slt.file_name(ply_slt_idx)
	local file_name_ee = file.ply_slt.file_name_ee(ply_slt_idx)
	local file_name    = file_name_ee.."."..file.ext
	return file_name
end

function file.ply_slt.file_name_fl(ply_slt_idx)
	local file_name    = file.ply_slt.file_name(ply_slt_idx)
	local file_name_fl = file.file_name_fl(file_name)
	return file_name_fl
end
