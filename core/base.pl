%% Vrijeme
%% base.pl


system('Vrijeme - v0.0.1').     %System info

%humidity, averages from 4 cities at different times of day
humidity(Hum,Status):-
                 (Hum < 0.79)-> Status is 1;
                 (Hum > 0.830)-> Status is 2;
                 Status is 0.

%checks sea temperature, average is 27.74
seaTemperature(Temp,Status):-
                (Temp < 27)-> Status is 1;
                (Temp > 28)-> Status is 2;
                Status is 0.

%checks air pressure average is 1013.33 hPa (hectoPascal)
airPressure(Pressure, Status):-
                (Pressure < 1013)-> Status is 1;
                (Pressure > 1014)-> Status is 2;
                Status is 0.

% checks wind speed, average is 15. Measured in km/h
windSpeed(Speed, Status):-
                 (Speed < 15)-> Status is 1;
                 (Speed > 15.9)-> Status is 2;
                 Status is 0.
