local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local snippets = {
	s({ trig = "code block", name = "Code Block" }, {
		t("#+BEGIN_SRC "),
		i(1, "language"),
		t({ "", "" }),
		i(2, ""),
		t({ "", "#+END_SRC" }),
	}),
}
return snippets
