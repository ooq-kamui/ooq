log.scrpt("tile_bndl.lua")

Tile_bndl = {
	
	_ = {
		base_tile = {
			x5x5 = {
				126,      136, 141, 146,
				251, 256, 261, 266, 271,
				376, 381, 386, 391, 396,
				501, 506, 511,
				626, 631,
			},
		},
	},
}

function Tile_bndl.is_tile_bndl(p_tile)
	
	local ret, base_tile = Tile_bndl.is_tile_bndl_x5x5(p_tile)
	return ret, base_tile
end

function Tile_bndl.is_tile_bndl_x5x5(p_tile)

	local ret = _.f
	
	local t_base_tile, base_tile
	for idx, t_base_tile in pairs(Tile_bndl._.base_tile.x5x5) do
		ret, base_tile = Tile_bndl.is_base_tile_bndl(p_tile, t_base_tile)
		if ret then break end
	end
	-- log._("Tile_bndl.is_tile_bndl_x5x5 end", p_tile, ret, base_tile)
	return ret, base_tile
end

function Tile_bndl.is_base_tile_bndl(p_tile, p_base_tile)
	-- log._("Tile_bndl.is_base_tile_bndl", p_tile, p_base_tile)

	if not p_tile then return end

	local ret = _.f
	local base_tile

	local t_tile
	for idx = 1, 5 do
		t_tile = p_base_tile + Tile.mstr.col_idx_max * (idx - 1)
		-- log._("is_base_tile_bndl", t_tile, p_tile, t_tile + (5 - 1))
		if t_tile <= p_tile and p_tile <= t_tile + (5 - 1) then
			ret = _.t
			base_tile = p_base_tile
			-- log._("is_base_tile_bndl", ret, base_tile)
			break
		end
	end
	-- log._("is_base_tile_bndl end", ret, base_tile)
	return ret, base_tile
end

function Tile_bndl.base_tile(p_tile)

	local is_tile_bndl, base_tile = Tile_bndl.is_tile_bndl(p_tile)

	if not is_tile_bndl then return p_tile end

	return base_tile
end

function Tile_bndl.tile_crct(base_tile, arund_code)

	local df = Tile_bndl.arund_code_2_df_x5x5(arund_code)
	
	local tile_crct = Tile_bndl.tile_crct_6_df(base_tile, df)
	return tile_crct
end

function Tile_bndl.tile_crct_6_df(base_tile, df)

	local tile_crct = base_tile + ( Tile.mstr.col_idx_max * df.y ) + df.x
	return tile_crct
end

function Tile_bndl.arund_flg_2_arund_code(arund_flg)

	if not arund_flg then log._("arund_flg_2_arund_code : prm nil") return end

	local arund_code
	local a = arund_flg

	if              not a[2]
	and    not a[4]      and not a[5]
	and             not a[7] then
		--     
		--  H  
		--     
		arund_code = 020

	elseif          not a[2]
	and    not a[4]      and     a[5]
	and             not a[7] then
		--     
		--  H# 
		--     
		arund_code = 030

	elseif          not a[2]
	and        a[4]      and     a[5]
	and             not a[7] then
		--     
		-- #H# 
		--     
		arund_code = 070

	elseif          not a[2]
	and        a[4]      and not a[5]
	and             not a[7] then
		--    
		-- #H 
		--    
		arund_code = 060

	elseif          not a[2]
	and    not a[4]      and not a[5]
	and                 a[7] then
		--     
		--  H  
		--  #  
		arund_code = 022

	elseif          not a[2]
	and    not a[4]      and     a[5]
	and                 a[7] then
		--     
		--  H# 
		--  #. 
		arund_code = 032

	elseif          not a[2]
	and        a[4]      and     a[5]
	and                 a[7] then
		--     
		-- #H# 
		-- .#. 
		arund_code = 072

	elseif          not a[2]
	and        a[4]      and not a[5]
	and                 a[7] then
		--    
		-- #H 
		-- .# 
		arund_code = 062

	elseif              a[2]
	and    not a[4]      and not a[5]
	and                 a[7] then
		--  #  
		--  H  
		--  #  
		arund_code = 222

	elseif              a[2]
	and    not a[4]      and     a[5]
	and                 a[7] then
		--  #. 
		--  H# 
		--  #. 
		arund_code = 232

	elseif              a[2]
	and        a[4]      and     a[5]
	and                 a[7] then
		-- .#. 
		-- #H# 
		-- .#. 
		arund_code = 272

	elseif              a[2]
	and        a[4]      and not a[5]
	and                 a[7] then
		-- .# 
		-- #H 
		-- .# 
		arund_code = 262

	elseif              a[2]
	and    not a[4]      and not a[5]
	and             not a[7] then
		--  #  
		--  H  
		--     
		arund_code = 220
		
	elseif              a[2]
	and    not a[4]      and     a[5]
	and             not a[7] then
		--  #. 
		--  H# 
		--     
		arund_code = 230

	elseif              a[2]
	and        a[4]      and     a[5]
	and             not a[7] then
		-- .#. 
		-- #H# 
		--     
		arund_code = 270

	elseif              a[2]
	and        a[4]      and not a[5]
	and             not a[7] then
		-- .# 
		-- #H 
		--    
		arund_code = 260
	end

	-- log._("arund_flg_2_arund_code end", arund_code)
	return arund_code
end

function Tile_bndl.arund_code_2_df_x5x5(arund_code)

	local x, y

	-- 020  030  070  060
	--                   
	--  H    H#  #H#  #H 
	--                   
	---------------------
	-- 022  032  072  062
	--                   
	--  H    H#  #H#  #H 
	--  #    #.  .#.  .# 
	---------------------
	-- 222  232  272  262
	--  #    #.  .#.  .# 
	--  H    H#  #H#  #H 
	--  #    #.  .#.  .# 
	---------------------
	-- 220  230  270  260
	--  #    #.  .#.  .# 
	--  H    H#  #H#  #H 
	--                   
	---------------------

	if     arund_code == 020 then x = 0; y = 0
	elseif arund_code == 030 then x = 1; y = 0
	elseif arund_code == 070 then x = 2; y = 0
	elseif arund_code == 060 then x = 3; y = 0
	
	elseif arund_code == 022 then x = 0; y = 1
	elseif arund_code == 032 then x = 1; y = 1
	elseif arund_code == 072 then x = 2; y = 1
	elseif arund_code == 062 then x = 3; y = 1
	
	elseif arund_code == 222 then x = 0; y = 2
	elseif arund_code == 232 then x = 1; y = 2
	elseif arund_code == 272 then x = 2; y = 2
	elseif arund_code == 262 then x = 3; y = 2
	
	elseif arund_code == 220 then x = 0; y = 3
	elseif arund_code == 230 then x = 1; y = 3
	elseif arund_code == 270 then x = 2; y = 3
	elseif arund_code == 260 then x = 3; y = 3
	end
	
	local df = {x = x, y =y}
	return df
end

