%%      Vrijeme - v0.0.1
%%      main.pl 

:- [base, file, input, predictions].


run:-
    nl, welcomeMessage(WelcomeMessage),
    write(WelcomeMessage), nl, write('Select Option:'), nl,
    write('1. Information Input'), nl, write('2. View current data'), nl,
    write('3. Get latest Prediction'), nl, write('4. Exit'), nl,
    write('-| Choice: '), read(Choice), doOption(Choice), nl, run.
      
      
doOption(Choice):-
    integer(Choice),
    (
        Choice == 1 -> (
                collectReading(Hum, SST, AP, WS, MT),
                reading(Hum, SST, AP, WS, MT, Reading),
                saveReading(Reading)
        );
        Choice == 2 -> (
                loadReadings(Readings),
                write('History: '),
                write(Readings)
        );
        Choice == 3 -> (
                prediction
        );
        Choice == 4 -> (
                write('Goodbye...'), nl, halt
        ); run
    ).