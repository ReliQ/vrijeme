% Author:
% Date: 07/11/2014

:- ensure_loaded([base, file, warnings]).

prediction:-
            getLines(Lines),
            revl([D1,D2,D3|T],Lines),
            conditions(D1,D2,D3,Level),
            write('conditions: '), write(Level), nl,
            wind_cat(D1,WeatherStatus),                  %testing for storms based on the wind speed
            write('weather status: '), write(WeatherStatus),nl,
            warning(WeatherStatus),nl,
            displayPrediction(Level),nl,
            displayConditions(D1,D2,D3).

             
conditions([H1,T1,P1,S1,M1], [H2,T2,P2,S2,M2], [H3,T3,P3,S3,M3], Level):-     %evaluates weather trends and determines weather conditions are decline or improving
                          HumidityChange is (H1-H2)+(H2-H3),         % 0 = stable weather(no changes)
                          TempChange is (T1-T2)+(T2-T3),             % 1 = improving weather (lowering temp, pressure, etc)
                          _PressureChange is (P1-P2)+(P2-P3),         % 2 = deteriorating weather (raising temp, speed, etc)
                          SpeedChange is (S1-S2)+(S2-S3),
                          MoistTempChange is (M1-M2)+(M2-M3),
                          ( (HumidityChange>0) ; (SpeedChange>0) ; (TempChange>0) ; (MoistTempChange>0) -> Level is 2;true),
                          ( (SpeedChange<0),(HumidityChange<0),(TempChange<0),(MoistTempChange<0)-> Level is 1; true),%check for good weather
                          ( (SpeedChange=:=0),(HumidityChange =:=0),(TempChange=:=0),(MoistTempChange=:=0)-> Level is 0; true),
                          ( (integer(Level)->true;Level is 3) ).  %check for normal weather ELSE mixed weather conditions

displayConditions([H1,T1,P1,S1,M1], [H2,T2,P2,S2,M2], [H3,T3,P3,S3,M3]):-
               HumidityChange is (H1-H2)+(H2-H3),         % 0 = stable weather(no changes)
               TempChange is (T1-T2)+(T2-T3),             % 1 = improving weather (lowering temp, pressure, etc)
               _PressureChange is (P1-P2)+(P2-P3),         % 2 = deteriorating weather (raising temp, speed, etc)
               SpeedChange is (S1-S2)+(S2-S3),
               MoistTempChange is (M1-M2)+(M2-M3),
               write('WEATHER CONDITIONS (LAST 3 DAYS)'),nl,
               write('Today'),nl,
               write('\tPressure: '),write(P1),
               write('\tSea Surface Temperature: '),write(T1),
               write('\tHumidity: '),write(H1),
               write('\tWind Speed: '),write(S1),
               write('\tAtmospheric Convection: '),write(M1),
               write('\tPressure: '),write(P1),nl,
               write('Yesterday'),nl,
               write('\tPressure: '),write(P2),
               write('\tSea Surface Temperature: '),write(T2),
               write('\tHumidity: '),write(H2),
               write('\tWind Speed: '),write(S2),
               write('\tAtmospheric Convection: '),write(M2),
               write('\tPressure: '),write(P2),nl,
               write('2 Days Prior'),nl,
               write('\tPressure: '),write(P3),
               write('\tSea Surface Temperature: '),write(T3),
               write('\tHumidity: '),write(H3),
               write('\tWind Speed: '),write(S3),
               write('\tAtmospheric Convection: '),write(M3),
               write('\tPressure: '),write(P3).

%displays prediction of whether the weather is improving, stable, deteriorating or mixed
displayPrediction(Level):-
     Level==0
             ->write('\tBased on the analysis, stable weather is predicted'),nl;
     Level==1
             ->write('\tBased on the analysis, Weather conditions are expected to improve'),nl;
     Level==2
             ->write('\tBased on the analysis, Wether conditions are expected to continue deteriorating'),nl;
     Level==3
             ->write('\tMixed weather conditions (see below)'),nl;true.

%reads all the lines of a file into a list of lists
getLines(L):-
   memory_file(X),
  setup_call_cleanup(    %setup & read from the file, then close
    open(X, read, In),
    readData(In, L),
    close(In)
  ).

%reads a line of data and appends it to the list until end_of_file is reached
readData(In, L):-
  read_term(In, H, []),
       ( H == end_of_file -> L = [] ; L = [H|T],
       readData(In,T)).

%reverses a list
revl([], []).
revl(R, [H|T]) :- revl(RT, T), append(RT, [H], R).
