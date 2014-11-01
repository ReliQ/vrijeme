%% Vrijeme
%% input.pl

humidityInput(Humidity):-
    write('Humidity (%): '), read(Humidity), 
    Humidity < 1. %- Ensure Humidity is less than 1
                
sstInput(Temperature):-
    write('Sea Temperature (°c): '), read(Temperature).
                
airPressureInput(Pressure):-
        write('Pressure (mb): '), read(Pressure).
                
windspeedInput(Speed):-
    write('Wind Speed (mph): '), read(Speed).
    
lapserateInput(MoistAirTemperaturerate):-
    write('Moist Ait Temperature rate of cooling (°c/km):'), read(MoistAirTemperaturerate).
    
    
collectReading(Humidity, SeaSurfaceTemperature, AirPressure, WindSpeed, MoistAirTemperaturerate):-
    write('New Reading...'), nl,
    humidityInput(Humidity), 
    sstInput(SeaSurfaceTemperature), 
    airPressureInput(AirPressure),
    windspeedInput(WindSpeed).
    lapserateInput(MoistAirTemperaturerate).