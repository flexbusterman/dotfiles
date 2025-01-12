local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local snippets = {
	s({ trig = "function", name = "Function symbol" }, { t("𝑓") }),
	s({ trig = "cl", name = "console.log()" }, { t("console.log("), i(1), t(")") }),
	s({ trig = "bc", name = "CSS Background Color" }, { t("background-color: rgba(0, 0, 1, 0.3);") }),
	s({ trig = "im", name = "CSS important" }, { t("!important") }),
	s({ trig = "hc", name = "HTML comment" }, { t("<!-- "), i(1), t(" -->") }),
	s({ trig = "php", name = "PHP Mode" }, { t("<?php "), i(1), t("; ?>") }),
}
return snippets
