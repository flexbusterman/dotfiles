local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local snippets = {
	s(
		"section with enumerate",
		fmt(
			[[
\section*{<>}
\begin{enumerate}[label=(\alph*)]
	\item
		\begin{align*}
			<> \\
		\end{align*}
\end{enumerate}
  ]],
			{
				i(1, ""),
				i(2, "1+1=2"),
			},
			{
				delimiters = "<>",
			}
		)
	),
	s(
		"section",
		fmt(
			[[
\section*{<>}
\begin{align*}
	<> \\
\end{align*}
  ]],
			{
				i(1, ""),
				i(2, "1+1=2"),
			},
			{
				delimiters = "<>",
			}
		)
	),

	s(
		"item",
		fmt(
			[[
	\item
		\begin{align*}
			<> \\
		\end{align*}
  ]],
			{
				i(1, ""),
			},
			{
				delimiters = "<>",
			}
		)
	),

	s({ trig = "pq", name = "PQ-formeln" }, { t("x &= -\\frac{p}{2} \\pm \\sqrt{\\left(\\frac{p}{2}\\right)^2 - q}") }),

	s(
		"maths",
		fmt(
			[[
\documentclass{article}
\usepackage[fleqn]{amsmath}
\usepackage{enumitem, hyperref}
\title{Matematik 2c}
\date{\today}
\author{Christian Augustin}
\begin{document}
\maketitle

\href{https://fredrikfilmer.wixsite.com/filmer/matematik-5000-2b}{Lösningar}

\section{}
\begin{align*}
	<> \\
\end{align*}

\end{document}
  ]],
			{
				i(1, ""),
			},
			{
				delimiters = "<>",
			}
		)
	),

	s(
		"cases",
		fmt(
			[[
	\begin{cases}
		x_1 & <> \\
		x_2 & <> \\
	\end{cases}
  ]],
			{
				i(1, ""),
				i(2, ""),
			},
			{
				delimiters = "<>",
			}
		)
	),

	s(
		"nth root python",
		fmt(
			[[
print(pow(<>, 1/<>))
]],
			{
				i(1, "1"),
				i(2, "1"),
			},
			{
				delimiters = "<>",
			}
		)
	),

	s(
		"log10 python",
		fmt(
			[[
import math; print(math.log10(<>))
]],
			{
				i(1, "1"),
			},
			{
				delimiters = "<>",
			}
		)
	),
}
return snippets
