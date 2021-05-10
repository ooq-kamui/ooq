log.scrpt("mstr anml.lua")

Mstr.anml = {}

function Mstr.anml.is_favo(s_name, p_cls, p_name)

	if not Mstr.anml[s_name] then return _.f end

	local favo = Mstr.anml[s_name].favo

	if not favo[p_cls] then return _.f end

	local ret =  ar.in_(p_name, favo[p_cls])
	return ret

end

Mstr.anml["cat"] = {

	gold = 1000,

	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
		fish = {
			"fish001",
			"fish002",
			"fish003",
			"fish004",
		},
	},
}

Mstr.anml["pig"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["dog"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["fox"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["sheep"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["duck"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["owl"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["rat"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["goat"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["piyoco"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["wolf"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["coco"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["bird"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["rabbit"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["horse"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["cow"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

Mstr.anml["badger"] = {
	gold = 1000,
	favo = {
		dish = {
			"dish001",
			"dish002",
			"dish003",
			"dish004",
		},
	},
}

