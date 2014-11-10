%% Vrijeme
%% file.pl
%- Author: Patrick


% System Memory
memory_file('.memory.vrij').


% Blueprint for a single reading
reading(humidity, seaSurfaceTemperature, airPressure, windSpeed, moistAirTemperature).
% Get a reading 
% Combine each factor to get a complete reading (a list)
reading(Humidity, SeaSurfaceTemperature, AirPressure, WindSpeed, MoistAirTemperature,
        [Humidity, SeaSurfaceTemperature, AirPressure, WindSpeed, MoistAirTemperature]). %- list of factors, ie. a reading


% saveReading/1, saveReading/2 and saveReading/3
% Write a reading to system memory file.
saveReading(R):- 
    memory_file(File),              %- get default memory file name
    saveReading(R, File).           %- bypass need to specify verbose flag
saveReading(R, File):- saveReading(R, File, _).
saveReading(Reading, File, Verbose):-
    open(File, append, Stream),                       	%- open memory file
    write(Stream, Reading), write(Stream,'.'),      	%- write reading as a record to file
    nl(Stream),     close(Stream),                     	%- close memory file
    %- If verbose is specified write to console. [Debugging purpose]
    ( Verbose == v -> ( 
            nl, write('Saving reading '), write(Reading), 
            write(' to "'), write(File), write('"...') ); write('') ). 


% loadReadings/1
% Get readings from memory file.
loadReadings(Readings):-
    memory_file(File),                              %- get specified memory file name
    open(File, read, Stream),           %- open memory file
    read_file(Stream, Readings),        %- read memory file line by line
    close(Stream),                                      %- close memory file
    assert( readings(Readings) ).       %- Save a volatile copy, for live use


% lastReading/1
% Get latest reading
lastReading(Reading):-
    loadReadings(Readings),                 %- load readings
    last(Readings, Reading).                %- get last   


% read_file/2
% Read a file to the end
% ! Utility predicate.
read_file(Stream,[]) :-
    at_end_of_stream(Stream).           %- do nothing at EOF
read_file(Stream,[X|L]) :-                              
    \+ at_end_of_stream(Stream),        %- not EOF
    read(Stream,X),                    	%- read line
    read_file(Stream, L).                       


% Save everything in memory to file.
% ! Utility predicate.
dump_all(ToFile):-      
    telling(Old),      % current write output
    tell(ToFile),      % open this file
    listing,           % list all clauses in memory
    told,              % close ToFile
    tell(Old).         % resume this output


% print first N items in list
% ! Utility predicate.
print_n(0, _) :- !.
print_n(_, []).
print_n(N, [H|T]) :- 
	write(H), nl, 
	N1 is N - 1, printN(N1, T). 