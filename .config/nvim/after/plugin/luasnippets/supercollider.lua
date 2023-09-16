local ls = require'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local snippets = {
s( { trig = "test", name = "Test SuperCollider audio" }, { t("{SinOsc.ar(freq: 440.0,  phase: 0.0,  mul: 0.2,  add: 0.0)!2}.play;"), }),
s("nd", {
    t({"Ndef(\\",}), i(1, "name"),
    t({", {",}),
    i(2, "source"),
    t({"}).play;",}),
}),
s("supermandolin", {
		t({"Ndef(\\",}),
		i(1, "supermandolin"),
		t({", Pbind(\\instrument, \\supermandolin, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
		i(2, "440"),
		t({", \\detune, 0.2, \\speed, 1));"})
}),
s("supergong", {
    t({"Ndef(\\"}),
    i(1, "supergong"),
    t({", Pbind(\\instrument, \\supergong, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0, \\decay, 1, \\speed, 1));"})
}),
s("superpiano", {
    t({"Ndef(\\"}),
    i(1, "superpiano"),
    t({", Pbind(\\instrument, \\superpiano, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\pan, 0, \\velocity, 1, \\detune, 0.1, \\muffle, 1, \\stereo, 0.2, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 0, \\speed, 1));"})
}),
s("superhex", {
    t({"Ndef(\\"}),
    i(1, "superhex"),
    t({", Pbind(\\instrument, \\superhex, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\sustain, 1, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 1, \\speed, 1));"})
}),
s("superkick", {
    t({"Ndef(\\"}),
    i(1, "superkick"),
    t({", Pbind(\\instrument, \\superkick, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\pan, 0, \\accelerate, 1, \\n, 1, \\pitch1, 1, \\decay, 1, \\speed, 1));"})
}),
s("super808", {
    t({"Ndef(\\"}),
    i(1, "super808"),
    t({", Pbind(\\instrument, \\super808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\sustain, 1, \\pan, 0, \\voice, 0, \\n, 1, \\speed, 1, \\accelerate, 1));"})
}),
s("superhat", {
    t({"Ndef(\\"}),
    i(1, "superhat"),
    t({", Pbind(\\instrument, \\superhat, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\pan, 0, \\accelerate, 1, \\n, 1, \\speed, 1));"})
}),
s("supersnare", {
    t({"Ndef(\\"}),
    i(1, "supersnare"),
    t({", Pbind(\\instrument, \\supersnare, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\n, "}),
    i(2, "5"),
    t({", \\decay, 1, \\speed, 1));"})
}),
s("superclap", {
    t({"Ndef(\\"}),
    i(1, "superclap"),
    t({", Pbind(\\instrument, \\superclap, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\n, "}),
    i(2, "3"),
    t({", \\delay, 1, \\pitch1, 1));"})
}),
s("supersiren", {
    t({"Ndef(\\"}),
    i(1, "supersiren"),
    t({", Pbind(\\instrument, \\supersiren, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\speed, 1));"})
}),
s("supersquare", {
    t({"Ndef(\\"}),
    i(1, "supersquare"),
    t({", Pbind(\\instrument, \\supersquare, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\decay, 0, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0.5, \\semitone, 12, \\resonance, 0.2, \\lfo, 1, \\pitch1, 1, \\speed, 1));"})
}),
s("supersaw", {
    t({"Ndef(\\"}),
    i(1, "supersaw"),
    t({", Pbind(\\instrument, \\supersaw, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\decay, 0, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0.5, \\semitone, 12, \\resonance, 0.2, \\lfo, 1, \\pitch1, 1, \\speed, 1));"})
}),
s("superpwm", {
    t({"Ndef(\\"}),
    i(1, "superpwm"),
    t({", Pbind(\\instrument, \\superpwm, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\decay, 0, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0.5, \\semitone, 12, \\resonance, 0.2, \\lfo, 1, \\pitch1, 1, \\speed, 1));"})
}),
s("supercomparator", {
    t({"Ndef(\\"}),
    i(1, "supercomparator"),
    t({", Pbind(\\instrument, \\supercomparator, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\decay, 0, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0.5, \\resonance, 0.5, \\lfo, 1, \\pitch1, 1, \\speed, 1));"})
}),
s("superchip", {
    t({"Ndef(\\"}),
    i(1, "superchip"),
    t({", Pbind(\\instrument, \\superchip, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\rate, 1, \\slide, 0, \\pitch2, 2, \\pitch3, 3, \\accelerate, 1, \\voice, 0, \\speed, 1));"})
}),
s("supernoise", {
    t({"Ndef(\\"}),
    i(1, "supernoise"),
    t({", Pbind(\\instrument, \\supernoise, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 1, \\slide, 0, \\pitch1, 1, \\rate, 1, \\resonance, 0, \\voice, 0));"})
}),
s("superfork", {
    t({"Ndef(\\"}),
    i(1, "superfork"),
    t({", Pbind(\\instrument, \\superfork, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 0, \\speed, 1));"})
}),
s("superhammond", {
    t({"Ndef(\\"}),
    i(1, "superhammond"),
    t({", Pbind(\\instrument, \\superhammond, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\vibrato, 0.5, \\vrate, 7, \\voice, 0, \\perc, 0, \\percf, 2, \\accelerate, 0, \\speed, 1, \\decay, 0));"})
}),
s("supervibe", {
    t({"Ndef(\\"}),
    i(1, "supervibe"),
    t({", Pbind(\\instrument, \\supervibe, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\decay, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 0, \\velocity, 1, \\modamp, 1, \\modfreq, 7.0, \\detune, 0, \\speed, 1));"})
}),
s("superhoover", {
    t({"Ndef(\\"}),
    i(1, "superhoover"),
    t({", Pbind(\\instrument, \\superhoover, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\decay, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 0, \\slide, 0, \\speed, 1));"})
}),
s("superzow", {
    t({"Ndef(\\"}),
    i(1, "superzow"),
    t({", Pbind(\\instrument, \\superzow, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\decay, 0, \\slide, 1, \\detune, 1, \\speed, 1));"})
}),
s("superstatic", {
    t({"Ndef(\\"}),
    i(1, "superstatic"),
    t({", Pbind(\\instrument, \\superstatic, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 0, \\speed, 1));"})
}),
s("supergrind", {
    t({"Ndef(\\"}),
    i(1, "supergrind"),
    t({", Pbind(\\instrument, \\supergrind, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\sustain, 1, \\accelerate, 1, \\detune, 0, \\voice, 0, \\rate, 1, \\speed, 1));"})
}),
s("superprimes", {
    t({"Ndef(\\"}),
    i(1, "superprimes"),
    t({", Pbind(\\instrument, \\superprimes, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\sustain, 1, \\accelerate, 1, \\rate, 1, \\detune, 0, \\voice, 0, \\speed, 1));"})
}),
s("superwavemechanics", {
    t({"Ndef(\\"}),
    i(1, "superwavemechanics"),
    t({", Pbind(\\instrument, \\superwavemechanics, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\sustain, 1, \\accelerate, 1, \\detune, 0, \\voice, 0, \\resonance, 0, \\speed, 1));"})
}),
s("supertron", {
    t({"Ndef(\\"}),
    i(1, "supertron"),
    t({", Pbind(\\instrument, \\supertron, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\sustain, 1, \\voice, 0, \\detune, 0, \\accelerate, 1, \\speed, 1));"})
}),
s("superreese", {
    t({"Ndef(\\"}),
    i(1, "superreese"),
    t({", Pbind(\\instrument, \\superreese, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\detune, 0, \\voice, 0, \\speed, 1));"})
}),
s("superfm", {
    t({"Ndef(\\"}),
    i(1, "superfm"),
    t({", Pbind(\\instrument, \\superfm, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\lfofreq, 1, \\lfodepth, 0, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0);"})
}),
s("soskick", {
    t({"Ndef(\\"}),
    i(1, "soskick"),
    t({", Pbind(\\instrument, \\soskick, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "65"),
    t({", \\pitch1, 0, \\speed, 0.3, \\voice, 1, \\sustain, 1, \\pitch2, 0);"})
}),
s("soshats", {
    t({"Ndef(\\"}),
    i(1, "soshats"),
    t({", Pbind(\\instrument, \\soshats, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "220"),
    t({", \\pitch1, 238.5, \\resonance, 1, \\sustain, 0.5);"})
}),
s("sostoms", {
    t({"Ndef(\\"}),
    i(1, "sostoms"),
    t({", Pbind(\\instrument, \\sostoms, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\sustain, 0.5, \\freq, "}),
    i(2, "261.626"),
    t({", \\voice, 0.5);"})
}),
s("sossnare", {
    t({"Ndef(\\"}),
    i(1, "sossnare"),
    t({", Pbind(\\instrument, \\sossnare, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "405"),
    t({", \\voice, 0.385, \\semitone, 0.452, \\pitch1, 2000, \\resonance, 0.1, \\sustain, 0.5);"})
})
}

return snippets
