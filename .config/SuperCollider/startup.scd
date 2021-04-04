(
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
		Out.ar(\outfx.kr(0), sig * \send.kr(-30).dbamp);
	}).add;

	// SynthDef.new(\beep, {
	// var sig, env;
	// sig = SinOsc.ar(\freq.ir(1000));
	// env = Env(
	// [0,1,1,0],
	// [\atk.ir(0), \sus.ir(0.03), \rel.ir(0)],
	// [\atkcrv.ir(2),0,\relcrv.ir(-2)]
	// ).ar(2);
	// sig = sig * env;
	// sig = Pan2.ar(sig, \pan.ir(0), \amp.ir(0.3));
	// Out.ar(\out.ir(0), sig);
	// Out.ar(\outfx.ir(0), sig * \send.ir(-30).dbamp);
	// }).add;

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
		Out.ar(\outfx.ir(0), sig * \send.ir(-30).dbamp);
	}).add;


	SynthDef(\reverb, {
		var sig, wet;
		sig = In.ar(\in.ir(0), 2);
		sig = GVerb.ar(in: sig, roomsize: \roomsize.kr(10), revtime: \revtime.kr(4), damping: \damping.kr(0.5), inputbw: \inputbw.kr(0.5),  spread: \spread.kr(15),  drylevel: \drylevel.kr(0),  earlyreflevel: \earlyreflevel.kr(0.7),  taillevel: \taillevel.kr(0.5),  maxroomsize: \maxroomsize.kr(300),  mul: \mul.kr(1),  add: \add.kr(0));
		// sig = FreeVerb2.ar(sig[0], sig[1], mix:0.5, room:0.99, damp:0.99);
		sig = LPF.ar(sig, 900);
		Out.ar(\out.ir(0), sig);
	}).add;

	SynthDef(\input, {
		var sig;
		sig = In.ar(\in.ir(0), 2);
		Out.ar(\out.ir(0), sig);
	}).add;

	s.sync;

	// ~bufPath = PathName.new(thisProcess.nowExecutingPath).parentPath ++ "calibration_tone/";

	// b = PathName.new(~bufPath).entries.collect({
	// arg pathname;
	// Buffer.read(s, pathname.fullPath);
	// });

	s.sync;

	ServerTree.add(~makeNodes);
	ServerTree.run;

	s.sync;

	// PBINDS

	// ~sampPat = Pbind(
	// \instrument, \samp,
	// \dur, 1/8,
	// \type, Pwrand([\note, \rest], [0.6, 0.4], inf),
	// \buf, Prand(b, inf),
	// \rate, Pwhite(-12, 12, inf).midiratio,
	// \amp, Pexprand(0.02, 0.5, inf),
	// \atk, 0,
	// \sus, 0,
	// \rel, Pexprand(0.02, 0.5, inf),
	// \out, 0,
	// \outfx, ~reverbBus,
	// \send, Pwhite(-40, -10, inf),
	// );

	// ~beepPat = Pbind(
	// \instrument, \beep,
	// \dur, 2,
	// \atk, 0,
	// \sus, 0.02,
	// \rel, 0.02,
	// \freq, 1000,
	// \amp, Pexprand(0.02, 0.2, inf),
	// \pan, Pseq([-1, 0, 1, 0],inf),
	// \out, 0,
	// \outfx, ~reverbBus,
	// \send, -10,
	// );

	// ~dronesPat = Pbind(
	// \instrument, \beep,
	// \dur, 5,
	// \atk, 4,
	// \sus, 0,
	// \rel, 4,
	// \freq, Pexprand(150,300,inf) * Pfuncn({Array.rand(16, -1.0, 1.0).midiratio}, inf),
	// \amp, 0.02,
	// \out, 0,
	// \outfx, ~reverbBus,
	// \send, -10,
	// );

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
