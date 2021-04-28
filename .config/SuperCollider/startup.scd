(
~channels = 2;
~count = 0;
~bpm = 120;
MIDIClient.init;
MIDIIn.connectAll;
m = MIDIOut.new(0);

// m.noteOn(0, 60, 30);
m.latency = 0;
// m.noteOn(0, 60, 30);
// m.allNotesOff(0);
CmdPeriod.add({(0..127).do{arg n; m.noteOff(0, n)}});
s.options.numOutputBusChannels_(4);
s.options.numInputBusChannels_(4);
s.options.sampleRate_(41000);
s.options.memSize_(2**20);
ServerTree.removeAll;
s.newBusAllocators;
~reverbBus = Bus.audio(s, 2);
~makeNodes = {
	s.bind({
		~fxGroup = Group.new;
		~reverb = Synth(\reverb, [\in, ~reverbBus, \out, 0], ~fxGroup);
		~input = Synth(\input, [\in, 6, \out, ~reverbBus]);
	});
};
// ~events = [
// {~sampPlayer = ~sampPat.play(quant:1)},
// {~beepPlayer = ~beepPat.play(quant:1)},
// {~dronesPlayer = ~dronesPat.play},
// {
// ~sampPlayer.stop;
// ~dronesPlayer.stop;
// },
// {~beepPlayer.stop}
// ];

s.waitForBoot({

	s.freeAll;
	Buffer.freeAll;

	s.sync;

	//                  _   _
	//  ___ _   _ _ __ | |_| |__  ___
	// / __| | | | '_ \| __| '_ \/ __|
	// \__ \ |_| | | | | |_| | | \__ \
	// |___/\__, |_| |_|\__|_| |_|___/
	//      |___/
	// 

	SynthDef.new(\synth, {
		var carrier, mod, env, modEnv, vib, pan, sig, filtEnv;
		env = Env(
			[0,1,1,0],
			[\att.kr(0), \sus.kr(0.03), \rel.kr(2)],
			[\attC.kr(2),0,\relC.kr(-2)]
		).ar(2);
		modEnv = Env(
			[0,1,1,0],
			[\modAtt.kr(0), \modSus.kr(0.03), \modRel.kr(2)],
			[\modAttC.kr(2),0,\modRelC.kr(-2)]
		).ar(0);
		filtEnv = Env(
			[0,1,1,0],
			[\filtAtt.kr(0), \filtSus.kr(0.03), \filtRel.kr(2)],
			[\filtAttC.kr(2),0,\filtRelC.kr(-2)]
		).ar(0);
		mod = SinOsc.ar(\freq.kr(440)*\modPartial.kr(1),0,\freq.kr(440)*\index.kr(3)) * modEnv * \modAmp.kr(0.0);
		vib = LFTri.kr(\vibFreq.kr(0),\vibPhase.kr(2),\vibDepth.kr(0));
		carrier = Select.ar(\timbre.kr(0), 
		[
			SinOsc.ar((\freq.kr(440)*\carPartial.kr(1))+mod+vib,0),
			VarSaw.ar((\freq.kr(440)*\carPartial.kr(1))+mod+vib,0,\width.kr(0.5)) * 0.5,
			LFPulse.ar((\freq.kr(440)*\carPartial.kr(1))+mod+vib,0,\width.kr(0.5)) * 0.5,
		]
	);
	pan = LFTri.kr(\panRate.kr(0),\panPhase.kr(2),\panAmp.kr(1.0));
	sig = carrier * \amp.kr(0.5) * env;
	sig = PanAz.ar(~channels,sig,pan,1,\panWidth.kr(2));
	sig = RLPF.ar(sig,  \cutoff.kr(600) * filtEnv + 10,  \rq.kr(1.0));
	Out.ar(\out.kr(0),sig);
	Out.ar(\auxOut.kr(0), sig * \auxAmp.kr(0));
}).add;

SynthDef.new(\sine, {
	var sig, env;
	sig = SinOsc.ar(\freq.kr(100));
	env = Env(
		[0,1,1,0],
		[\atk.kr(0), \sus.kr(0.03), \rel.kr(0)],
		[\atkcrv.kr(2),0,\relcrv.kr(-2)]
	).ar(2);
	sig = sig * env;
	sig = Pan2.ar(sig, \pan.kr(0), \amp.kr(0.3));
	Out.ar(\out.kr(0), sig);
	Out.ar(\auxOut.kr(0), sig * \auxAmp.kr(-30).dbamp);
}).add;

SynthDef.new(\saw, {
	var sig, env;
	sig = VarSaw.ar(\freq.kr(100), 0, \width.kr(0.5));
	env = Env(
		[0,1,1,0],
		[\atk.kr(0), \sus.kr(0.03), \rel.kr(0)],
		[\atkcrv.kr(2),0,\relcrv.kr(-2)]
	).ar(2);
	sig = sig * env;
	sig = Pan2.ar(sig, \pan.kr(0), \amp.kr(0.3));
	Out.ar(\out.kr(0), sig);
	Out.ar(\auxOut.kr(0), sig * \auxAmp.kr(-30).dbamp);
}).add;

SynthDef(\karplus,{
	var sig, sigEnv, env, karplus, trig, panMod, filtEnv;
	panMod = LFTri.kr(\panSpeed.kr(0.125),\panPhase.kr(2),\panAmp.kr(1.0));
	sig = LFNoise0.ar(\noiseFreq.kr(20000));
	trig = Impulse.kr(\trigFreq.kr(2));
	sigEnv = Env([0,1,0],[\sigAtt.kr(0.000000001),\sigRel.kr(0.1)],\sigCrv.kr(-4)).kr();
	filtEnv = Env(
		[0,1,1,0],
		[\filtAtt.kr(0), \filtSus.kr(0.03), \filtRel.kr(2)],
		[\filtAttC.kr(2),0,\filtRelC.kr(-2)]
	).ar(0);
	env = Env([0,1,0],[\att.kr(0.000000001),\rel.kr(5)],\crv.kr(-4)).kr(2);
	sig = sig * sigEnv;
	karplus = Pluck.ar(sig, trig, \freq.kr(440).reciprocal, \freq.kr(440).reciprocal, \rel.kr(5), \coef.kr(0.5), \mul.kr(1.0), \add.kr(0.0));
	karplus = karplus * env * \pre.kr(1.0);
	karplus = RLPF.ar(karplus,  \cutoff.kr(600) * filtEnv + 10,  \rq.kr(1.0));
	karplus = Compander.ar(karplus, karplus, \threshold.kr(0.5), \slopeBelow.kr(1), \slopeAbove.kr(0.5), \clampTime.kr(0.001), \relaxTime.kr(0.1));  
	karplus = Pan2.ar(karplus, panMod);
	Out.ar(\out.kr(0), karplus * \amp.kr(0.5));
	Out.ar(\auxOut.kr(0), karplus * \auxAmp.kr(0));
}).add;

SynthDef(\fmOld,{
	// carPartial :: modPartial => car/mod ratio
	|
	out=0, auxOut=0, freq=440, carPartial=1, modPartial=1, index=3, mul=0.05,
	amp=0.5, auxAmp=0,
	att=0.0001, rel=2, attC=0, relC=0,
	modAtt=0.0001, modRel=2, modAttC=0, modRelC=0,
	panAmp=1.0, panRate=0.125, panPhase=2, panWidth=2,
	vibFreq=0, vibDepth=0, vibPhase=2
	|
	var carrier, mod1, env, mod1Env, vib, pan, sig;
	env = Env.new([0,1,0],[att,rel],[attC,relC]).kr(2);
	mod1Env = Env.new([0,1,0],[modAtt,modRel],[modAttC,modRelC]).kr();
	mod1 = SinOsc.ar(freq*modPartial,0,freq*index);
	// mod1 = SinOsc.ar(freq*modPartial,0,freq*index*LFNoise1.kr(5.reciprocal).abs);
	vib = LFTri.kr(vibFreq,vibPhase,vibDepth);
	mod1 = mod1 * mod1Env;
	carrier = SinOsc.ar((freq*carPartial)+mod1+vib,0);
	pan = LFTri.kr(panRate,panPhase,panAmp);
	sig = carrier * amp * env;
	sig = PanAz.ar(~channels,sig,pan,1,panWidth);
	Out.ar(0,sig);
	Out.ar(auxOut,sig*auxAmp);
}).add;

SynthDef(\fm,{
	// carPartial :: modPartial => car/mod ratio
	var carrier, mod1, env, mod1Env, vib, pan, sig, freqEnv;
	env = Env.new([0,1,0],[\att.kr(0.00001),\rel.kr(2)],[\attC.kr(0),\relC.kr(0)]).kr(2);
	freqEnv = Env.new([\freqStart.kr(0),\freq.kr(440),\freqEnd.kr(0)],[\freqAtt.kr(0.00001),\freqRel.kr(1000)],[\freqAttC.kr(0),\freqRelC.kr(1000)]).kr();
	mod1Env = Env.new([0,1,0],[\modAtt.kr(0.00001),\modRel.kr(2)],[\modAttC.kr(0),\modRelC.kr(0)]).kr();
	mod1 = SinOsc.ar(freqEnv*\modPartial.kr(1),0,\freq.kr(440)*\index.kr(3));
	// mod1 = SinOsc.ar(\freq.kr(440)*\modPartial,0,\freq.kr(440)*index*LFNoise1.kr(5.reciprocal).abs);
	vib = LFTri.kr(\vibfreq.kr(0),\vibPhase.kr(2),\vibDepth.kr(0));
	mod1 = mod1 * mod1Env;
	carrier = SinOsc.ar((freqEnv*\carPartial.kr(1))+mod1+vib,0);
	pan = LFTri.kr(\panRate.kr(0),\panPhase.kr(2),\panAmp.kr(0));
	sig = carrier * \amp.kr(0.5) * env;
	sig = PanAz.ar(~channels,sig,pan,1,\panWidth.kr(2));
	Out.ar(\out.kr(0),sig);
	Out.ar(\auxOut.kr(0),sig*\auxAmp.kr(0));
}).add;

SynthDef(
	\gong, { | out, freq = 440, amp = 0.1, panX = 0, panY = 0, gate = 1,
		attack = 0.01, release = 1, curve = -3, // envelope
		freqAttack = 0.001, freqRelease = 0.1, freqCurve = -3, freqLow = 0| // frequency stuff
		var freqEnvelope, sum = 0, temp, env;
		freqEnvelope = EnvGen.kr(Env.perc(freqAttack,freqRelease,curve:freqCurve), gate);
		15.do{
			temp = SinOsc.ar(Rand(freqLow,freq)!4,0,{ExpRand(0.005,0.05)}!4);
			sum = sum + temp;
		};
		// var audio = {Klang.ar(`[ Array.rand(15, 30.midicps, 90.midicps),nil, nil ], 1, 0)};
		env = EnvGen.kr(Env.perc(attack, release, 1, curve),1,amp, doneAction:2);
		Out.ar(out, Pan2.ar(sum, panX, env));
		// Out.ar(out, Pan4.ar(sum, panX, panY, env));
	}).add;

	SynthDef.new(\multiSaw, {
		var sig, env, temp, filtEnv;
		var sum = 0;
		4.do{
			temp = VarSaw.ar(
				\freq.kr(100) * {Rand(0.99,1.02)}!2,
				{Rand(0.0,1.0)}!2,
				\width.kr(0.5) * {ExpRand(0.9,1.1)}!2
			);
			sum = sum + temp;
		};
		env = Env(
			[0,1,1,0],
			[\att.kr(0.001), \sus.kr(0.03), \rel.kr(2)],
			[\attCrv.kr(2),0,\relCrv.kr(-2)]
		).ar(2);
		filtEnv = Env(
			[0,1,1,0],
			[\filtAtt.kr(0), \filtSus.kr(0.03), \filtRel.kr(2)],
			[\filtAttC.kr(2),0,\filtRelC.kr(-2)]
		).ar(0);
		sig = sum * env;
		sig = MoogFF.ar(sig * \gain.kr(1.0), \cutoff.kr(600) * filtEnv + 10,  \rq.kr(1.0));
		sig = Compander.ar(sig, sig, \threshold.kr(0.5), \slopeBelow.kr(1), \slopeAbove.kr(0.5), \clampTime.kr(0.001), \relaxTime.kr(0.1));  
		sig = Pan2.ar(sig, \pan.kr(0));
		Out.ar(\out.kr(0), sig * \amp.kr(0.5));
		Out.ar(\auxOut.kr(0), sig * \auxAmp.kr(0));
	}).add;

	// SynthDef.new(\bd808, {
	// var fenv, env, trienv, sig, sub, punch, pfenv;
	// env = EnvGen.kr(Env.new([0.11, 1, 0], [0, \decay.kr(30)], -225),doneAction:2);
	// trienv = EnvGen.kr(Env.new([0.11, 0.6, 0], [0, \decay.kr(30)], -230),doneAction:0);
	// fenv = Env([\tone.kr(56)*7, \tone.kr(56)*1.35, \tone.kr(56)], [0.05, 0.6], -14).kr;
	// pfenv = Env([\tone.kr(56)*7, \tone.kr(56)*1.35, \tone.kr(56)], [0.03, 0.6], -10).kr;
	// sig = SinOsc.ar(fenv, pi/2) * env;
	// sub = LFTri.ar(fenv, pi/2) * trienv * 0.05;
	// punch = SinOsc.ar(pfenv, pi/2) * env * 2;
	// punch = HPF.ar(punch, 350);
	// sig = (sig + sub + punch) * 2.5;
	// sig = Limiter.ar(sig, 0.5) * \amp.kr(1);
	// sig = Pan2.ar(sig, 0);
	// Out.ar(0, sig);
	// }).add;

	SynthDef.new(\bd808, {
		var fenv, env, trienv, sig, sub, punch, pfenv;
		env = EnvGen.kr(Env.new([0.11, 1, 0], [0, \rel.kr(4)], \relCrv.kr(-30)),doneAction:2);
		trienv = EnvGen.kr(Env.new([0.11, 0.6, 0], [0, \rel.kr(4)], \relCrv.kr(-30)),doneAction:0);
		fenv = Env([\tone.kr(56)*7, \tone.kr(56)*1.35, \tone.kr(56)], [0.05, 0.6], -14).kr;
		pfenv = Env([\tone.kr(56)*7, \tone.kr(56)*1.35, \tone.kr(56)], [0.03, 0.6], -10).kr;
		sig = SinOsc.ar(fenv, pi/2) * env;
		sub = LFTri.ar(fenv, pi/2) * trienv * 0.05;
		punch = SinOsc.ar(pfenv, pi/2) * env * 2;
		punch = HPF.ar(punch, 350);
		sig = (sig + sub + punch) * 2.5;
		sig = Limiter.ar(sig, 0.5);
		sig = Pan2.ar(sig, \pan.kr(0));
		Out.ar(\out.kr(0), sig * \amp.kr(1));
		Out.ar(\auxOut.kr(0), sig * \auxAmp.kr(0));
	}).add;

	SynthDef.new(\sd808, {
		var noiseEnv, atkEnv, sig, noise, osc1, osc2, sum;
		noiseEnv = EnvGen.kr(Env.perc(0.001, 4.2, 1, -115), doneAction:2);
		atkEnv = EnvGen.kr(Env.perc(0.001, 0.8,curve:-95), doneAction:0);
		noise = WhiteNoise.ar;
		noise = HPF.ar(noise, 1800);
		noise = LPF.ar(noise, 8850);
		noise = noise * noiseEnv * \snappy.kr(0.3);
		osc1 = SinOsc.ar(\tone2.kr(189), pi/2) * 0.6;
		osc2 = SinOsc.ar(\tone.kr(340), pi/2) * 0.7;
		sum = (osc1+osc2) * atkEnv * \amp2.kr(1);
		sig = Pan2.ar((noise + sum) * \amp.kr(1), 0);
		sig = HPF.ar(sig, 340);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\cp808, {
		var atkenv, atk, decay, sum, denv;
		atkenv = EnvGen.kr(Env.new([0.5,1,0],[0, 0.3], -160), doneAction:2);
		denv = EnvGen.kr(Env.dadsr(0.026, 0, 6, 0, 1, 1, curve:-157), doneAction:0);
		atk = WhiteNoise.ar * atkenv * 1.4;
		decay = WhiteNoise.ar * denv;
		sum = atk + decay * \amp.kr(1);
		sum = HPF.ar(sum, 500);
		sum = BPF.ar(sum, 1062, 0.5);
		Out.ar(0, Pan2.ar(sum * 1.5, 0));
	}).add;

	// SynthDef.new(\808cpReverb, {
	// arg amp=1, gate=0;
	// var reverb, revgen;
	// revgen = EnvGen.kr(Env.perc(0.1, 4, curve:-9), gate, doneAction:2);
	// reverb = WhiteNoise.ar * revgen * 0.02;
	// reverb = HPF.ar(reverb, 500);
	// reverb = LPF.ar(reverb, 1000);
	// Out.ar(0, Pan2.ar(reverb * amp, 0));
	// }).add;

	SynthDef.new(\lt808, {
		var sig, fenv, env, pnoise, penv;
		env = EnvGen.kr(Env.new([0.4, 1, 0], [0, 20], -250),doneAction:2);
		penv = EnvGen.kr(Env.new([0.6, 1, 0], [0, 30], -225),doneAction:2);
		fenv = Env([\freq.kr(80)*1.25, \freq.kr(80)*1.125, \freq.kr(80)], [0.1, 0.5], -4).kr;
		sig = SinOsc.ar(fenv, pi/2) * env;
		sig = Pan2.ar(sig * \amp.kr(1) * 0.7, 0);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\mt808, {
		var sig, fenv, env;
		env = EnvGen.kr(Env.new([0.4, 1, 0], [0, 16], -250),doneAction:2);
		fenv = Env([\freq.kr(120)*1.33333, \freq.kr(120)*1.125, \freq.kr(120)], [0.1, 0.5], -4).kr;
		sig = SinOsc.ar(fenv, pi/2);
		sig = Pan2.ar(sig * env * \amp.kr(1) * 0.6, 0);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\ht808, {
		var sig, fenv, env;
		env = EnvGen.kr(Env.new([0.4, 1, 0], [0, 11], -250),doneAction:2);
		fenv = Env([\freq.kr(165)*1.333333, \freq.kr(165)*1.121212, \freq.kr(165)], [0.1, 0.5], -4).kr;
		sig = SinOsc.ar(fenv, pi/2);
		sig = Pan2.ar(sig * env * \amp.kr(1) * 0.5, 0);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\lc808, {
		var sig, fenv, env, pnoise, penv;
		env = EnvGen.kr(Env.new([0.15, 1, 0], [0, 18], -250),doneAction:2);
		penv = EnvGen.kr(Env.new([0.6, 1, 0], [0, 30], -225),doneAction:2);
		fenv = Env([\freq.kr(165)*1.333333, \freq.kr(165)*1.121212, \freq.kr(165)], [0.1, 0.5], -4).kr;
		sig = SinOsc.ar(fenv, pi/2) * env;
		sig = Pan2.ar(sig * \amp.kr(1) * 0.5, 0);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\mc808, {
		var sig, fenv, env;
		env = EnvGen.kr(Env.new([0.15, 1, 0], [0, 9], -250),doneAction:2);
		fenv = Env([\freq.kr(250)*1.24, \freq.kr(250)*1.12, \freq.kr(250)], [0.1, 0.5], -4).kr;
		sig = SinOsc.ar(fenv, pi/2);
		sig = Pan2.ar(sig * env * \amp.kr(1) * 0.5, 0);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\hc808, {
		var sig, fenv, env;
		env = EnvGen.kr(Env.new([0.15, 1, 0], [0, 6], -250),doneAction:2);
		fenv = Env([\freq.kr(370)*1.22972, \freq.kr(370)*1.08108, \freq.kr(370)], [0.1, 0.5], -4).kr;
		sig = SinOsc.ar(fenv, pi/2);
		sig = Pan2.ar(sig * env * \amp.kr(1) * 0.5, 0);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\rim808, {
		var fenv, env, sig, punch, tri1, tri2;
		env = EnvGen.kr(Env.new([1, 1, 0], [0.00272, 0.07], -42), doneAction:2);
		tri1 = LFTri.ar(1667 * 1.1, 1) * env;
		tri2 = LFPulse.ar(455 * 1.1, width:0.8) * env;
		punch = WhiteNoise.ar * env * 0.46;
		sig = tri1 + tri2 + punch;
		sig = BPeakEQ.ar(sig, 464, 0.44, 8);
		sig = HPF.ar(sig, 315);
		sig = LPF.ar(sig, 7300);
		sig = Pan2.ar(sig * \amp.kr(1) * 0.3, 0);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\claves808, {
		var  env, sig;
		env = EnvGen.kr(Env.new([1, 1, 0], [0, 0.1], -20), doneAction:2);
		sig = SinOsc.ar(2500, pi/2) * env * \amp.kr(1) * 0.3;
		sig = Pan2.ar(sig, 0);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\maracas808, {
		var env, sig;
		env = EnvGen.kr(Env.new([0.3, 1, 0], [0.027, 0.07], -250), 1, doneAction:2);
		sig = WhiteNoise.ar * env * \amp.kr(1) * 0.2;
		sig = HPF.ar(sig, 5500);
		sig = Pan2.ar(sig, 0);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\cowbell808, {
		var sig, pul1, pul2, env, atk, atkenv, datk;
		atkenv = EnvGen.kr(Env.perc(0, 1, 1, -215),doneAction:0);
		env = EnvGen.kr(Env.perc(0.01, 9.5, 1, -90),doneAction:2);
		pul1 = LFPulse.ar(811.16);
		pul2 = LFPulse.ar(538.75);
		atk = (pul1 + pul2) * atkenv * 6;
		datk = (pul1 + pul2) * env;
		sig = (atk + datk) * \amp.kr(1) * 0.05;
		sig = HPF.ar(sig, 250);
		sig = LPF.ar(sig, 4500);
		sig = Pan2.ar(sig, 0);
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\hat808, {
		var sig, sighi,siglow, sum, env, osc1, osc2, osc3, osc4, osc5, osc6;
		env = EnvGen.kr(Env.perc(0.005, \decay.kr(0.42), 1, -30),doneAction:2);
		osc1 = LFPulse.ar(203.52);
		osc2 = LFPulse.ar(366.31);
		osc3 = LFPulse.ar(301.77);
		osc4 = LFPulse.ar(518.19);
		osc5 = LFPulse.ar(811.16);
		osc6 = LFPulse.ar(538.75);
		sighi = (osc1 + osc2 + osc3 + osc4 + osc5 + osc6);
		siglow = (osc1 + osc2 + osc3 + osc4 + osc5 + osc6);
		sighi = BPF.ar(sighi, 8900, 1);
		sighi = HPF.ar(sighi, 9000);
		siglow = BBandPass.ar(siglow, 8900, 0.8);
		siglow = BHiPass.ar(siglow, 9000, 0.3);
		sig = BPeakEQ.ar((siglow+sighi), 9700, 0.8, 0.7);
		sig = sig * env * \amp.kr(1) * 0.4;
		sig = Pan2.ar(sig, \pan.kr(0));
		Out.ar(0, sig);
	}).add;

	SynthDef.new(\hatOpen808, {
		var sig, siga, sigb, env1, env2, osc1, osc2, osc3, osc4, osc5, osc6, sum;
		env1 = EnvGen.kr(Env.perc(0.1, \decay.kr(0.5), curve:-3), doneAction:2);
		env2 = EnvGen.kr(Env.new([0, 1, 0], [0, \decay.kr(0.5)*5], curve:-150), doneAction:0);
		osc1 = LFPulse.ar(203.52) * 0.6;
		osc2 = LFPulse.ar(366.31) * 0.6;
		osc3 = LFPulse.ar(301.77) * 0.6;
		osc4 = LFPulse.ar(518.19) * 0.6;
		osc5 = LFPulse.ar(811.16) * 0.6;
		osc6 = LFPulse.ar(538.75) * 0.6;
		sig = osc1 + osc2 + osc3 + osc4 + osc5 +osc6;
		sig = BLowShelf.ar(sig, 990, 2, -3);
		sig = BPF.ar(sig, 7700);
		sig = BPeakEQ.ar(sig, 7200, 0.5, 5);
		sig = BHiPass4.ar(sig, 8100, 0.7);
		sig = BHiShelf.ar(sig, 9400, 1, 5);
		siga = sig * env1 * 0.6;
		sigb = sig * env2;
		sum = siga + sigb;
		sum = LPF.ar(sum, 4000);
		sum = Pan2.ar(sum, \pan.kr(0));
		sum = sum * \amp.kr(1)*3;
		Out.ar(0, sum);
	}).add;

	SynthDef.new(\cymbal808, {
		var sig, sig1,sig2, sig2a, sig2b, sig3, env1, env2, env2b, env3, osc1, osc2, osc3, osc4, osc5, osc6, sum;
		env1 = EnvGen.kr(Env.perc(0.3, \decay.kr(2), curve:-3), doneAction:2);
		env2 = EnvGen.kr(Env.new([0, 0.6, 0], [0.1, \decay.kr(2)*0.7], -5), doneAction:0);
		env2b = EnvGen.kr(Env.new([0, 0.3, 0], [0.1, \decay.kr(2)*20], -120), doneAction:0);
		env3 = EnvGen.kr(Env.new([0, 1, 0], [0, \decay.kr(2)*5], curve:-150), doneAction:0);
		osc1 = LFPulse.ar(203.52) * 0.6;
		osc2 = LFPulse.ar(366.31) * 0.6;
		osc3 = LFPulse.ar(301.77) * 0.6;
		osc4 = LFPulse.ar(518.19) * 0.6;
		osc5 = LFPulse.ar(811.16) * 0.6;
		osc6 = LFPulse.ar(538.75) * 0.6;
		sig = osc1 + osc2 + osc3 + osc4 + osc5 +osc6;
		sig1 = BLowShelf.ar(sig, 2000, 1, 5);
		sig1 = BPF.ar(sig1, 3000);
		sig1 = BPeakEQ.ar(sig1, 2400, 0.5, 5);
		sig1 = BHiPass.ar(sig1, 1550, 0.7);
		sig1 = LPF.ar(sig1, 3000);
		sig1 = BLowShelf.ar(sig1, 1000, 1, 0);
		sig1 = sig1 * env1 * \tone.kr(0.002);
		sig2 = BLowShelf.ar(sig, 990, 2, -5);
		sig2 = BPF.ar(sig2, 7400);
		sig2 = BPeakEQ.ar(sig2, 7200, 0.5, 5);
		sig2 = BHiPass4.ar(sig2, 6800, 0.7);
		sig2 = BHiShelf.ar(sig2, 10000, 1, -4);
		sig2a = sig2 * env2 * 0.3;
		sig2b = sig2 * env2b * 0.6;
		sig3 = BLowShelf.ar(sig, 990, 2, -15);
		sig3 = BPF.ar(sig3, 6500);
		sig3 = BPeakEQ.ar(sig3, 7400, 0.35, 10);
		sig3 = BHiPass4.ar(sig3, 10500, 0.8, 2);
		sig3 = sig3 * env3;
		sum = sig1 + sig2a + sig2b + sig3;
		sum = LPF.ar(sum, 4000);
		sum = Pan2.ar(sum, \pan.kr(0));
		sum = sum * \amp.kr(1)*4;
		Out.ar(0, sum);
	}).add;

	// TODO: granular

	//   __
	//  / _|_  __
	// | |_\ \/ /
	// |  _|>  <
	// |_| /_/\_\

	SynthDef(\input, {
		var sig;
		sig = In.ar(\in.ir(0), 2);
		Out.ar(\out.ir(0), sig);
	}).add;

	SynthDef(\samp, {
		var sig, env;
		sig = PlayBuf.ar(1, \buf.ir(0), BufRateScale.ir(\buf.ir(0)) * \rate.ir(1), 1, \spos.ir(0));
		env = Env(
			[0,1,1,0],
			[\atk.ir(0), \sus.ir(0.1), \rel.ir(0)],
			\lin
		).ar(2);
		sig = sig * env;
		sig = Pan2.ar(sig, \pan.ir(0), \amp.kr(0.3));
		Out.ar(\out.ir(0), sig);
		Out.ar(\auxOut.ir(0), sig * \auxAmp.ir(-30).dbamp);
	}).add;


	SynthDef(\reverb, {
		var sig, wet;
		sig = In.ar(\in.ir(0), 2);
		sig = GVerb.ar(in: sig, roomsize: \roomsize.kr(10), revtime: \revtime.kr(4), damping: \damping.kr(0.5), inputbw: \inputbw.kr(0.5),  spread: \spread.kr(15),  drylevel: \drylevel.kr(0),  earlyreflevel: \earlyreflevel.kr(0.7),  taillevel: \taillevel.kr(0.5),  maxroomsize: \maxroomsize.kr(300),  mul: \mul.kr(1),  add: \add.kr(0));
		// sig = FreeVerb2.ar(sig[0], sig[1], mix:0.5, room:0.99, damp:0.99);
		sig = LPF.ar(sig, 900);
		Out.ar(\out.ir(0), sig);
	}).add;

	SynthDef(\freeVerb,{
		| in=0, room=1, damp=0.05 |
		var sig;
		sig = In.ar(in, 2);
		sig = FreeVerb2.ar(sig[0],sig[1],1,room,damp);
		Out.ar(0, sig);
	}).add;

	SynthDef(\fbDelay,{
		|in=0, auxOut=0, delayTime=1.0, delayTimeLag=3, delayDecay=6,amp=1,auxAmp=0.5|
		var input, laggedDelayTime, outDelay, sig;
		input = In.ar(in,~channels);
		laggedDelayTime = Lag.kr(delayTime, delayTimeLag);
		sig = CombC.ar(input, 2, laggedDelayTime, delayDecay) + input;
		sig = sig.tanh;
		Out.ar(0,sig*amp);
		Out.ar(auxOut,sig*auxAmp);
	}).add;

	SynthDef(\wt,{
		|in=0, wt=0, auxOut=0, amp=1, auxAmp=0.5|
		var input, sig;
		input = In.ar(in,~channels);
		sig = Shaper.ar(wt, input);
		sig = sig.tanh;
		sig = sig * amp;
		Out.ar(0,sig);
		Out.ar(auxOut,sig*auxAmp);
	}).add;


	// ~bufPath = PathName.new(thisProcess.nowExecutingPath).parentPath ++ "calibration_tone/";

	// b = PathName.new(~bufPath).entries.collect({
	// arg pathname;
	// Buffer.read(s, pathname.fullPath);
	// });

	s.sync;

	ServerTree.add(~makeNodes);
	ServerTree.run;

	s.sync;

	//              _   _
	//  _ __   __ _| |_| |_ ___ _ __ _ __  ___
	// | '_ \ / _` | __| __/ _ \ '__| '_ \/ __|
	// | |_) | (_| | |_| ||  __/ |  | | | \__ \
	// | .__/ \__,_|\__|\__\___|_|  |_| |_|___/
	// |_|

	~beep = Pbind(
		\instrument, \sine,
		\dur, 2,
		\atk, 0,
		\sus, 0.02,
		\rel, 0.02,
		\freq, 1000,
		\amp, Pexprand(0.02, 0.2, inf),
		\pan, Pseq([-1, 0, 1, 0],inf),
		\out, 0,
		\auxOut, ~reverbBus,
		\auxAmp, -10,
	);

});
)

// (
// ~events[~count].value;
// ~count = ~count + 1;
// //if(~count >= ~events.size, {~count = 0});
// //~count;
// )

//////////////////////////////
//demonstration of ServerTree;

// ~fn = {"***rebuilt***".postln};

// ServerTree.add(~fn);

// s.reboot;

// ServerTree.remove(~fn);
// ServerTree.removeAll;
