%% Vrijeme
%% base.pl
%- Authors: Ashani, Patrick

system('Vrijeme').     %System info
welcomeMessage('Welcome to Vrijeme. Weather prediction in Prolog!').


%humidity, averages from 4 cities at different times of day. humidity is a percentage
humidity(Hum,Status):-
    (Hum < 0.79)-> Status is 1;
    (Hum > 0.830)-> Status is 2;
    Status is 0.

%checks sea temperature, average is 27.74. measured in degrees celsius
seaTemperature(Temp,Status):-
    (Temp < 27)-> Status is 1;
    (Temp > 28)-> Status is 2;
    Status is 0.

%checks air pressure average is 1013.33 hPa (hectoPascal)
airPressure(Pressure, Status):-
    (Pressure < 1013)-> Status is 1;
    (Pressure > 1014)-> Status is 2;
    Status is 0.

% checks wind speed, average is 15. Measured in km/h. 
% Wind speed average set higher to represent storms & account for windy days
windSpeed(Speed, Status):-
    (Speed < 15) -> Status is 1;
    (Speed > 35) -> Status is 2;
    Status is 0.



% Checks the difference in dry airtemperatures and moist air temperatures to be greater than 20 degrees to determine
% if moist air convection is present which leads to instability
moistAirConvection(Lapserate,Status):-
    (Lapserate > 20) -> Status is 1;
     Status is 0.

% Instability means that condensation will occur and cumulonimbus clouds are formed. A tropical disturbance is born,
% the first stage of a developing hurricane.
thunderstorm(Condensation,Status):- 
    (Condensation = 1)-> Status is 1;
    (Condensation = 0)-> Status is 0.
                                 


% wind_cat/3 - wind prediction
% Get hurricane category prediction based on wind speed only.
% Windspeed in mph
wind_cat([_,_,_,S1,_], Category, Unit):-
    member(Unit, [kmh,mph]),
    ( (Unit == kmh -> wind_cat((S1*0.621371), Category, mph) );      %-- unit conversion
    S1 < 39                          %-- Normal
        -> Category is -1;
    between(39, 73, S1)              %-- Tropical Storm
        -> Category is 0;                       
    between(74, 95, S1)              %-- Tropical Cyclone/Hurricane
        -> Category is 1;
    between(96, 110, S1)
        -> Category is 2;
    between(111, 130, S1)
        -> Category is 3;
    between(131, 155, S1)
        -> Category is 4;
    S1 > 155
        -> Category is 5 ).
% wind_cat/2 - No-unit shorthand: wind prediction
wind_cat(WindSpeed, Category):- wind_cat(WindSpeed, Category, mph).
wind_cat([H1,T1,P1,S1,M1],Category):- wind_cat([H1,T1,P1,S1,M1],Category,mph).



% sst_threat/3 - Sea Surface Temp (SST) prediction
% Get pseudo prediction based on sea surface temp. A SST of > 25.6°c 
% is integral to the formation of a hurricane.
% - Temp:       SST value
% - Threat: 1 or 0; likeliness to lead to hurricane.
% - Unit:       c (celcius) or f (fahrenheit)  
sst_threat(Temp, Threat, Unit):-
    member(Unit, [c,f]),
    ( (Unit == f -> sst_threat( ((Temp-32)*5/9) , Threat, c) );     %-- unit conversion
      (Temp >= 26.5 -> Threat is 1; Threat is 0) ).
% sst_threat/2 - No-unit shorthand: SST prediction
sst_threat(Temp, Threat):- sst_threat(Temp, Threat, c).



% atp_judgement/2 - Atmospheric Pressure Judgement
% Pressure in millibar (mb) or hectoPascal (hPa) 
atp_judgement(Pressure, Judgement):-
    Pressure < 1000 
        -> Judgement = 'low';
    between(1000, 1014, Pressure) 
        -> Judgement = 'ok';
    Judgement = 'high'. 