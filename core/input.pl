%% Vrijeme
%% input.pl

humidityInput(Humidity):-
    write('Humidity (%): '), read(Humidity), 
    Humidity < 1. %- Ensure Humidity is less than 1
                
sstInput(Temperature):-
    write('Sea Temperature (°c): '), read(Temperature).
                
airPressureInput(Pressure):-
    write('Pressure (mb): '), read(Pressure).
                
windSpeedInput(Speed):-
    write('Wind Speed (mph): '), read(Speed).
    
lapseRateInput(LapseRate):-
    write('Lapse Rate (°c/km): '), read(LapseRate).
    
    
collectReading(Humidity, SeaSurfaceTemperature, AirPressure, WindSpeed, LapseRate):-
    write('New Reading...'), nl,
    humidityInput(Humidity), 
    sstInput(SeaSurfaceTemperature), 
    airPressureInput(AirPressure),
    windSpeedInput(WindSpeed),
    lapseRateInput(LapseRate).