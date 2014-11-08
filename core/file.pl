%% Vrijeme
%% file.pl
%- Author: Patrick


% System Memory
memory_file('.memory.vrij').


% Blueprint for a single reading
reading(humidity, seaSurfaceTemperature, airPressure, windSpeed).
% Get a reading 
% Combine each factor to get a complete reading (a list)
reading(Humidity, SeaSurfaceTemperature, AirPressure, WindSpeed,  
	[Humidity, SeaSurfaceTemperature, AirPressure, WindSpeed]). %- list of factors, ie. a reading


% saveReading/2 and saveReading/3
% Write a reading to system memory file.
saveReading(R):- saveReading(R, _).				%- bypass need to specify verbose flag
saveReading(Reading, Verbose):-
	memory_file(File),							%- get specified memory file name
	open(File, append, Stream),					%- open memory file
	write(Stream, Reading), write(Stream,'.'), 	%- write reading as a record to file
	nl(Stream),	close(Stream),					%- close memory file
	%- If verbose is specified write to console. [Debugging purpose]
	( Verbose == v -> ( 
		nl, write('Saving reading '), write(Reading), 
		write(' to "'), write(File), write('"...') ); write('') ). 


% loadReadings/1
% Get readings from memory file.
loadReadings(Readings):-
	memory_file(File),				%- get specified memory file name
    open(File, read, Stream),		%- open memory file
    read_file(Stream, Readings),	%- read memory file line by line
    close(Stream),					%- close memory file
    assert( readings(Readings) ). 	%- Save a volatile copy, for live use


% lastReading/1
% Get latest reading
lastReading(Reading):-
	loadReadings(Readings),
	last(Readings, Reading).


% read_file/2
% Read a file to the end
% ! Utility predicate.
read_file(Stream,[]) :-
    at_end_of_stream(Stream).		%- do nothing at EOF
read_file(Stream,[X|L]) :-				
    \+ at_end_of_stream(Stream),	%- not EOF
    read(Stream,X),					%- read line
    read_file(Stream, L).			


% Save everything in memory to file.
% ! Utility predicate.
dump_all(ToFile):-      
	telling(Old),      % current write output
	tell(ToFile),      % open this file
	listing,           % list all clauses in memory
	told,              % close ToFile
	tell(Old).         % resume this output