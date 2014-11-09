% Author:
% Date: 07/11/2014

:- ensure_loaded([base, file]).

prediction:-
            memory_file(X),
            open(X, read, Source),
            read(Source, [H1,T1,P1,S1,M1]),          %reading values from file, H=humidity T=sea_temperature P=pressure S=wind_speed M=moist_airtemperature
            read(Source, [H2,T2,P2,S2,M2]),
            read(Source, [H3,T3,P3,S3,M3]),
            close(Source),
            conditions([H1,T1,P1,S1,M1], [H2,T2,P2,S2,M2], [H3,T3,P3,S3,M3], Conditions),
            write('conditions: '), write(Conditions), nl,
            wind_cat(S1,WeatherStatus,mph),                  %testing for storms based on the wind speed
            write('weather status: '), write(WeatherStatus),nl, %stormExists 1= there is a storm 0 = there is no storm
            (WeatherStatus =:= -1)->StormExists is 0; StormExists is 1,
             write('Storm exists?: '), write(StormExists).
             
readData([D|T],Source):-
                        read(Source,NewLine),
                        readData([T|NewLine],Source).
readData([],Source):-
              read(Source,NewLine),
              readData([NewLine]).

conditions([H1,T1,P1,S1,M1], [H2,T2,P2,S2,M2], [H3,T3,P3,S3,M3], Level):-     %evaluates weather trends and determines weather conditions are decline or improving
                          HumidityChange is (H1-H2)+(H2-H3),         % 0 = stable weather(no changes)
                          TempChange is (T1-T2)+(T2-T3),             % 1 = improving weather (lowering temp, pressure, etc)
                          _PressureChange is (P1-P2)+(P2-P3),         % 2 = deteriorating weather (raising temp, speed, etc)
                          SpeedChange is (S1-S2)+(S2-S3),
                          MoistTempChange is (M1-M2)+(M2-M3),
                        %  ( (SpeedChange>0) ; (HumidityChange>0) ; (TempChange>0) )->Level is 2;true
                          ( (SpeedChange>0) -> Level is 2 ; true), %check for bad weather
                          ( (HumidityChange>0) -> Level is 2 ; true),
                          ( (TempChange>0) -> Level is 2 ; true),
                          ( (MoistTempChange>0) -> Level is 2 ; true),
                          ( (SpeedChange<0)->(HumidityChange<0)->(TempChange<0)-> Level is 1; true),%check for good weather
                          ( (SpeedChange =:=0) -> (HumidityChange =:=0)->(TempChange=:=0)-> Level is 0; true).  %check for normal weather
