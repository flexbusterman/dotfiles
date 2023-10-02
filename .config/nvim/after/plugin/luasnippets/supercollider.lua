local ls = require'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local r = require("luasnip.extras").rep

local snippets = {
s( { trig = "test", name = "Test SuperCollider audio" }, { t("Ndef(\\test, {SinOsc.ar(440)!2*0.2}).play;", "Ndef(\\test).clear;") }),
s("ndf", {
    t({"Ndef(\\",}),
		i(1, "name"),
    t({", {",}),
    i(2, "source"),
    t({"});",}),
}),
s({ trig = "ndp", name = "Ndef play" }, {
    t({"Ndef(\\",}),
		i(1, "name"),
    t({").play;",}),
}),
s({ trig = "ndc", name = "Ndef clear" }, {
    t({"Ndef(\\",}),
		i(1, "name"),
    t({").clear(",}),
		i(2, "0"),
    t({");",}),
}),
s({ trig = "nd0pd", name = "Ndef [0] Pbind Degrees" }, {
    t({"Ndef(\\",}),
    i(1, "name"),
    t({")[0] = Pbind(\\instrument, \\",}),
    i(2, "sine"),
    t({", \\dur, 1, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\degree, "}),
    i(3, "Pwhite(0,7)"),
    t({", \\scale, Pfunc{~c[\\scale]}, \\root, Pfunc{~c[\\root]}, \\octave, 1, \\gate, 0, \\sus, 0, \\rel, Pkey(\\dur), \\relCrv, (-8), \\att, 0.01);", "Ndef(\\",}),
    r(1),
    t({").play;",}),
}),
s({ trig = "nd0pf", name = "Ndef [0] Pbind Freq" }, {
    t({"Ndef(\\",}),
    i(1, "name"),
    t({")[0] = Pbind(\\instrument, \\",}),
    i(2, "sine"),
    t({", \\dur, 1, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(3, "440"),
    t({", \\gate, 0, \\sus, 0, \\rel, Pkey(\\dur), \\relCrv, (-8), \\att, 0.01);", "Ndef(\\",}),
    r(1),
    t({").play;",}),
}),
s("supermandolin", {
		t({"Ndef(\\",}),
		i(1, "supermandolin"),
		t({")[0] = Pbind(\\instrument, \\supermandolin, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
		i(2, "440"),
		t({", \\detune, 0.2, \\speed, 1);"})
}),
s("supergong", {
    t({"Ndef(\\"}),
    i(1, "supergong"),
    t({")[0] = Pbind(\\instrument, \\supergong, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0, \\decay, 1, \\speed, 1);"})
}),
s("superpiano", {
    t({"Ndef(\\"}),
    i(1, "superpiano"),
    t({")[0] = Pbind(\\instrument, \\superpiano, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\pan, 0, \\velocity, 1, \\detune, 0.1, \\muffle, 1, \\stereo, 0.2, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 0, \\speed, 1);"})
}),
s("superhex", {
    t({"Ndef(\\"}),
    i(1, "superhex"),
    t({")[0] = Pbind(\\instrument, \\superhex, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\sustain, 1, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 1, \\speed, 1);"})
}),
s("superkick", {
    t({"Ndef(\\"}),
    i(1, "superkick"),
    t({")[0] = Pbind(\\instrument, \\superkick, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\pan, 0, \\accelerate, 1, \\n, 1, \\pitch1, 1, \\decay, 1, \\speed, 1);"})
}),
s("super808", {
    t({"Ndef(\\"}),
    i(1, "super808"),
    t({")[0] = Pbind(\\instrument, \\super808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\sustain, 1, \\pan, 0, \\voice, 0, \\n, 1, \\speed, 1, \\accelerate, 1);"})
}),
s("superhat", {
    t({"Ndef(\\"}),
    i(1, "superhat"),
    t({")[0] = Pbind(\\instrument, \\superhat, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\pan, 0, \\accelerate, 1, \\n, 1, \\speed, 1);"})
}),
s("supersnare", {
    t({"Ndef(\\"}),
    i(1, "supersnare"),
    t({")[0] = Pbind(\\instrument, \\supersnare, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\n, "}),
    i(2, "5"),
    t({", \\decay, 1, \\speed, 1);"})
}),
s("superclap", {
    t({"Ndef(\\"}),
    i(1, "superclap"),
    t({")[0] = Pbind(\\instrument, \\superclap, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\n, "}),
    i(2, "3"),
    t({", \\delay, 1, \\pitch1, 1);"})
}),
s("supersiren", {
    t({"Ndef(\\"}),
    i(1, "supersiren"),
    t({")[0] = Pbind(\\instrument, \\supersiren, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\speed, 1);"})
}),
s("supersquare", {
    t({"Ndef(\\"}),
    i(1, "supersquare"),
    t({")[0] = Pbind(\\instrument, \\supersquare, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\decay, 0, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0.5, \\semitone, 12, \\resonance, 0.2, \\lfo, 1, \\pitch1, 1, \\speed, 1);"})
}),
s("supersaw", {
    t({"Ndef(\\"}),
    i(1, "supersaw"),
    t({")[0] = Pbind(\\instrument, \\supersaw, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\decay, 0, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0.5, \\semitone, 12, \\resonance, 0.2, \\lfo, 1, \\pitch1, 1, \\speed, 1);"})
}),
s("superpwm", {
    t({"Ndef(\\"}),
    i(1, "superpwm"),
    t({")[0] = Pbind(\\instrument, \\superpwm, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\decay, 0, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0.5, \\semitone, 12, \\resonance, 0.2, \\lfo, 1, \\pitch1, 1, \\speed, 1);"})
}),
s("supercomparator", {
    t({"Ndef(\\"}),
    i(1, "supercomparator"),
    t({")[0] = Pbind(\\instrument, \\supercomparator, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rate, 1, \\decay, 0, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0.5, \\resonance, 0.5, \\lfo, 1, \\pitch1, 1, \\speed, 1);"})
}),
s("superchip", {
    t({"Ndef(\\"}),
    i(1, "superchip"),
    t({")[0] = Pbind(\\instrument, \\superchip, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\rate, 1, \\slide, 0, \\pitch2, 2, \\pitch3, 3, \\accelerate, 1, \\voice, 0, \\speed, 1);"})
}),
s("supernoise", {
    t({"Ndef(\\"}),
    i(1, "supernoise"),
    t({")[0] = Pbind(\\instrument, \\supernoise, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 1, \\slide, 0, \\pitch1, 1, \\rate, 1, \\resonance, 0, \\voice, 0);"})
}),
s("superfork", {
    t({"Ndef(\\"}),
    i(1, "superfork"),
    t({")[0] = Pbind(\\instrument, \\superfork, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 0, \\speed, 1);"})
}),
s("superhammond", {
    t({"Ndef(\\"}),
    i(1, "superhammond"),
    t({")[0] = Pbind(\\instrument, \\superhammond, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\vibrato, 0.5, \\vrate, 7, \\voice, 0, \\perc, 0, \\percf, 2, \\accelerate, 0, \\speed, 1, \\decay, 0);"})
}),
s("supervibe", {
    t({"Ndef(\\"}),
    i(1, "supervibe"),
    t({")[0] = Pbind(\\instrument, \\supervibe, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\decay, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 0, \\velocity, 1, \\modamp, 0.2, \\modfreq, 7.0, \\detune, 0, \\speed, 1);"})
}),
s("superhoover", {
    t({"Ndef(\\"}),
    i(1, "superhoover"),
    t({")[0] = Pbind(\\instrument, \\superhoover, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\decay, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 0, \\slide, 0, \\speed, 1);"})
}),
s("superzow", {
    t({"Ndef(\\"}),
    i(1, "superzow"),
    t({")[0] = Pbind(\\instrument, \\superzow, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\decay, 0, \\slide, 1, \\detune, 1, \\speed, 1);"})
}),
s("superstatic", {
    t({"Ndef(\\"}),
    i(1, "superstatic"),
    t({")[0] = Pbind(\\instrument, \\superstatic, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\sustain, 1, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\accelerate, 0, \\speed, 1);"})
}),
s("supergrind", {
    t({"Ndef(\\"}),
    i(1, "supergrind"),
    t({")[0] = Pbind(\\instrument, \\supergrind, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\sustain, 1, \\accelerate, 1, \\detune, 0, \\voice, 0, \\rate, 1, \\speed, 1);"})
}),
s("superprimes", {
    t({"Ndef(\\"}),
    i(1, "superprimes"),
    t({")[0] = Pbind(\\instrument, \\superprimes, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\sustain, 1, \\accelerate, 1, \\rate, 1, \\detune, 0, \\voice, 0, \\speed, 1);"})
}),
s("superwavemechanics", {
    t({"Ndef(\\"}),
    i(1, "superwavemechanics"),
    t({")[0] = Pbind(\\instrument, \\superwavemechanics, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\sustain, 1, \\accelerate, 1, \\detune, 0, \\voice, 0, \\resonance, 0, \\speed, 1);"})
}),
s("supertron", {
    t({"Ndef(\\"}),
    i(1, "supertron"),
    t({")[0] = Pbind(\\instrument, \\supertron, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\sustain, 1, \\voice, 0, \\detune, 0, \\accelerate, 1, \\speed, 1);"})
}),
s("superreese", {
    t({"Ndef(\\"}),
    i(1, "superreese"),
    t({")[0] = Pbind(\\instrument, \\superreese, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\accelerate, 1, \\freq, "}),
    i(2, "440"),
    t({", \\detune, 0, \\voice, 0, \\speed, 1);"})
}),
s("superfm", {
    t({"Ndef(\\"}),
    i(1, "superfm"),
    t({")[0] = Pbind(\\instrument, \\superfm, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\sustain, Pkey(\\dur)*1.5, \\pan, 0, \\lfofreq, 1, \\lfodepth, 0, \\freq, "}),
    i(2, "440"),
    t({", \\voice, 0);"})
}),
s("soskick", {
    t({"Ndef(\\"}),
    i(1, "soskick"),
    t({")[0] = Pbind(\\instrument, \\soskick, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "65"),
    t({", \\pitch1, 0, \\speed, 0.3, \\voice, 1, \\sustain, 1, \\pitch2, 0);"})
}),
s("soshats", {
    t({"Ndef(\\"}),
    i(1, "soshats"),
    t({")[0] = Pbind(\\instrument, \\soshats, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "220"),
    t({", \\pitch1, 238.5, \\resonance, 1, \\sustain, 0.5);"})
}),
s("sostoms", {
    t({"Ndef(\\"}),
    i(1, "sostoms"),
    t({")[0] = Pbind(\\instrument, \\sostoms, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\sustain, 0.5, \\freq, "}),
    i(2, "261.626"),
    t({", \\voice, 0.5);"})
}),
s("sossnare", {
    t({"Ndef(\\"}),
    i(1, "sossnare"),
    t({")[0] = Pbind(\\instrument, \\sossnare, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "405"),
    t({", \\voice, 0.385, \\semitone, 0.452, \\pitch1, 2000, \\resonance, 0.1, \\sustain, 0.5);"})
}),
s("synth", {
    t({"Ndef(\\"}),
    i(1, "synth"),
    t({")[0] = Pbind(\\instrument, \\synth, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\freq, "}),
    i(2, "440"),
    t({", \\modPartial, 1, \\index, 3, \\modAmp, 0.0, \\vibFreq, 0, \\vibPhase, 2, \\vibDepth, 0, \\carPartial, 1, \\width, 0.5, \\panRate, 0, \\panPhase, 2, \\panamp, 0.2.0, \\panWidth, 2, \\cutoff, 600, \\rq, 1.0);"})
}),
s("sine", {
    t({"Ndef(\\"}),
    i(1, "sine"),
    t({")[0] = Pbind(\\instrument, \\sine, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\freq, "}),
    i(2, "100"),
    t({", \\pan, 0);"})
}),
s("sinFb", {
    t({"Ndef(\\"}),
    i(1, "sinFb"),
    t({")[0] = Pbind(\\instrument, \\sinFb, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\freq, "}),
    i(2, "440"),
    t({", \\feedback, 0.5, \\cutoff, 5000, \\rq, 1, \\pan, 0);"})
}),
s("sinFbGate", {
    t({"Ndef(\\"}),
    i(1, "sinFbGate"),
    t({")[0] = Pbind(\\instrument, \\sinFbGate, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\freq, "}),
    i(2, "440"),
    t({", \\feedback, 0.5, \\cutoff, 5000, \\rq, 1, \\gate, 1, \\att, 0.01, \\dec, 0.03, \\sus, 0.5, \\rel, 1, \\pan, 0);"})
}),
s("sinFbBp", {
    t({"Ndef(\\"}),
    i(1, "sinFbBp"),
    t({")[0] = Pbind(\\instrument, \\sinFbBp, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "440"),
    t({", \\feedback, 0.5, \\cutoff, 5000, \\rq, 1, \\passwidth, 100, \\att, 0, \\sus, 0.03, \\rel, 0, \\attCrv, 2, \\relCrv, -2);"})
}),
s("saw", {
    t({"Ndef(\\"}),
    i(1, "saw"),
    t({")[0] = Pbind(\\instrument, \\saw, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "100"),
    t({", \\width, 0.5, \\att, 0, \\sus, 0.03, \\rel, 0, \\attCrv, 2, \\relCrv, -2);"})
}),
s("sawMoog", {
    t({"Ndef(\\"}),
    i(1, "sawMoog"),
    t({")[0] = Pbind(\\instrument, \\sawMoog, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\freq, "}),
    i(2, "100"),
    t({", \\width, 1, \\att, 0.004, \\sus, 0.001, \\rel, 2, \\attCrv, 2, \\relCrv, -2, \\filtAtt, 0, \\filtSus, 0.0001, \\filtRel, 2, \\filtAttC, 2, \\filtRelC, -2, \\cutoff, 2000, \\resGain, 1);"})
}),
s("karplus", {
    t({"Ndef(\\"}),
    i(1, "karplus"),
    t({")[0] = Pbind(\\instrument, \\karplus, \\amp, 0.1, \\auxOut, 0, \\auxAmp, 0, \\panSpeed, 0, \\panPhase, 2, \\panamp, 0.2.0, \\noiseFreq, 20000, \\trigFreq, 2, \\sigAtt, 0.000000001, \\sigRel, 0.1, \\sigCrv, -4, \\filtAtt, 0, \\filtSus, 0.03, \\filtRel, 2, \\filtAttC, 2, \\filtRelC, -2, \\freq, "}),
    i(2, "440"),
    t({", \\rel, 5, \\coef, 0.5, \\pre, 1.0, \\cutoff, 600, \\rq, 1.0, \\threshold, 0.5, \\slopeBelow, 1, \\slopeAbove, 0.5, \\clampTime, 0.001, \\relaxTime, 0.1);"})
}),
s("fmOld", {
    t({"Ndef(\\"}),
    i(1, "fmOld"),
    t({")[0] = Pbind(\\instrument, \\fmOld, \\amp, 0.1, \\auxOut, 0, \\auxAmp, 0, \\freq, "}),
    i(2, "440"),
    t({", \\carPartial, 1, \\modPartial, 1, \\index, 3, \\att, 0.0001, \\rel, 2, \\attC, 0, \\relC, 0, \\modAtt, 0.0001, \\modRel, 2, \\modAttC, 0, \\modRelC, 0, \\panamp, 0.2.0, \\panRate, 0.125, \\panPhase, 2, \\panWidth, 2, \\vibFreq, 0, \\vibDepth, 0, \\vibPhase, 2);"})
}),
s("fm", {
    t({"Ndef(\\"}),
    i(1, "fm"),
    t({")[0] = Pbind(\\instrument, \\fm, \\amp, 0.2, \\mod1amp, 500, \\mod1ratio, 1, \\mod2amp, 0, \\mod2ratio, 1, \\carRatio, 1, \\freq, "}),
    i(2, "500"),
    t({", \\index1, 1, \\index1Scale, 5, \\index1Att, 0.001, \\index1Rel, 3, \\index1AttCrv, 4, \\index1RelCrv, -4, \\index2, 1, \\index2Scale, 5, \\index2Att, 0.001, \\index2Rel, 3, \\index2AttCrv, 4, \\index2RelCrv, -4, \\att, 0.001, \\rel, 2, \\attCrv, 4, \\relCrv, -4, \\filtAtt, 0, \\filtSus, 0.03, \\filtRel, 2, \\filtAttC, 2, \\filtRelC, -2, \\filtGain, 1.0, \\cutoff, 20000, \\rq, 1.0, \\pan, 0, \\auxOut, 0, \\auxAmp, 0);"})
}),
s("fm_algo4", {
    t({"Ndef(\\"}),
    i(1, "fm_algo4"),
    t({")[0] = Pbind(\\instrument, \\fm_algo4, \\amp_1, 1, \\amp_2, 0.5, \\amp_3, 0.5, \\amp_4, 1, \\amp_5, 0.5, \\amp_6, 0.5, \\ratio1, 1, \\ratio2, 1, \\ratio3, 1, \\ratio4, 1, \\ratio5, 1, \\ratio6, 1, \\mInd_1, 0.5, \\mInd_2, 0.5, \\mInd_3, 0.1, \\mInd_4, 0.5, \\mInd_5, 0.5, \\mInd_6, 0.5, \\fb, 0.9, \\freq, "}),
    i(2, "111"),
    t({", \\amp, 0.2);"})
}),
s("gong", {
    t({"Ndef(\\"}),
    i(1, "gong"),
    t({")[0] = Pbind(\\instrument, \\gong, \\amp, 0.2, \\freqLo, 0, \\freq, "}),
    i(2, "440"),
    t({", \\att, 0.001, \\sus, 0.03, \\rel, 2, \\attCrv, 2, \\relCrv, -2, \\pan, 0, \\auxOut, 0, \\auxAmp, 0);"})
}),
s("multiSaw", {
    t({"Ndef(\\"}),
    i(1, "multiSaw"),
    t({")[0] = Pbind(\\instrument, \\multiSaw, \\amp, 0.2, \\detune, 0.05, \\att, 0.001, \\sus, 0.03, \\rel, 2, \\gain, 1.0, \\cutoff, 600, \\rq, 1.0, \\threshold, 0.5, \\slopeBelow, 1, \\slopeAbove, 0.5, \\clampTime, 0.001, \\relaxTime, 0.1, \\pan, 0, \\auxOut, 0, \\auxAmp, 0, \\freq, "}),
    i(2, "100"),
    t({");"})
}),
s("bd808", {
    t({"Ndef(\\"}),
    i(1, "bd808"),
    t({")[0] = Pbind(\\instrument, \\bd808, \\amp, 0.2, \\rel, 4, \\tone, 56, \\fRel, 0.6, \\punchTone, 56, \\punchRel, 0.6, \\subAmp, 0.05, \\pan, 0, \\auxOut, 0, \\auxAmp, 0);"})
}),
s("sd808", {
    t({"Ndef(\\"}),
    i(1, "sd808"),
    t({")[0] = Pbind(\\instrument, \\sd808, \\amp, 0.2, \\noiseRel, 4.2, \\attRel, 0.8, \\snappy, 0.3, \\noiseHpfFreq, 1800, \\noiseLpfFreq, 8850, \\hpfFreq, 340, \\pan, 0, \\auxOut, 0, \\auxAmp, 0);"})
}),
s("cp808", {
    t({"Ndef(\\"}),
    i(1, "cp808"),
    t({")[0] = Pbind(\\instrument, \\cp808, \\amp, 0.2, \\atRel, 0.3, \\dDelay, 0.026, \\dDecay, 6, \\dRel, 1, \\dPeak, 1, \\hpfFreq, 500, \\bpfFreq, 1062, \\bpfRq, 0.5, \\pan, 0, \\auxOut, 0, \\auxAmp, 0);"})
}),
s("lt808", {
    t({"Ndef(\\"}),
    i(1, "lt808"),
    t({")[0] = Pbind(\\instrument, \\lt808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\rel, 20, \\relCrv, -250, \\pRel, 30, \\prelCrv, -225, \\freq, "}),
    i(2, "80"),
    t({");"})
}),
s("mt808", {
    t({"Ndef(\\"}),
    i(1, "mt808"),
    t({")[0] = Pbind(\\instrument, \\mt808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\rel, 16, \\relCrv, -250, \\fRel, 0.5, \\freq, "}),
    i(2, "120"),
    t({");"})
}),
s("ht808", {
    t({"Ndef(\\"}),
    i(1, "ht808"),
    t({")[0] = Pbind(\\instrument, \\ht808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\rel, 11, \\relCrv, -250, \\fRel, 0.5, \\freq, "}),
    i(2, "165"),
    t({");"})
}),
s("lc808", {
    t({"Ndef(\\"}),
    i(1, "lc808"),
    t({")[0] = Pbind(\\instrument, \\lc808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\pan, 0, \\rel, 18, \\relCrv, -250, \\pRel, 30, \\prelCrv, -225, \\fRel, 0.5, \\freq, "}),
    i(2, "165"),
    t({");"})
}),
s("mc808", {
    t({"Ndef(\\"}),
    i(1, "mc808"),
    t({")[0] = Pbind(\\instrument, \\mc808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rel, "}),
    i(2, "9"),
    t({", \\relCrv, -250, \\freq, "}),
    i(3, "250"),
    t({", \\fRel, 0.5, \\frelCrv, -4, \\pan, 0);"})
}),
s("hc808", {
    t({"Ndef(\\"}),
    i(1, "hc808"),
    t({")[0] = Pbind(\\instrument, \\hc808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rel, "}),
    i(2, "6"),
    t({", \\relCrv, -250, \\freq, "}),
    i(3, "370"),
    t({", \\fRel, 0.5, \\frelCrv, -4, \\pan, 0);"})
}),
s("rim808", {
    t({"Ndef(\\"}),
    i(1, "rim808"),
    t({")[0] = Pbind(\\instrument, \\rim808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rel, "}),
    i(2, "0.07"),
    t({", \\relCrv, -42, \\tri1freq, "}),
    i(3, "1667"),
    t({", \\tri2freq, 455, \\hpfFreq, 315, \\lpfFreq, 7300, \\pan, 0);"})
}),
s("claves808", {
    t({"Ndef(\\"}),
    i(1, "claves808"),
    t({")[0] = Pbind(\\instrument, \\claves808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rel, "}),
    i(2, "0.1"),
    t({", \\relCrv, -20, \\freq, "}),
    i(3, "2500"),
    t({", \\pan, 0);"})
}),
s("maracas808", {
    t({"Ndef(\\"}),
    i(1, "maracas808"),
    t({")[0] = Pbind(\\instrument, \\maracas808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\rel, "}),
    i(2, "0.07"),
    t({", \\relCrv, -250, \\hpfFreq, "}),
    i(3, "5500"),
    t({", \\pan, 0);"})
}),
s("cowbell808", {
		t({"Ndef(\\",}),
		i(1, "cowbell808"),
		t({")[0] = Pbind(\\instrument, \\cowbell808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\pan, 0, \\attRel, 1, \\attrelCrv, -215, \\rel, 9.5, \\relCrv, -90, \\pulse1freq, "}),
		i(2, "811.16"),
		t({", \\pulse2freq, 538.75, \\hpfFreq, 250, \\lpfFreq, 4500);"})
}),
s("hat808", {
		t({"Ndef(\\",}),
		i(1, "hat808"),
		t({")[0] = Pbind(\\instrument, \\hat808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\pan, 0, \\rel, 0.42, \\relCrv, -30, \\osc1freq, "}),
		i(2, "203.52"),
		t({", \\osc2freq, 366.31, \\osc3freq, 301.77, \\osc4freq, 518.19, \\osc5freq, 811.16, \\osc6freq, 538.75, \\sigHiBpfFreq, 8900, \\sigHiHpfFreq, 9000, \\sigLowBpfFreq, 8900, \\sigLowHpfFreq, 9000, \\eqFreq, 9700);"})
}),
s("hatOpen808", {
		t({"Ndef(\\",}),
		i(1, "hatOpen808"),
		t({")[0] = Pbind(\\instrument, \\hatOpen808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\pan, 0, \\env1rel, 0.5, \\env1relCrv, -3, \\env2rel, 0.5, \\env2relCrv, -150, \\osc1freq, "}),
		i(2, "203.52"),
		t({", \\osc2freq, 366.31, \\osc3freq, 301.77, \\osc4freq, 518.19, \\osc5freq, 811.16, \\osc6freq, 538.75, \\bpfFreq, 7700, \\lpfFreq, 4000);"})
}),
s("cymbal808", {
		t({"Ndef(\\",}),
		i(1, "cymbal808"),
		t({")[0] = Pbind(\\instrument, \\cymbal808, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\pan, 0, \\rel1, 2, \\rel1crv, -3, \\rel2, 2, \\rel2crv, -5, \\rel3, 2, \\rel3crv, -150, \\osc1freq, "}),
		i(2, "203.52"),
		t({", \\osc2freq, 366.31, \\osc3freq, 301.77, \\osc4freq, 518.19, \\osc5freq, 811.16, \\osc6freq, 538.75, \\sig1bpf, 3000, \\sig1eq, 2400, \\tone, 0.002, \\sig2bpf, 7400, \\sig2eq, 7200, \\sig3bpf, 6500, \\sig3eq, 7400, \\lpf, 4000);"})
}),
s("gverb", {
		t({"Ndef(\\"}),
		i(1, "gverb"),
		t({")[0] = Pbind(\\instrument, \\gverb, \\inamp, 1, \\roomsize, 10, \\revtime, 4, \\damping, 0.5, \\inputbw, 0.5, \\spread, 15, \\drylevel, 0, \\earlyreflevel, 0.7, \\taillevel, 0.5, \\maxroomsize, 300, \\cutoff, 20000, \\auxAmp, 0, \\out, 0, \\auxOut, 0);"})
}),
s("freeverb", {
		t({"Ndef(\\"}),
		i(1, "freeverb"),
		t({")[0] = Pbind(\\instrument, \\freeverb, \\inamp, 1, \\mix, 1, \\room, 0.95, \\damp, 0.3, \\out, 0, \\auxOut, 0, \\auxAmp, 0);"})
}),
s("serialverb", {
		t({"Ndef(\\"}),
		i(1, "serialverb"),
		t({")[0] = Pbind(\\instrument, \\serialverb, \\inamp, 1, \\feedback, 0.9, \\cutoff, 3000, \\maxDelayTime, 0.2, \\minDelayTime, 0.01, \\decayTime, 3, \\out, 0, \\auxOut, 0, \\auxAmp, 0);"})
}),
s("tank", {
		t({"Ndef(\\"}),
		i(1, "tank"),
		t({")[0] = Pbind(\\instrument, \\tank, \\feedback, 0.98, \\out, 0, \\auxOut, 0, \\auxAmp, 0);"})
}),
s("delay", {
		t({"Ndef(\\"}),
		i(1, "delay"),
		t({")[0] = Pbind(\\instrument, \\delay, \\in, 0, \\amp, 0.2, \\delayTime, 1.0, \\delayTimeLag, 3, \\delayDecay, 6, \\out, 0, \\auxOut, 0, \\auxAmp, 0);"})
}),
s("delay", {
    t({"Ndef(\\"}),
    i(1, "delay"),
    t({")[0] = Pbind(\\instrument, \\delay, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\delayTime, 1.0, \\delayTimeLag, 3, \\delayDecay, 6);"})
}),
s("dfm1", {
    t({"Ndef(\\"}),
    i(1, "dfm1"),
    t({")[0] = Pbind(\\instrument, \\dfm1, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\freq, "}),
    i(2, "1000.0"),
    t({", \\res, 0.1, \\inputgain, 1.0, \\type, 0.0, \\noiselevel, 0.0003);"})
}),
s("master", {
    t({"Ndef(\\"}),
    i(1, "master"),
    t({")[0] = Pbind(\\instrument, \\master, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\thresh, 0.5, \\slopeBelow, 1.0, \\slopeAbove, 1.0, \\clampTime, 0.01, \\relaxTime, 0.1);"})
}),
s("efKick", {
    t({"Ndef(\\"}),
    i(1, "efKick"),
    t({")[0] = Pbind(\\instrument, \\efKick, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\freqA, 800, \\freqB, 50, \\freqC, 40, \\freqDur1, 0.02, \\freqDur2, 0.5, \\freqC1, -3, \\freqC2, -1, \\att, 0.02, \\rel, 2, \\attCrv, 1, \\relCrv, -12, \\pan, 0);"})
}),
s("wt", {
    t({"Ndef(\\"}),
    i(1, "wt"),
    t({")[0] = Pbind(\\instrument, \\wt, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\wt, 0, \\inamp, 1);"})
}),
s("noiseSweep", {
    t({"Ndef(\\"}),
    i(1, "noiseSweep"),
    t({")[0] = Pbind(\\instrument, \\noiseSweep, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\att, 0.02, \\rel, 2, \\attCrv, 1, \\relCrv, -12, \\filtAtt, 0, \\filtSus, 0.03, \\filtRel, 2, \\filtAttC, 2, \\filtRelC, -2, \\freqStart, 20000, \\freqEnd, 1000, \\freqAtt, 0, \\freqRel, 2, \\freqAttC, 2, \\freqRelC, -2, \\cutoff, 4000, \\rq, 0.2);"})
}),
s("glide", {
    t({"Ndef(\\"}),
    i(1, "glide"),
    t({")[0] = Pbind(\\instrument, \\glide, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\freq, "}),
    i(2, "440"),
    t({", \\freqModFreq, 0.5, \\freqModMul, 100, \\panModFreq, 0.5, \\ampModFreq, 0.1, \\att, 0.001, \\sus, 0.03, \\rel, 2, \\attCrv, 2, \\relCrv, -2, \\pan, 0);"})
}),
s("blip", {
    t({"Ndef(\\",}),
    i(1, "blip"),
    t({")[0] = Pbind(\\instrument, \\blip, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\freq, "}),
    i(2, "440"),
    t({", \\numharm, 200, \\att, 0.003, \\sus, 0.03, \\rel, 1, \\attCrv, 2, \\relCrv, -2, \\pan, 0);"})
}),
s("syncBasic", {
    t({"Ndef(\\",}),
    i(1, "syncBasic"),
    t({")[0] = Pbind(\\instrument, \\syncBasic, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\syncFreq, "}),
    i(2, "440"),
    t({", \\sawFreq, 440, \\att, 0.003, \\sus, 0.03, \\rel, 1, \\attCrv, 2, \\relCrv, -2, \\pan, 0);"})
}),
s("syncSaw", {
    t({"Ndef(\\",}),
    i(1, "syncSaw"),
    t({")[0] = Pbind(\\instrument, \\syncSaw, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\syncFreq, "}),
    i(2, "440"),
    t({", \\sawFreq, 440, \\syncModFreq, 0, \\syncModMul, 1, \\syncModAdd, 0, \\sawModFreq, 0, \\sawModMul, 1, \\sawModAdd, 0, \\att, 0.003, \\sus, 0.03, \\rel, 1, \\attCrv, 2, \\relCrv, -2, \\cutoff, 2000, \\rq, 1.0, \\pre, 1.0, \\filtAtt, 0, \\filtSus, 0.03, \\filtRel, 3, \\filtAttC, 2, \\filtRelC, -2, \\pan, 0);"})
}),
s("klang", {
    t({"Ndef(\\",}),
    i(1, "klang"),
    t({")[0] = Pbind(\\instrument, \\klang, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\freq, "}),
    i(2, "800"),
    t({", \\amps, 0.05, \\att, 0, \\sus, 0.03, \\rel, 2, \\attCrv, 2, \\relCrv, -2, \\cutoff, 8000, \\filterGain, 2, \\pan, 0);"})
}),
s("klangFilter", {
    t({"Ndef(\\",}),
    i(1, "klangFilter"),
    t({")[0] = Pbind(\\instrument, \\klangFilter, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\freq, "}),
    i(2, "800"),
    t({", \\amps, 0.05, \\att, 0, \\sus, 0.03, \\rel, 2, \\attCrv, 2, \\relCrv, -2, \\filtAtt, 0, \\filtSus, 0.03, \\filtRel, 2, \\filtAttC, 2, \\filtRelC, -2, \\cutoff, 20000, \\rq, 1.0, \\filtGain, 1.0, \\pan, 0);"})
}),
s("input", {
    t({"Ndef(\\",}),
    i(1, "input"),
    t({")[0] = Pbind(\\instrument, \\input, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\dur, 1, \\in, 0, \\out, 0);"})
}),
s("samp", {
    t({"Ndef(\\",}),
    i(1, "samp"),
    t({")[0] = Pbind(\\instrument, \\samp, \\amp, 0.2, \\auxOut, 0, \\auxAmp, -30, \\dur, 1, \\buf, 0, \\rate, 1, \\spos, 0, \\att, 0, \\sus, 0.1, \\rel, 0, \\pan, 0);"})
}),
s("fbDelay", {
    t({"Ndef(\\",}),
    i(1, "fbDelay"),
    t({")[0] = Pbind(\\instrument, \\fbDelay, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0.5, \\delayTime, 1.0, \\delayTimeLag, 3, \\delayDecay, 6);"})
}),
s("infinity", {
    t({"Ndef(\\",}),
    i(1, "infinity"),
    t({")[0] = Pbind(\\instrument, \\infinity, \\feedback, 1);"})
}),
s("vosc", {
    t({"Ndef(\\",}),
    i(1, "vosc"),
    t({")[0] = Pbind(\\instrument, \\vosc, \\amp, 0.2, \\auxOut, 0, \\auxAmp, 0, \\detune, 0.2, \\numBufs, 2, \\freq, "}),
    i(2, "300"),
    t({", \\bufposTime, 8, \\bufposCrv, 0, \\att, 0, \\sus, 0, \\rel, 8, \\attCrv, 2, \\relCrv, -4, \\pan, 0);"})
}),
s("granMic", {
    t({"Ndef(\\",}),
    i(1, "granMic"),
    t({")[0] = Pbind(\\instrument, \\granMic, \\amp, 0.2, \\in, 0);"})
}),
s("granPointer", {
    t({"Ndef(\\",}),
    i(1, "granPointer"),
    t({")[0] = Pbind(\\instrument, \\granPointer, \\rate, 1, \\buf, 0);"})
}),
s("gran", {
    t({"Ndef(\\",}),
    i(1, "gran"),
    t({")[0] = Pbind(\\instrument, \\gran, \\amp, 0.5, \\bufL, 0, \\bufR, 0, \\att, 1, \\rel, 1, \\gate, 1, \\sync, 1, \\dens, 40, \\baseDur, 0.05, \\durRand, 1, \\rate, 1, \\rateRand, 1, \\pan, 0, \\panRand, 0, \\grainEnv, -1, \\ptrBus, 0, \\ptrSampleDelay, 20000, \\ptrRandSamples, 5000, \\minPtrDelay, 1000);"})
}),
s("granRec", {
    t({"Ndef(\\",}),
    i(1, "granRec"),
    t({")[0] = Pbind(\\instrument, \\granRec, \\ptrIn, 0, \\sigIn, 0, \\bufL, 0, \\bufR, 0);"})
}),

s({ trig = "rev", name = "Ndef[50] JPverb" }, {
  t({ 'Ndef(\\', }),
  i(1, 'name'),
  t({ ')[50] = \\filter -> {|in| JPverb.ar(in:in, t60:1.0, damp:0.0, size:1.0, earlyDiff:0.707, modDepth:0.1, modFreq:2.0, low:1.0, mid:1.0, high:1.0, lowcut:500.0, highcut:2000.0)}; Ndef(\\' }),
  r(1),
	t({").set(\\wet50, "}),
	i(2, "0.3"),
	t({" )"})
}),

}

return snippets
