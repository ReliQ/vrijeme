%% Vrijeme
%% input.pl

humidityInput(Humidity, Status):-
    write('Humidity:'), read(Humidity), write('%').
                
sstInput(Temperature, Status):-
    nl, write('Sea Temperature:'), read(Temperature), write('C').
                
airPressureInput(Pressure, Status):-
	nl, write('Pressure:'), read(Pressure).
                
windspeedInput(Speed, Status):-
    nl, write('Wind Speed (mph):'), read(Speed).
    
getInput:-
    write('get inputs').