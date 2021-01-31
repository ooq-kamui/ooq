log.scrpt("file.map.lua")

file.map = {
	file_idx_max = 3, -- 10,
}

-- save, load, del

function file.map.save(ply_slt_idx, dstrct, data)

	local file_idx = file.map.file_idx_nxt(ply_slt_idx, dstrct)

	local file_name_fl = file.map.file_name_fl(ply_slt_idx, dstrct, file_idx)
	
	file.w(file_name_fl, data)

	file.map.ltst.file_idx__(ply_slt_idx, dstrct, file_idx)
end

function file.map.load(ply_slt_idx, dstrct, file_idx)

	file_idx = file_idx or file.map.ltst.file_idx(ply_slt_idx, dstrct)
	-- log._("file.map.load file_idx", file_idx, ply_slt_idx, dstrct)
	
	local file_name_fl = file.map.file_name_fl(ply_slt_idx, dstrct, file_idx)
	local data = file.r(file_name_fl)
	return data
end

function file.map.del(ply_slt_idx, dstrct, file_idx)
	local file_name_fl = file.map.file_name_fl(ply_slt_idx, dstrct, file_idx)
	file.d(file_name_fl)
end

function file.map.file_idx_ltst(ply_slt_idx, dstrct)
	local file_idx_ltst = file.map.ltst.file_idx(ply_slt_idx, dstrct)
	return file_idx_ltst
end

function file.map.file_idx_nxt(ply_slt_idx, dstrct)

	local file_idx_nxt
	local file_idx_ltst = file.map.ltst.file_idx(ply_slt_idx, dstrct)

	if not file_idx_ltst then
		file_idx_nxt = 1
	else
		file_idx_nxt = u.inc_loop(file_idx_ltst, file.map.file_idx_max)
	end
	return file_idx_nxt
end

-- file name

function file.map.file_name_ee(ply_slt_idx, dstrct, file_idx) -- ee : excld ext

	local ply_slt_file_name_ee = file.ply_slt.file_name_ee(ply_slt_idx)
	local file_name_ee = ply_slt_file_name_ee..".map."..file.dstrct_2_str(dstrct)..".idx"..int.pad(file_idx, 2)
	return file_name_ee
end

function file.map.file_name(ply_slt_idx, dstrct, file_idx)

	local file_name_ee = file.map.file_name_ee(ply_slt_idx, dstrct, file_idx)
	local file_name    = file_name_ee.."."..file.ext
	return file_name
end

function file.map.file_name_fl(ply_slt_idx, dstrct, file_idx)

	local file_name    = file.map.file_name(ply_slt_idx, dstrct, file_idx)
	local file_name_fl = file.file_name_fl(file_name)
	return file_name_fl
end

-- ltst

file.map.ltst = {
	key = "file_idx_ltst",
}

function file.map.ltst.save(ply_slt_idx, dstrct, data)
	
	local file_name_fl = file.map.ltst.file_name_fl(ply_slt_idx, dstrct)
	file.w(file_name_fl, data)
end

function file.map.ltst.load(ply_slt_idx, dstrct)
	
	local file_name_fl = file.map.ltst.file_name_fl(ply_slt_idx, dstrct)
	local data = file.r(file_name_fl)
	return data
end

function file.map.ltst.del(ply_slt_idx, dstrct, file_idx)
	local file_name_fl = file.map.ltst.file_name_fl(ply_slt_idx, dstrct)
	file.d(file_name_fl)
end

function file.map.ltst.file_idx__(ply_slt_idx, dstrct, file_idx_ltst)

	local data = {}
	data[file.map.ltst.key] = file_idx_ltst

	file.map.ltst.save(ply_slt_idx, dstrct, data)
end

function file.map.ltst.file_idx(ply_slt_idx, dstrct)

	local data = file.map.ltst.load(ply_slt_idx, dstrct)

	if u.is_emp(data) then
		-- log._("file.map.ltst.file_idx emp")
		return
	end

	return data[file.map.ltst.key]
end

-- ltst - file name

function file.map.ltst.file_name_fl(ply_slt_idx, dstrct)

	local ply_slt_file_name_ee = file.ply_slt.file_name_ee(ply_slt_idx)
	local file_name    = ply_slt_file_name_ee..".map."..file.dstrct_2_str(dstrct)..".ltst."..file.ext
	local file_name_fl = file.file_name_fl(file_name)
	return file_name_fl
end

function file.map.is_exst(ply_slt_idx, dstrct)

	if not (ply_slt_idx and dstrct) then return end

	local file_idx_ltst = file.map.file_idx_ltst(ply_slt_idx, dstrct)

	local ret = _.f
	if file_idx_ltst then ret = _.t end
	-- log._("is_exst_map_file", ret, file_idx_ltst)
	
	return ret, file_idx_ltst
end
