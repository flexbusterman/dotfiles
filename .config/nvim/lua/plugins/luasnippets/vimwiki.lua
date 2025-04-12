local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local snippets = {
	s({ trig = "code", name = "Code Block" }, {
		t("``` "),
		i(1, "language"),
		t({ "", "" }),
		i(2, ""),
		t({ "", "```" }),
	}),
	s({ trig = "checkbox", name = "Checkbox" }, {
		t("- [ ] "),
	}),
}
return snippets
