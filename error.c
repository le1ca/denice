#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include "callbacks.h"
#include "globals.h"
#include "error.h"

// Handler for libircclient errors
void irc_error(irc_session_t* irc_session, int fatal){
	int err = irc_errno(irc_session);
	const char* errstr = irc_strerror(err);
	fprintf(stderr,"IRC error: %s (%d)\n", errstr, err);
	if(fatal){
		fprintf(stderr, "Fatal error... Exiting.\n");
		exit(1);
	}
}

// Print formatted error and if error is fatal, terminate
void error(int fatal, char* format, ...){
	char str[256];
	va_list args;
	va_start(args, format);
	// put the error msg in local array
	vsnprintf(str, 256, format, args);
	va_end(args);
	// print it out
	fprintf(stderr, "%s", str);
	
	if(fatal){
		fprintf(stderr,"Fatal error... Exiting.\n");
		exit(1);
	}
	else if(I && irc_is_connected(I)){
		// generate ERROR event to handle in scripts
		const char** strp = malloc(sizeof(char*));
		strp[0] = str;
		fprintf(stderr,"Generating ERROR event...\n");
		if(str[strlen(str)-1] == '\n')
			str[strlen(str)-1] = '\0';
		event_generic(I, "ERROR", "(core)", strp, 1);
		free(strp);
	}
	
}
