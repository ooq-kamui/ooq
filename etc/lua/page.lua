log.scrpt("page.lua")

page = {}

function page.itm_idx_2_page_idx(itm_idx, dsp_idx_max) -- alias
	return page._(itm_idx, dsp_idx_max)
end

function page._(itm_idx, dsp_idx_max)
	local page_idx, dsp_idx = int.dlm(itm_idx, dsp_idx_max)
	return page_idx, dsp_idx
end

function page.page_idx_max(itm_idx_max, dsp_idx_max)
	local page_idx_max, dsp_idx = int.dlm(itm_idx_max, dsp_idx_max)
	return page_idx_max, dsp_idx
end

function page.itm_idx_rng(page_idx, dsp_idx_max)
	
	local itm_idx_fr = (page_idx - 1) * dsp_idx_max + 1
	local itm_idx_to =  page_idx * dsp_idx_max
	return itm_idx_fr, itm_idx_to
end

function page.dsp1_itm_idx(page_idx, dsp_idx_max)
	local dsp1_itm_idx = (page_idx - 1) * dsp_idx_max + 1
	return dsp1_itm_idx
end
