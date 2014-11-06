%% Vrijeme
%% base.pl
%- Author: Patrick Reid

system('Vrijeme - v0.0.1'). 	%System info



% wind_cat/3 - wind prediction
% Get hurricane category prediction based on wind speed only.
% Windspeed in mph
wind_cat(WindSpeed, Category, Unit):-
	member(Unit, [kmh,mph]),
	( (Unit == kmh -> wind_cat((WindSpeed*0.621371), Category, mph) );	%-- unit conversion
	WindSpeed < 39					%-- Normal
		-> Category is -1;
	between(39, 73, WindSpeed) 		%-- Tropical Storm
		-> Category is 0;			
	between(74, 95, WindSpeed) 		%-- Tropical Cyclone/Hurricane
		-> Category is 1;
	between(96, 110, WindSpeed)	
		-> Category is 2;
	between(111, 130, WindSpeed) 
		-> Category is 3;
	between(131, 155, WindSpeed) 
		-> Category is 4;
	WindSpeed > 155
		-> Category is 5 ).
% wind_cat/2 - No-unit shorthand: wind prediction
wind_cat(WindSpeed, Category):- wind_cat(WindSpeed, Category, mph).



% sst_threat/3 - Sea Surface Temp (SST) prediction
% Get pseudo prediction based on sea surface temp. A SST of > 25.6°c 
% is integral to the formation of a hurricane.
% - Temp: 	SST value
% - Threat: 1 or 0; likeliness to lead to hurricane.
% - Unit: 	c (celcius) or f (fahrenheit)  
sst_threat(Temp, Threat, Unit):-
	member(Unit, [c,f]),
	( (Unit == f -> sst_threat( ((Temp-32)*5/9) , Threat, c) );	%-- unit conversion
	  (Temp >= 26.5 -> Threat is 1; Threat is 0) ).
% sst_threat/2 - No-unit shorthand: SST prediction
sst_threat(Temp, Threat):- sst_threat(Temp, Threat, c).



% atp_judgement/2 - Atmospheric Pressure Judgement
% Pressure in millibar (mb) or hectoPascal (hp) 
atp_judgement(Pressure, Judgement):-
	Pressure < 1000 
		-> Judgement = 'low';
	between(1000, 1014, Pressure) 
		-> Judgement = 'ok';
	Judgement = 'high'. 
	