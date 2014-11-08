% Author:
% Date: 11/8/2014

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

collectReading(Humidity, Temperature, Pressure, Speed, LapseRate):-
    write('New Reading...'), nl,
    humidityInput(Humidity),
    sstInput(Temperature),
    airPressureInput(Pressure),
    windSpeedInput(Speed),
    lapseRateInput(LapseRate).