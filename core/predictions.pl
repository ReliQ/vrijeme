% Author:
% Date: 07/11/2014

:- ensure_loaded([base, file, warnings]).

prediction:-
            %memory_file(X),
            %open(X, read, Source),
            %read(Source, [H1,T1,P1,S1,M1]),          %reading values from file, H=humidity T=sea_temperature P=pressure S=wind_speed M=moist_airtemperature
            %read(Source, [H2,T2,P2,S2,M2]),
            %read(Source, [H3,T3,P3,S3,M3]),
            %close(Source),
            %getLines([[H1,T1,P1,S1,M1],[H2,T2,P2,S2,M2],[H3,T3,P3,S3,M3]]),
            getLines(Lines),
            revl([D1,D2,D3|T],Lines),
            conditions(D1,D2,D3,Level),
            %conditions([H1,T1,P1,S1,M1], [H2,T2,P2,S2,M2], [H3,T3,P3,S3,M3], Level),
            write('conditions: '), write(Level), nl,
            wind_cat(D1,WeatherStatus),                  %testing for storms based on the wind speed
            write('weather status: '), write(WeatherStatus),nl. %stormExists 1= there is a storm 0 = there is no storm
            %(WeatherStatus =:= -1)->StormExists is 0; StormExists is 1,
            %write('Storm exists?: '), write(StormExists).
             
conditions([H1,T1,P1,S1,M1], [H2,T2,P2,S2,M2], [H3,T3,P3,S3,M3], Level):-     %evaluates weather trends and determines weather conditions are decline or improving
                          HumidityChange is (H1-H2)+(H2-H3),         % 0 = stable weather(no changes)
                          TempChange is (T1-T2)+(T2-T3),             % 1 = improving weather (lowering temp, pressure, etc)
                          _PressureChange is (P1-P2)+(P2-P3),         % 2 = deteriorating weather (raising temp, speed, etc)
                          SpeedChange is (S1-S2)+(S2-S3),
                          MoistTempChange is (M1-M2)+(M2-M3),
                          ( (HumidityChange>0) ; (SpeedChange>0) ; (TempChange>0) ; (MoistTempChange>0) -> Level is 2;true),
                          ( (SpeedChange<0)->(HumidityChange<0)->(TempChange<0)->(MoistTempChange<0)-> Level is 1; true),%check for good weather
                          ( (SpeedChange=:=0),(HumidityChange =:=0),(TempChange=:=0),(MoistTempChange=:=0)-> Level is 0; Level is 3).  %check for normal weather ELSE mixed weather conditions

displayConditions([H1,T1,P1,S1,M1], [H2,T2,P2,S2,M2], [H3,T3,P3,S3,M3]):-
               HumidityChange is (H1-H2)+(H2-H3),         % 0 = stable weather(no changes)
               TempChange is (T1-T2)+(T2-T3),             % 1 = improving weather (lowering temp, pressure, etc)
               _PressureChange is (P1-P2)+(P2-P3),         % 2 = deteriorating weather (raising temp, speed, etc)
               SpeedChange is (S1-S2)+(S2-S3),
               MoistTempChange is (M1-M2)+(M2-M3),
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
               
               

getLines(L):-
   memory_file(X),
  setup_call_cleanup(
    open(X, read, In),
    readData(In, L),
    close(In)
  ).

readData(In, L):-
  read_term(In, H, []),
       ( H == end_of_file -> L = [] ; L = [H|T],
       readData(In,T)).
  
revl([], []).
revl(R, [H|T]) :- revl(RT, T), append(RT, [H], R).
