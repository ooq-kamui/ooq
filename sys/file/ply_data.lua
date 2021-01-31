log.scrpt("file.ply_data.lua")

file.ply_data = {
	file_idx_max = 4, -- 10,
}

-- save, load, del

function file.ply_data.save(ply_slt_idx, data)

	local file_idx = file.ply_data.file_idx_nxt(ply_slt_idx)
	
	local file_name_fl = file.ply_data.file_name_fl(ply_slt_idx, file_idx)
	
	file.w(file_name_fl, data)

	file.ply_data.thmb.save(ply_slt_idx, file_idx)
	
	file.ply_data.ltst.file_idx__(ply_slt_idx, file_idx)
end

function file.ply_data.load(ply_slt_idx, file_idx)
	local file_name_fl = file.ply_data.file_name_fl(ply_slt_idx, file_idx)
	local data = file.r(file_name_fl)
	return data
end

function file.ply_data.del(ply_slt_idx, file_idx)
	local file_name_fl = file.ply_data.file_name_fl(ply_slt_idx, file_idx)
	file.d(file_name_fl)
end

function file.ply_data.file_idx_ltst(ply_slt_idx)
	local file_idx_ltst = file.ply_data.ltst.file_idx(ply_slt_idx)
	return file_idx_ltst
end

function file.ply_data.file_idx_nxt(ply_slt_idx)

	local file_idx_nxt
	local file_idx_ltst = file.ply_data.file_idx_ltst(ply_slt_idx)

	if not file_idx_ltst then
		file_idx_nxt = 1
	else
		file_idx_nxt = u.inc_loop(file_idx_ltst, file.ply_data.file_idx_max)
	end
	return file_idx_nxt
end

-- file name

function file.ply_data.file_name_ee(ply_slt_idx, file_idx) -- ee : excld ext
	
	local ply_slt_file_name_ee = file.ply_slt.file_name_ee(ply_slt_idx)
	local file_name_ee = ply_slt_file_name_ee..".ply_data.idx"..int.pad(file_idx, 2)
	return file_name_ee
end

function file.ply_data.file_name(ply_slt_idx, file_idx)
	
	local file_name_ee = file.ply_data.file_name_ee(ply_slt_idx, file_idx)
	local file_name    = file_name_ee.."."..file.ext
	return file_name
end

function file.ply_data.file_name_fl(ply_slt_idx, file_idx)
	
	local file_name    = file.ply_data.file_name(ply_slt_idx, file_idx)
	local file_name_fl = file.file_name_fl(file_name)
	return file_name_fl
end

-- ltst

file.ply_data.ltst = {
	key = "file_idx_ltst",
}

function file.ply_data.ltst.save(ply_slt_idx, data)

	local file_name_fl = file.ply_data.ltst.file_name_fl(ply_slt_idx)
	file.w(file_name_fl, data)
end

function file.ply_data.ltst.load(ply_slt_idx)

	local file_name_fl = file.ply_data.ltst.file_name_fl(ply_slt_idx)
	local data = file.r(file_name_fl)
	return data
end

function file.ply_data.ltst.del(ply_slt_idx, file_idx)
	local file_name_fl = file.ply_data.ltst.file_name_fl(ply_slt_idx, file_idx)
	file.d(file_name_fl)
end

function file.ply_data.ltst.file_idx__(ply_slt_idx, file_idx_ltst)

	local data = {}
	data[file.ply_data.ltst.key] = file_idx_ltst

	file.ply_data.ltst.save(ply_slt_idx, data)
end

function file.ply_data.ltst.file_idx(ply_slt_idx)

	local data = file.ply_data.ltst.load(ply_slt_idx)
	
	if not data then return end

	return data[file.ply_data.ltst.key]
end

function file.ply_data.ltst.thmb(ply_slt_idx)

	local file_idx_ltst = file.ply_data.ltst.file_idx(ply_slt_idx)

	if not file_idx_ltst then return {} end

	local thmb = file.ply_data.thmb.load(ply_slt_idx, file_idx_ltst)
	return thmb
end

-- ltst - file name

function file.ply_data.ltst.file_name_fl(ply_slt_idx)

	local ply_slt_file_name_ee = file.ply_slt.file_name_ee(ply_slt_idx)
	local file_name    = ply_slt_file_name_ee..".ply_data.ltst."..file.ext
	local file_name_fl = file.file_name_fl(file_name)
	return file_name_fl
end

-- thmb

file.ply_data.thmb = {}

function file.ply_data.thmb.save(ply_slt_idx, file_idx, data)

	data = data or {ts_str = file.ts_str()}

	local file_name_fl = file.ply_data.thmb.file_name_fl(ply_slt_idx, file_idx)
	file.w(file_name_fl, data)
end

function file.ply_data.thmb.load(ply_slt_idx, file_idx)

	file_idx = file_idx or file.ply_data.ltst.file_idx(ply_slt_idx)

	local file_name_fl = file.ply_data.thmb.file_name_fl(ply_slt_idx, file_idx)
	local data = file.r(file_name_fl)
	return data
end

function file.ply_data.thmb.del(ply_slt_idx, file_idx)
	local file_name_fl = file.ply_data.thmb.file_name_fl(ply_slt_idx, file_idx)
	file.d(file_name_fl)
end

-- thmb - file name

function file.ply_data.thmb.file_name_fl(ply_slt_idx, file_idx)

	local ply_data_file_name_ee = file.ply_data.file_name_ee(ply_slt_idx, file_idx)
	local file_name    = ply_data_file_name_ee..".thmb."..file.ext
	local file_name_fl = file.file_name_fl(file_name)
	return file_name_fl
end
