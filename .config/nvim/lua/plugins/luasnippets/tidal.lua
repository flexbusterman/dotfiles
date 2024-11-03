local ls = require'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local snippets = {
	-- Oscilators
	s({ trig = "silence", name = "Pattern a" }, { t("silence") }),
	s({ trig = "sine", name = "Fractional => Pattern a" }, { t("sine") }),
	s({ trig = "cosine", name = "Fractional => Pattern a" }, { t("cosine") }),
	s({ trig = "square", name = "Fractional => Pattern a" }, { t("square") }),
	s({ trig = "tri", name = "Fractional => Pattern a" }, { t("tri") }),
	s({ trig = "saw", name = "Fractional => Pattern a" }, { t("saw") }),
	s({ trig = "isaw", name = "Fractional => Pattern a" }, { t("isaw") }),

	-- choose, wchoose
	s({ trig = "choose", name = "[a] -> Pattern a" }, { t("choose ["), i(1, "any"), t("]") }),
	s({ trig = "chooseBy", name = "Pattern Double -> [a] -> Pattern a" }, { t("chooseBy \""), i(1, "doubles"), t("\" ["), i(2, "any"), t("]") }),
	s({ trig = "wchoose", name = "[(a, Double)] -> Pattern a" }, { t("wchoose [("), i(1, "any"), t(", "), i(2, "double"), t(")]") }),
	s({ trig = "wChooseBy", name = "Pattern Double -> [(a,Double)] -> Pattern a" }, { t("wChooseBy \""), i(1, "doubles"), t("\" [("), i(2, "any"), t(", "), i(3, "double"), t(")]") }),

	-- Random Functions
	s({ trig = "rand", name = "Factorial => Pattern a" }, { t("rand") }),
	s({ trig = "irand", name = "Num a => Int -> Pattern a" }, { t("irand") }),
	s({ trig = "perlin", name = "Pattern Double" }, { t("perlin") }),
	s({ trig = "perlinWith", name = "Pattern Double -> Pattern Double" }, { t("perlinWith "), i(1, "double") }),
	s({ trig = "perlin2", name = "Pattern Double -> Pattern Double" }, { t("perlinWith "), i(1, "double") }),
	s({ trig = "perlin2With", name = "Pattern Double -> Pattern Double -> Pattern Double" }, { t("perlinWith "), i(1, "double"), t(" "), i(2, "double") }),

	-- Control Functions
	s({ trig = "accelerate", name = "Pattern Double -> ControlPattern" }, { t("accelerate \""), i(1, "double"), t("\"") }),
	s({ trig = "attack", name = "Pattern Double -> ControlPattern" }, { t("attack \""), i(1, "double"), t("\"") }),
	s({ trig = "bandf", name = "Pattern Double -> ControlPattern" }, { t("bandf \""), i(1, "double"), t("\"") }),
	s({ trig = "bandq", name = "Pattern Double -> ControlPattern" }, { t("bandq \""), i(1, "double"), t("\"") }),
	s({ trig = "begin", name = "Pattern Double -> ControlPattern" }, { t("begin \""), i(1, "double"), t("\"") }),
	s({ trig = "bpf", name = "Pattern Double -> ControlPattern" }, { t("bpf \""), i(1, "double"), t("\"") }),
	s({ trig = "bpq", name = "Pattern Double -> ControlPattern" }, { t("bpq \""), i(1, "double"), t("\"") }),
	s({ trig = "coarse", name = "Pattern Int -> ControlPattern" }, { t("coarse \""), i(1, "int"), t("\"") }),
	s({ trig = "crush", name = "Pattern Double -> ControlPattern" }, { t("crush \""), i(1, "double"), t("\"") }),
	s({ trig = "cut", name = "Pattern Int -> ControlPattern" }, { t("cut \""), i(1, "int"), t("\"") }),
	s({ trig = "cutoff", name = "Pattern Double -> ControlPattern" }, { t("cutoff \""), i(1, "double"), t("\"") }),
	s({ trig = "delay", name = "Pattern Double -> ControlPattern" }, { t("delay \""), i(1, "double"), t("\"") }),
	s({ trig = "delayfb", name = "Pattern Double -> ControlPattern" }, { t("delayfb \""), i(1, "double"), t("\"") }),
	s({ trig = "delaytime", name = "Pattern Double -> ControlPattern" }, { t("delaytime \""), i(1, "double"), t("\"") }),
	s({ trig = "end", name = "Pattern Double -> ControlPattern" }, { t("end \""), i(1, "double"), t("\"") }),
	s({ trig = "gain", name = "Pattern Double -> ControlPattern" }, { t("gain \""), i(1, "double"), t("\"") }),
	s({ trig = "hcutoff", name = "Pattern Double -> ControlPattern" }, { t("hcutoff \""), i(1, "double"), t("\"") }),
	s({ trig = "hpf", name = "Pattern Double -> ControlPattern" }, { t("hpf \""), i(1, "double"), t("\"") }),
	s({ trig = "hresonance", name = "Pattern Double -> ControlPattern" }, { t("hresonance \""), i(1, "double"), t("\"") }),
	s({ trig = "hpq", name = "Pattern Double -> ControlPattern" }, { t("hpq \""), i(1, "double"), t("\"") }),
	s({ trig = "leslie", name = "Pattern Double -> ControlPattern" }, { t("leslie \""), i(1, "double"), t("\"") }),
	s({ trig = "loop", name = "Pattern Double -> ControlPattern" }, { t("loop \""), i(1, "double"), t("\"") }),
	s({ trig = "lpf", name = "Pattern Double -> ControlPattern" }, { t("lpf \""), i(1, "double"), t("\"") }),
	s({ trig = "n", name = "Pattern Int -> ControlPattern" }, { t("n \""), i(1, "int"), t("\"") }),
	s({ trig = "nudge", name = "Pattern Double -> ControlPattern" }, { t("nudge \""), i(1, "double"), t("\"") }),

	-- Other snippets
	s({ trig = "sound", name = "Pattern String -> ControlPattern" }, { t("s \""), i(1, "samples"), t("\"") }),
	s("bootstrap", {
		t({
			"do",
			"  let masterGain = 1",
			"  let s1G = 1",
			"  let s2G = 1",
			"  let s1 = silence",
			"         # gain s1G",
			"         # orbit 0",
			"  let s2 = silence",
			"         # gain s2G",
			"         # orbit 1",
			"  d1 $ stack [s1, s2] # masterGain",
		})
	})
}

return snippets
