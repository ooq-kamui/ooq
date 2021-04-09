log.scrpt("obj.lua")

Obj = {}
Obj.fac = "obj-fac#"

-- tst

Obj.tst = {}
-- Obj.fall = {}

function Obj.tst.tst()
	local Cls = {
		Chara,
		Block,
		Anml,
		Seed,
		Kagu,
		Plant,
		Bush, Bush,
		Mshrm, Mshrm, Mshrm,
		Fluff, Fluff,
		Flower, Flower,
		Dish, Dish, Dish, Dish, Dish, Dish,
		Shtngstr, Shtngstr, Shtngstr, Shtngstr,
		Balloon, Balloon, Balloon, Balloon,
		Trmpln, Trmpln,
		Parasail, Parasail,
		Doorwrp, Doorwrp,
	}
	Obj.tst._(Cls)
end

function Obj.tst.chara()
	local Cls = {
		Chara,Chara,Chara,Chara,Chara,Chara,
		Chara,Chara,Chara,Chara,Chara,Chara,
		Seed,Seed,Seed,Seed,
	}
	Obj.tst._(Cls)
end

function Obj.tst.fire()
	local Cls = {
		Chara, -- Chara,Chara,Chara,Chara,
		Fire,Fire,Fire,Fire, -- Fire,Fire,
		Seed, -- Seed,Seed,Seed,Seed,
		Wood,Wood,Wood,Wood,Wood,
		Leaf,Leaf,Leaf,
		Dryleaf,Dryleaf,Dryleaf,Dryleaf,Dryleaf,
	}
	Obj.tst._(Cls)
end

function Obj.tst.tree()
	local Cls = {
		Chara, -- Chara,Chara,Chara,Chara,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
	}
	Obj.tst._(Cls)
end

function Obj.tst.game_start()
	
	local Cls = {
		Chara, -- Chara,Chara,Chara,Chara,
		Anml,Anml,Anml,Anml,Anml,Anml,Anml,Anml,
		---[[
		Flower,Flower,Flower,Flower,
		Veget,Veget,Veget,Veget,Veget,Veget,
		Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,
		Plant,Plant,Plant,
		Tree,Tree,Tree,Tree,Tree,Tree,
		Fruit,Fruit,Fruit,Fruit,Fruit,
		Egg,Egg,Egg,Egg,Egg,Egg,Egg,Egg,Egg,
		Fish,Fish,Fish,Fish,
		Dish,Dish,Dish,
		Dairy,Dairy,Dairy,
		Meat,Meat,Meat,
		Fruit,Fruit,Fruit,
		Wood,Wood,Wood,Wood,
		Leaf,Leaf,Leaf,
		Dryleaf,Dryleaf,Dryleaf,Dryleaf,
		Kagu,Kagu,Kagu,Kagu,Kagu,Kagu,
		Grave,
		Phantom,
		Fire,
		Doorwrp,Doorwrp,
		-- Block,Block,Block,Block,Block,
		--]]
	}
	Obj.tst._(Cls)
end

function Obj.tst._(p_Cls)
	
	local t_pos = n.vec(-800, 200)
	local y, idx
	local cnt = 1
	local t_pos_ini = n.vec(t_pos.x, t_pos.y)
	local rng = Game.map_rng_pos()
	while #p_Cls > 0 do
		idx = rnd.int(1, #p_Cls)
		p_Cls[idx].cre(t_pos, nil)
		ar.del_by_idx(p_Cls, idx)
		t_pos.x = t_pos.x + Map.sq
		if t_pos.x > rng.max.x - Map.verge then
			t_pos.x = t_pos_ini.x + cnt * 10
			cnt = cnt + 1
		end
		y = rnd.int(0, 1)
		t_pos.y = t_pos.y + Map.sq * y
	end
end

