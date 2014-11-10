%%      Vrijeme - v0.0.1
%%      main.pl 

:- [base, file, input, predictions].


run:-
    nl, welcomeMessage(WelcomeMessage),
    write(WelcomeMessage), nl, write('Select Option:'), nl,
    write('1. Information Input'), nl, write('2. View current data'), nl,
    write('3. Get latest Prediction'), nl, write('4. Exit'), nl,
    write('-| Choice: '), read(Choice), doOption(Choice).
      
      
doOption(Choice):-
    integer(Choice),
    (
        Choice == 1 -> (
                infoInput
        );
        Choice == 2 -> (
                currentData
        );
        Choice == 3 -> (
                prediction
        );
        Choice == 4 -> (
                write('Goodbye...'), nl, halt
        ); run
    ).

currentData:-
        loadReadings(Readings),
        nl, write('History: '), write(Readings).

infoInput:-
        collectReading(Hum, SST, AP, WS, MT),
        reading(Hum, SST, AP, WS, MT, Reading),
        saveReading(Reading).