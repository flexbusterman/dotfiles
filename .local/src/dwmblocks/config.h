//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
  /*Icon*/  /*Command*/   /*Update Interval*/ /*Update Signal*/
	// {"",  "dropbox", 5,  0},
	//
	{"",	"face",	1,	16},
	{"",	"mailbox",	5,	12},
	{"",	"nettraf",	1,	16},
	// {"",	"deadbeef",	10,	0},
  {"",  "internet", 20,  4},
	{"",  "disk", 15,  5},
  {"",  "memory", 10, 18},
  {"",  "cpu",    1, 18},
	{"",	"volume",	0,	10},
  {"",  "battery",  5,  3},
	{"",	"clock",	60,	1},
	/* {"",	"music",	0,	11},*/
	// {"",	"pacpackages",	0,	8},
	//{"",	"news",		0,	6},
	/* {"",	"crypto",	0,	13}, */
	//{"",	"torrent",	20,	7},
	/* {"",	"moonphase",	18000,	17}, */
	//{"",	"weather",	18000,	5},
	//{"",	"help-icon",	0,	15},
  //	{"", "cat /tmp/recordingicon 2>/dev/null",	0,	9},
	/* {"",	"price bat \"Basic Attention Token\" 🦁",	0,	20}, */
	/* {"",	"price btc Bitcoin 💰",				0,	21}, */
	/* {"",	"price lbc \"LBRY Token\" 📚",			0,	22}, */
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char *delim = "│";

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
