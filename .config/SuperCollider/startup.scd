(
~channels = 2;
// Array.withchannels = 2;
~count = 0;
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
	Out.ar(\auxOut.kr(0), sig * \auxAmp.kr(-30).dbamp);
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

SynthDef(\fm,{
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

SynthDef(\karplus,{
	|
	freq=440, noiseFreq=20000, out=0, auxOut=0, amp=0.2, auxAmp=0.0,
	sigAtt=0.000000001, sigRel=0.1, sigCrv=(-4),
	att=0.000000001, rel=5, crv=(-4),
	trigFreq=2.0, coef=0.5, mul=1.0, add=0.0,
	panAmp=1.0, panSpeed=0.125, panPhase=2, panWidth=2
	|
	var sig, sigEnv, env, karplus, trig, panMod;
	panMod = LFTri.kr(panSpeed,panPhase,panAmp);
	sig = LFNoise0.ar(freq);
	trig = Impulse.kr(trigFreq);
	sigEnv = Env([0,1,0],[sigAtt,sigRel],sigCrv).kr();
	env = Env([0,1,0],[att,rel],crv).kr(2);
	sig = sig * sigEnv;
	karplus = Pluck.ar(sig, trig, freq.reciprocal, freq.reciprocal, rel, coef, mul, add);
	karplus = karplus * env;
	karplus = Pan2.ar(karplus, panMod);
	Out.ar(out, karplus * amp);
	Out.ar(auxOut, karplus * auxAmp);
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
